clc
clear

rgbImage =imread ('C:\Users\Shafaat\Dropbox\Clifford_Lab_MATLAB\GUI\Shafaat_try_GUI\lab_pic\lab.png');
imshow(rgbImage)
[croppedImage, xCoords, yCoords] = CropImage1(rgbImage);
%%
function [croppedImage, xCoords, yCoords] = CropImage1(rgbImage)
  k = waitforbuttonpress;
  point1 = get(gca,'CurrentPoint');    % button down detected
  finalRect = rbbox;                   % return figure units
  point2 = get(gca,'CurrentPoint');    % button up detected
  point1 = point1(1,1:2);              % extract x and y
  point2 = point2(1,1:2);
  p1 = min(point1,point2);             % calculate locations
  offset = abs(point1-point2);         % and dimensions
  
  xCoords = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
  yCoords = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
  x1 = round(xCoords(1));
  x2 = round(xCoords(2));
  y1 = round(yCoords(5));
  y2 = round(yCoords(3));
  hold on
  axis manual
  plot(xCoords, yCoords); % redraw in dataspace units  
  drawnow;
  croppedImage = rgbImage(y1:y2,x1:x2,:);
end