function  drdt = rhsf(l, r, slowness, dsdx, dsdz, xaxis, zaxis, dx, dz)

%%%   RHS of raytracing ODE

%     Parameters
%     ----------
%     r : dependent variable containing (x, z, px, pz, t)
%     l : indipendent variable l
%     slowness : slowness 2d model
%     dsdx : horizontal derivative of slowness 2d model
%     dsdz : vertical derivative of slowness 2d model
%     xaxis : horizontal axis
%     zaxis : vertical axis
%     dx : horizontal spacing
%     dz : vertical spacing
%
%     Returns
%     -------
%     drdt : RHS evaluation
%
% The original code is in Python developed by Matteo Ravasi can be found
% in:
% https://github.com/DIG-Kaust/Seismology/tree/main/RayTrace
%
% Converted from Python to MATLAB by: Navid Amini
% email: amini[underline]navid[at]yahoo[dot]com


[m, n] = size(slowness);

% extract the different terms of the solution
x = r(1);
z = r(2);
px = r(3);
pz = r(4);
drdt = zeros(length(r),1);

% identify current position of the ray in the model
xx = round( (x - xaxis(1)) / dx );
zz = round( (z - zaxis(1)) / dz );
xx = min([xx, n-1]);
xx = max([xx, 1]);
zz = min([zz, m-1]);
zz = max([zz, 1]);

% extract s, ds/dx, ds/dz at current position (nearest-neighbour interpolation)
s = slowness(round(zz), round(xx));
dsdx = dsdx(round(zz), round(xx));
dsdz = dsdz(round(zz), round(xx));

% evaluate RHS
drdt(1) = px/s;
drdt(2) = pz/s;
drdt(3) = dsdx;
drdt(4) = dsdz;
drdt(5) = s;
