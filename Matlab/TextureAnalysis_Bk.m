clear all
close all
clc

class = 'serotina';
directory = ['..\data\', class, '\'];
dirList = dir([directory, '*.jpg']);
NFiles = length(dirList);

cMatrix = cell(9, NFiles + 1);
cMatrix{1, 1} = 'File';
cMatrix{2, 1} = 'Contrast';
cMatrix{3, 1} = 'Correlation';
cMatrix{4, 1} = 'Energy';
cMatrix{5, 1} = 'Homogeneity';
cMatrix{6, 1} = 'Entropy';
cMatrix{7, 1} = 'Area';
cMatrix{8, 1} = 'Perimeter';
cMatrix{9, 1} = 'Roundness';

mkdir(['..\Texture\', class]);

for i = 1:NFiles
    clc
    disp('Percent Complete')
    disp(i/NFiles*100);
    
    fName = dirList(i).name(1:end-4);
    
    I = imread([directory, dirList(i).name]);
    I = rgb2gray(I);
    
    BW = ~im2bw(I, graythresh(I));
    Area = bwarea(BW);
    Perimeter = sum(sum(bwperim(BW)));
    
    Tex = get_texture(I);
    %imwrite(Tex, ['..\Texture\', class, '\', fName, '.jpg'], 'jpg');
    
    glcm = graycomatrix(I);
    stats = graycoprops(glcm, 'all');
    stats.Entropy = entropy(Tex);
    
    cMatrix{1, i + 1} = fName;
    cMatrix{2, i + 1} = stats.Contrast;
    cMatrix{3, i + 1} = stats.Correlation;
    cMatrix{4, i + 1} = stats.Energy;
    cMatrix{5, i + 1} = stats.Homogeneity;
    cMatrix{6, i + 1} = stats.Entropy;
    cMatrix{7, i + 1} = Area;
    cMatrix{8, i + 1} = Perimeter;
    cMatrix{9, i + 1} = 4*pi*Area/Perimeter^2;
end

Con = zeros(NFiles, 1);
Cor = zeros(NFiles, 1);
Ene = zeros(NFiles, 1);
Hom = zeros(NFiles, 1);
Ent = zeros(NFiles, 1);
Are = zeros(NFiles, 1);
Per = zeros(NFiles, 1);
Rou = zeros(NFiles, 1);
for i = 1:NFiles
    Con(i) = cMatrix{2, i + 1};
    Cor(i) = cMatrix{3, i + 1};
    Ene(i) = cMatrix{4, i + 1};
    Hom(i) = cMatrix{5, i + 1};
    Ent(i) = cMatrix{6, i + 1};
    Are(i) = cMatrix{7, i + 1};
    Per(i) = cMatrix{8, i + 1};
    Rou(i) = cMatrix{9, i + 1};
end
xMatrix = { '',                 'Min',    'Max'     'Mean',    'Std',   'Median',     'Mode',    'Range';
            'Contrast',         min(Con), max(Con), mean(Con), std(Con), median(Con), mode(Con), range(Con);
            'Correlation',      min(Cor), max(Cor), mean(Cor), std(Cor), median(Cor), mode(Cor), range(Cor);
            'Energy',           min(Ene), max(Ene), mean(Ene), std(Ene), median(Ene), mode(Ene), range(Ene);
            'Homogeneity',      min(Hom), max(Hom), mean(Hom), std(Hom), median(Hom), mode(Hom), range(Hom);
            'Entropy',          min(Ent), max(Ent), mean(Ent), std(Ent), median(Ent), mode(Ent), range(Ent);
            'Area',             min(Are), max(Are), mean(Are), std(Are), median(Are), mode(Are), range(Are);
            'Perimeter',        min(Per), max(Per), mean(Per), std(Per), median(Per), mode(Per), range(Per);
            'Roundness',        min(Rou), max(Rou), mean(Rou), std(Rou), median(Rou), mode(Rou), range(Rou)};
            
xlswrite(['../XLS/', class], cMatrix)
xlswrite(['../XLS/', class], xMatrix, 'A11:H19' )