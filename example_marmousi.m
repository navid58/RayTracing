% This code is an example for solving 2D ray equations using MATLAB
% ODE solver. 
% The original code is in Python developed by Matteo Ravasi can be fount
% in:
% https://github.com/DIG-Kaust/Seismology/tree/main/RayTrace
%
% Converted from Python to MATLAB by: Navid Amini
% email: amini[underline]navid[at]yahoo[dot]com

clc, clear

% load Marmousi model
load('Marmousi_vp.mat');
vel = MARM_vp;

dx = 25; 
dz = 25;

[nz,nx] = size(vel);
x = (0:nx-1)*dx;
z = (0:nz-1)*dx;

% Smooth velocity model
vel = imgaussfilt(vel,4);

% Source location
ixs = 1000;
izs = 1;
source = [x(ixs), z(izs)]; 

% Take off angles
thetas = -30:5:30;

% Vector of lengths
lstep = [0, 1e5];

imagesc(x/1000,z/1000,vel), colormap gray
hold on

% Raytrace
raytrace(vel, x, z, dx, dz, lstep, source, thetas, ixs, izs)

axis equal, axis tight
axis equal, axis tight
xlabel('x (Km)')
ylabel('z (Km)')
