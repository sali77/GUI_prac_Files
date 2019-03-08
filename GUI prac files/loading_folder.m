% Have user browse for a file, from a specified "starting folder."
% For convenience in browsing, set a starting folder from which to browse.

clc
clear
startingFolder = 'C:\Users\Barfi\Dropbox\Clifford_Lab_MATLAB\Shafaat_try_GUI\Data';
if ~exist(startingFolder, 'dir')
	% If that folder doesn't exist, just start in the current folder.
	startingFolder = pwd;
end
% Get the name of the mat file that the user wants to use.
defaultFileName = fullfile(startingFolder, '*.mat');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a mat file');
if baseFileName == 0
	% User clicked the Cancel button.
	return;
end
fullFileName = fullfile(folder, baseFileName)
storedStructure = load(fullFileName);
ecg_icg = cell2mat(struct2cell(storedStructure));

