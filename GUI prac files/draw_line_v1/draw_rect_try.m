function varargout = draw_rect_try(varargin)
clc
clear 
global seg_window 

fontsize1=12;
fontsize2=10; 
fontsize3 = 14;
seg_window = 1.0;   % x lim of the plotwindow
seg_time = 0.2;     % minor xtick on time axes
color_set = [0.2 0.8 0.8];
time_stx = 11*0.06;
w1 = 0.1;

hMainFigure = figure('Name', 'ICG Manual Annotation Application', ...
    'NumberTitle', 'off', ...
    'Resize', 'on', ...
    'Units', 'pixel',...
    'HandleVisibility', 'callback',...
    'Position', [100 100 1024 568],...
    'color',color_set);
hplotICG = axes(...
    'Parent', hMainFigure, ...
    'HandleVisibility', 'callback', ...
    'Units', 'normalized', ...
    'Position', [0.04    0.07    0.74   0.335], ...
    'XLim', [0,seg_window], ...
    'YLim', [-3 3], ...
    'XTick', 0:seg_time:seg_window,...
    'XMinorGrid', 'on',... 
    'YMinorGrid', 'on',...
    'NextPlot', 'replacechildren');
ylabel(hplotICG,'ICG (ohm/sec)');
xlabel(hplotICG,'Time (s)');


hB_draw_rect = uicontrol(hMainFigure, ...
    'Style', 'pushbutton', ...?% can changed text
    'HandleVisibility', 'callback', ...
    'Units', 'normalized',...
    'Position', [time_stx  0.76    w1    0.04], ...
    'String', 'Draw Rect', ...
    'fontsize',fontsize2,...
    'background',[0.2 0.8 0.6],....
    'Enable','on',...
    'Callback', @draw_rect);


function draw_rect(fh, ah)
x_bounds = get(hplotICG, 'XLim');  y_bounds = get(hplotICG, 'YLim');
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
end