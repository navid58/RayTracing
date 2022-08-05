% This code is an example for solving 2D ray equations using MATLAB
% ODE solver. 
% The original code is in Python developed by Matteo Ravasi can be fount
% in:
% https://github.com/DIG-Kaust/Seismology/tree/main/RayTrace
%
% Converted from Python to MATLAB by: Navid Amini
% email: amini[underline]navid[at]yahoo[dot]com


clc, clear

% Spatial axes
dx = 100;
dz = 100; 
x = 0:dx:60000-dx;
z = 0:dz:30000-dx;

[xx, zz]= meshgrid(x, z);

% Velocity model
vel = 1000 + 0.032 * zz;

% Source location
ixs = 300;
izs = 1;
source = [x(ixs), z(izs)]; 

% Take off angles
thetas = -60:10:60;

% Vector of lengths
lstep = [0 1e5];

imagesc(x/1000,z/1000,vel), colormap gray; colorbar
hold on

% Raytrace
raytrace(vel, x, z, dx, dz, lstep, source, thetas, ixs, izs);

axis equal, axis tight
xlabel('x (Km)')
ylabel('z (Km)')
