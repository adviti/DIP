clear all
close all
clc

class = 'tobira';
directory = ['..\data\', class, '\'];
dirList = dir([directory, '*.jpg']);
NFiles = length(dirList);

cMatrix = cell(6, NFiles + 1);
cMatrix{1, 1} = 'File';
cMatrix{2, 1} = 'Contrast';
cMatrix{3, 1} = 'Correlation';
cMatrix{4, 1} = 'Energy';
cMatrix{5, 1} = 'Homogeneity';
cMatrix{6, 1} = 'Entropy';

mkdir(['..\Texture\', class]);

for i = 1%:NFiles
    clc
    disp('Percent Complete')
    disp(i/NFiles*100);
    
    fName = dirList(i).name(1:end-4);
    
    I = imread([directory, dirList(i).name]);
    I = rgb2gray(I);
    %Tex = get_texture(I);
    
    
    %imwrite(Tex, ['..\Texture\', class, '\', fName, '.jpg'], 'jpg');

end

%xlswrite(['../XLS/', class], cMatrix)