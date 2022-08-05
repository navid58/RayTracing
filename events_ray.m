function [value,isterminal,direction] = events_ray(l, r, xaxis, zaxis)

% The original code is in Python developed by Matteo Ravasi can be found
% in:
% https://github.com/DIG-Kaust/Seismology/tree/main/RayTrace
%
% Converted from Python to MATLAB by: Navid Amini
% email: amini[underline]navid[at]yahoo[dot]com

value = [r(1)-xaxis(1); xaxis(end)-r(1); r(2)-zaxis(1); zaxis(end)-r(2)];
isterminal = [1;1;1;1];
direction = [-1;-1;-1;-1];
