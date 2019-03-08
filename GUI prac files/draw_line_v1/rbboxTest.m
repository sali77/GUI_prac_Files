function rbboxTest

% Generating example 2-D plot
hfig = figure;
hax = axes;
xdata = 1:100;
ydata = sin(xdata);
hline = line(xdata,ydata,'Marker','o');

set(hax,'ButtonDownFcn',@OnClickAxes);


end

function OnClickAxes( hax, evt )

point1 = get(hax,'CurrentPoint'); % corner where rectangle starts ( initial mouse down point )
rbbox
point2 = get(hax,'CurrentPoint'); % corner where rectangle stops ( when user lets go of mouse )

% Now lets iterate through all lines in the axes and extract the data that lies within the selected region
allLines = findall(hax,'type','line');
for n = 1:length(allLines)

   [dataInRect,dataInd] = getDataInRect( point1(1,1:2), point2(1,1:2), allLines(n) ); % not interested in z-coord

   % TODO: do something with dataInRect or dataInd
   dataInRect
   
end

end

function [dataInRect,dataInd] = getDataInRect( p1, p2, hline )

% Define low and high x and y values, rbbox will reverse them if you draw rectangle from bottom up
if ( p1(1) < p2(1) )
   lowX = p1(1); highX = p2(1);
else
   lowX = p2(1); highX = p1(1);
end

if ( p1(2) < p2(2) )
   lowY = p1(2); highY = p2(2);
else
   lowY = p2(2); highY = p1(2);
end

xdata = get(hline,'XData');
ydata = get(hline,'YData');

xind = (xdata >= lowX & xdata <= highX);
yind = (ydata >= lowY & ydata <= highY);

dataInd = xind & yind; % these are the indices in xdata and ydata where the points lie within the rectangle
dataInRect = [xdata(dataInd);ydata(dataInd)]'; % this returns all of the data inside the rect in one 2xN matrix

end