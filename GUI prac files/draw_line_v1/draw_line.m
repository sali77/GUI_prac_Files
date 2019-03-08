function draw_line(fh, ah)
% DRAW_LINE(FH, AH) draws a line on an existing axes interactively. 
% 
% Input: 
%   fh - handle of the figure that contains the axes 
%   ah - handle of the axes to be drawn on 
%
% Wei Shang 
% wei.shang@unb.ca 
% University of New Brunswick 

% get the boundaries on the axes 
x_bounds = get(ah, 'xlim');  y_bounds = get(ah, 'ylim');
% enter line drawing mode by attaching buttonDown function
set(fh, 'WindowButtonDownFcn', @buttonDown);

    function buttonDown(fh, dummy)
        % This function is called when the mouse button is pressed. 
        % It will create a line object based on the location of where the
        % button pressed action occured. 
        
        % get the location of the action 
        p = get(ah,'currentpoint');
        x1 = p(1,1); y1 = p(1,2);
        % create a line object that starts and ends at the same point. 
        lh = line([x1,x1], [y1,y1], 'linestyle', ':');
        % atttach buttonMove function 
        set(fh,'WindowButtonMotionFcn',@buttonMove);
        % attach buttonUp function
        set(fh,'WindowButtonUpFcn', @buttonUp);
        
        function buttonMove(fh, dummy)
            % This function is called when the mouse button moved while
            % being pressed. 
            
            % obtain end points of the line 
            X = get(lh,'XData'); Y = get(lh,'YData');
            
            % obtain new points as the new mouse pointer location 
            p = get(ah,'currentpoint');
            x2 = p(1,1); y2 = p(1,2);
            
            % check and make sure they are within the bounds, if not force
            % the end point to be within the bound 
            if x2 < x_bounds(1)
                x2 = x_bounds(1);
            elseif x2 > x_bounds(2);
                x2 = x_bounds(2);
            end
            
            if y2 < y_bounds(1)
                y2 = y_bounds(1);
            elseif y2 > y_bounds(2)
                y2 = y_bounds(2);
            end
            
            % update the line object with the 
            X(2) = x2;   Y(2) = y2;
            set(lh, 'XData', X, 'YData', Y);
            
        end % ends buttonMove function 
        
        function buttonUp(fh, dummy)
            % This function finalize the line object and ends line drawing
            % mode. 
            
            % set line object's line style to solid line 
            set(lh,'linestyle','-');
            
            % set various mouse actions to null
            set(fh, 'WindowButtonMotionFcn', '');
            set(fh, 'WindowButtonUpFcn', '');
            set(fh, 'WindowButtonDownFcn', '');
            
        end % ends buttonUp function 
        
    end % ends buttonDown function 

end % ends draw_line function