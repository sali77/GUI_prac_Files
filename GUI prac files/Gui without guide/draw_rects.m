function draw_rects

global stop_Esqi_mk;           % stop R peak marking variable
global Esqi_txt_data;          % Data from '_Rpeaks.txt' is stored in this variable using dlmread
global Esqi_indices;           % sample numbers of Rpeak_indices (column vector)
global rh file_path
global rEsqi 

hMainFigure = figure('Name', 'ICG Manual Annotation Application', ...
    'NumberTitle', 'off', ...
    'Resize', 'on', ...
    'Units', 'pixel',...
    'Position', [100 100 1024 568],...
    'HandleVisibility', 'callback');

hplotECG = axes(...
    'Parent', hMainFigure,...
    'HandleVisibility', 'callback', ...
    'Units', 'normalized', ...
    'Position', [0.04    0.45    0.74    0.23], ...
    'XLim', [0,3.75], ...
    'YLim', [-3 3], ...
    'XMinorGrid', 'on',... 
    'YMinorGrid', 'on',... 
    'NextPlot', 'replacechildren');
ylabel(hplotECG,'ECG (mv)');

h_imrect = uicontrol(hMainFigure, ...
    'Style', 'pushbutton', ...?% can changed text
    'HandleVisibility', 'callback', ...
    'Units', 'normalized',...
    'Position', [0.5   0.76    0.1    0.11], ...
    'String', 'imrect', ...
    'fontsize',12,...
    'background',[0.2 0.8 0.6],....
    'Callback', @draw_imrect);

 function draw_imrect(hObject, eventdata)
%         get(hObject);
        imrect;
        Esqi_posn = getrect;
        Esqi_x1 = Esqi_posn(1,1);
        Esqi_x2= Esqi_posn(1,3) + Esqi_posn(1,1);
 end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% drw rect %%%%%%%%%%%%%%%%%%%%%%%%
hdraw_rect = uicontrol(hMainFigure, ...
    'Style', 'pushbutton', ...?% can changed text
    'HandleVisibility', 'callback', ...
    'Units', 'normalized',...
    'Position', [0.3  0.76    0.1    0.11], ...
    'String', 'Draw Rect', ...
    'fontsize',12,...
    'background',[0.2 0.8 0.6],....
    'Callback', @Add_Esqi);

 function Add_Esqi(hObject, eventdata)
   stop_Esqi_mk = 0;
   draw_rect(hMainFigure, hplotECG); 
           
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

end
%----------- For creating text files for SQI point------------------------------------       
hsel_dataset = uicontrol(hMainFigure, ...
    'Style', 'pushbutton', ...?% can changed text
    'HandleVisibility', 'callback', ...
    'Units', 'normalized',...
    'Position', [0.1   0.86    0.1    0.11], ...
    'String', 'Select Dataset', ...
    'fontsize',12,...
    'background',[0.2 0.8 0.6],....
    'Callback', @initial);

    function initial(hObject, eventdata)       % for selecting Data folder
        path=uigetdir;                         % opens the window to select data window
        addpath(genpath(path));
        file_path = [path filesep];
        cd(file_path)
        if ~exist('testsqi_manual','dir')    % Folder for saving manual maring of ECG ICG Points
            mkdir('testsqi_manual');
        end
        folder_path_manual = char(strcat(file_path,'testsqi_manual','\'));

         %5------------------  creating text files for Rpeak, C, B Bavg Xpoint------------------------------------    
         
        record_name = 'test';
        if exist(strcat(folder_path_manual,record_name,'_Esqi','.txt'),'file')
            Esqi_txt_data = dlmread(strcat(folder_path_manual,record_name,'_Esqi.txt'));
            Esqi_indices = Esqi_txt_data(:,1);
        else
            Esqi_indices = [];            
        end
        A = rh.position;
        fileID = fopen('test_Esqi.txt','w');
        fprintf(fileID,A);

    end
        

 end