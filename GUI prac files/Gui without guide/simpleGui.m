function simpleGui

h.fig = figure('position', [500 300 500 200]);

h.buttonOne = uicontrol ('Parent', figure,'style', 'pushbutton' , ...
                          'position', [10 10 100 40], ...  % 10 pixels in each drection 
                          'string' , 'Add button');
                      
% Important :  we are not setting h.buttonOne in creation of button because
% h has not been created with field buttonOne
set(h.buttonOne,'callback', {@addButton, h})        %  call back is a function that is called  when u click the button
                                                    %   cell array -
                                                    %   function : @addButton
                                                    % h : inputs which we
                                                    % are going to send
                                                    % over there
    function h = addButton(hobject, eventdata,h)    
        % hobject = handle of the object;
        % when we are calling the callback, MATLAB is automatically going
        % to add hobject which is the handle of the object
        % h = whatever we are expected to hand in
        h.buttonTwo = uicontrol ('style', 'pushbutton' , ...
                          'position', [100 10 100 40], ...  % 10 pixels in each drection 
                          'string' , 'Remove button');
        set(h.buttonTwo,'callback', {@removeButton, h}) 
        set(h.buttonOne,'enable', 'off')
         
        function h  = removeButton(hobject, eventdata,h)
            delete(h.buttonTwo)                   % delete button2
            h = rmfield(h, 'buttonTwo');          % clean up my each structure that have handles to all different 
                                                  % widgets in the figure
                                                  % to button two
            set(h.buttonOne, 'enable','on')
            
              
 

        