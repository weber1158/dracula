% This script shows how the Dracula color gradient is calculated and
% produces a visualization.

close all
clear,clc

% Dracula colors as RGB triplets, in rainbow order
rgb_codes_reordered = [1.0000	0.4745	0.7765
    0.7412	0.5765	0.9765
    0.5451	0.9137	0.9922
    0.3137	0.9804	0.4824
    0.9451	0.9804	0.5490
    1.0000	0.7216	0.4235
    1.0000	0.3333	0.3333];

% Generate the Dracula gradient colormap
num_gradient_colors = 255;
dracula_colormap = zeros(num_gradient_colors, 3);

% Create equally spaced positions for the 7 original colors
num_original_colors = size(rgb_codes_reordered,1);
positions = round(linspace(1, num_gradient_colors, num_original_colors));

% Assign the original colors to the specified positions in the gradient
dracula_colormap(positions, :) = rgb_codes_reordered;

% Interpolate the remaining positions to create the gradient
for i = 1:3  % Iterate over R, G, B channels
    nonzero_positions = find(dracula_colormap(:, i) == 0);
    dracula_colormap(nonzero_positions, i) = interp1(positions, rgb_codes_reordered(:, i), nonzero_positions, 'linear');
end

% Display example figure using the new colormap
figure;
[X,Y] = meshgrid(-8:.5:8);
R = sqrt(X.^2 + Y.^2) + eps;
Z = sin(R)./R;
s=mesh(X,Y,Z); title('DRACULA','FontName','Consolas','FontSize',14)
s.FaceColor='interp';
s.EdgeColor=[0.5 0.5 0.5];
colormap(dracula_colormap);
colorbar;

% Copyright 2024 Austin M Weber