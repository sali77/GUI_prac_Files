clc
clear

%%
if exist('text.txt', 'file') == 0
 disp('File does not exist, creating file.')
 f = fopen( 'text.txt', 'w' );  
 fclose(f);
else
    disp('File exists.');
end
