function  raytrace(vel, xaxis, zaxis, dx, dz, lstep, source, thetas, ixs, izs)

%%%   Raytracing for multiple rays defined by the initial conditions (source, thetas)
%     
%     Parameters
%     ----------
%     vel : 2D Velocity model (nz x nx)
%     xaxis : Horizonal axis 
%     zaxis : Vertical axis 
%     dx : Horizonal spacing 
%     dz : Vertical spacing 
%     lstep : Ray lenght axis
%     source : Source location
%     thetas : Take-off angles
%
% The original code is in Python developed by Matteo Ravasi can be found
% in:
% https://github.com/DIG-Kaust/Seismology/tree/main/RayTrace
%
% Converted from Python to MATLAB by: Navid Amini
% email: amini[underline]navid[at]yahoo[dot]com


% Slowness and its spatial derivatives
slowness = 1./vel;
[dsdx, dsdz] = gradient(slowness, dx, dz);

options = odeset('Events',@(l,r) events_ray(l, r, xaxis, zaxis));

for i = 1:length(thetas)
    
    % Initial condition
    theta = thetas(i);
    r0 = [source(1); source(2) ; ...
         sin(theta * pi / 180) / vel(izs, ixs); ...
         cos(theta * pi / 180) / vel(izs, ixs); slowness(izs, ixs)];
    
    % Solve ODE
    [~,r] = ode45(@(l,r) rhsf(l, r, slowness, dsdx, dsdz, xaxis, zaxis, dx, dz), ...
                       [lstep(1), lstep(end)], r0, options);
    
    % Plot ray
    plot(r(:,1)/1000, r(:,2)/1000 ,'r')
    hold on
end
