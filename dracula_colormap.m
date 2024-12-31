function dracula_colormap(varargin)
%Applies the Dracula color map to the current axes.
%
%OPTIONAL NAME-VALUE PAIRS
% Order :: Sets the order of the colormap {"normal" (default) | "reversed"}
%
%
%Example 1
% surf(membrane)
% dracula_colormap
%
%Example 2
% surf(membrane)
% dracula_colormap(Order='reverse')
%
%
%See also
% draculize dracula_colororder

% (C) Austin M. Weber 2024

% Parse the user inputs
p = inputParser;
defaultOrder = 'normal';
addParameter(p, 'Order', defaultOrder, @(x) ischar(x) || isstring(x));
parse(p, varargin{:});
order = lower(p.Results.Order);

% Define color map
load("dracula.mat","dracula_cmap")
switch order
    case 'normal'
        cmap = dracula_cmap;
    case 'reverse'
        cmap = flipud(dracula_cmap);
    otherwise
        error('Order must be set to either ''normal'' or ''reverse''.')
end

% Assign color map to current axes
colormap(gca,cmap)

end