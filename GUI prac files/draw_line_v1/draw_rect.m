function draw_rect(fh, ah)
x_bounds = get(ah, 'xlim');  y_bounds = get(ah, 'ylim');
min_w = (x_bounds(2) - x_bounds(1))/1000;
min_h = (y_bounds(2) - y_bounds(1))/1000;
set(fh, 'WindowButtonDownFcn', @buttonDown);

    function buttonDown(fh, dummy)
        p = get(ah,'currentpoint');
        x1 = p(1,1); y1 = p(1,2);
        rh = rectangle('position', [x1,y1, min_w, min_h],'linestyle', ':');
        set(fh,'WindowButtonMotionFcn',@buttonMove);
        set(fh,'WindowButtonUpFcn', @buttonUp);
        
        function buttonMove(fh, dummy)
            
            p = get(ah,'currentpoint');
            x2 = p(1,1); y2 = p(1,2);
            
            % check and make sure they are within the bounds
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
            
            if x2 > x1 && y2 > y1
                x = x1; y = y1; w = x2 - x1; h = y2 - y1; 
            elseif x2 > x1 && y2 < y1
                x = x1; y = y2; w = x2 - x1; h = y1 - y2; 
            elseif x2 < x1 && y2 > y1
                x = x2; y = y1; w = x1 - x2; h = y2 - y1; 
            else
                x = x2; y = y2; w = x1 - x2; h = y1 - y2; 
            end
            if w < min_w
                w = min_w;
            end
            if h < min_h
                h = min_h;
            end
            set(rh, 'Position', [x, y, w, h]);
        end
        
        function buttonUp(fh,dummy)
            set(rh,'linestyle','-');
            set(fh, 'WindowButtonMotionFcn', '');
            set(fh, 'WindowButtonUpFcn', '');
            set(fh, 'WindowButtonDownFcn', '');
        end
    end

end