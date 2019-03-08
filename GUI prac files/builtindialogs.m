%built in dialog boxes
%msgbox('My Error Message','Error Window Name','error');

%msgbox('My Help Message','Help Window Name','help');

%msgbox('My Warning Message','Warning Window Name','warn');


%question_ans = questdlg('Do you want a hard copy?',...
%			'OUTPUT','Yes','No','No')
%if strcmp(question_ans,'Yes')
%	print
%end


%answers = inputdlg({'My first question',...
%                     'My 2nd question',...
%                     'My 3rd question',},...
%                     'Window Name',[1 2 1],...
%                    {'defAns1','defAns2','defAns3'});

%[filename,pathname] = uigetfile('*.m',...
%                                 'UIGETFILE TITLE',...
%                                 100,100);

[filename,pathname] = uiputfile('Default.m',...
                                 'UIPUTFILE TITLE');
