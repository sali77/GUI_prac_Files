function [rect] = dragbox(unitsval)
% DRAGBOX
%
% Usage:
%          [rect] = dragbox(units_string);
% where,
%
% rect:         is the RECT vector over which the
%               drag box is defined ([left bottom width height]).
% units_string: is a string containing the name
%               of any of the legal units that
%               the figure can have.
%
% Example
%          figure
%          [rect] = dragbox('normalized')
% Wait for mouse button to be pressed.
waitforbuttonpress;

% Determine figure and get its Units.
h_fig = gcf;
original_figunits = get(h_fig,'Units');

% Specify Pixels for units and get location at
% which mouse button is pressed.
set(h_fig,'Units','Pixels');
firstpoint = get(h_fig,'CurrentPoint');

% Create the drag box.
rbbox([firstpoint 0 0],firstpoint);

% Get the location at which button is released.
lastpoint = get(h_fig,'CurrentPoint');

% Calculate a standard rect vector from two locations.
rect = [min(firstpoint,lastpoint),abs(firstpoint-lastpoint)];

% Normalize the rect vector to the figure.
figpos = get(h_fig,'Position');
rect = rect./[figpos(3:4) figpos(3:4)];

% Put the rect vector in the specified units.
if nargin == 0
   unitsval = original_figunits;
end

if ~strcmp(lower(unitsval(1)),'n')
  set(h_fig,'Units',unitsval);
  figpos = get(h_fig,'Position');
  rect = rect.*[figpos(3:4) figpos(3:4)];
end

% Put the figure back in the original units.
set(h_fig,'Units',original_figunits);
