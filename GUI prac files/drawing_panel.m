   fignum = figure('Units', 'normal', 'Position', [0.1 0.1 .8 .8]);  %not quite full screen  
   subgroup1 = uipanel('Parent', fignum, 'Units', 'normal', 'Position', [0 2/3 1 1/3])  %top third
   subgroup1_plotbox = uipanel('Parent', subgroup1, 'Units', 'normal', 'Position', [0 .1 1 .9])  %plot in top 9/10 of the group
   subgroup1_controls = uipanel('Parent', subgroup1, 'Units', 'normal', 'Position', [0 0 1 .1]); %control area in bottom 1/10 of the group
   subgroup1_axes = axes('Parent', subgroup1_plotbox);
   plot(1:50, rand(1,50), 'Parent', subgroup1_axes);   %throw up some content
   subgroup1_slider = uicontrol('style', 'slider', 'Parent', subgroup1_controls);