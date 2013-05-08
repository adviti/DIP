clear all
close all
clc

list = {    'coggygria';
            'oleander';
            'opalus';
            'sativa';
            'serotina';
            'spinosa';
            'tobira'};
total_im =0; 
for k = 1:7
    class = list{k};
    directory = ['..\data\train_data\', class, '\'];
    dirList = dir([directory, '*.jpg']);
    NFiles = length(dirList);
    total_im = NFiles + total_im;
    disp(NFiles)
end
disp(total_im)
cMatrix = cell(total_im + 1, 8);
    cMatrix{1, 1} = 'File';
    cMatrix{1, 2} = 'Contrast';
    cMatrix{1, 3} = 'Correlation';
    cMatrix{1, 4} = 'Energy';
    cMatrix{1, 5} = 'Homogeneity';
    cMatrix{1, 6} = 'Entropy';
    cMatrix{1, 7} = 'Roundness';
    cMatrix{1, 8} = 'AspectRatio';

track = 1 ;
for k = 1:7
    class = list{k};
    directory = ['..\data\train_data\', class, '\'];
    dirList = dir([directory, '*.jpg']);
    NFiles = length(dirList);
    disp('mewewq')
    for i = track : NFiles + track - 1
        clc
        disp('Percent Complete')
        disp(i/NFiles*100);

        fName = dirList(i).name(1:end-4);

        I = imread([directory, dirList(i).name]);
        I = rgb2gray(I);

        BW = ~im2bw(I, graythresh(I));
        Area = bwarea(BW);
        Perimeter = sum(sum(bwperim(BW)));
        stats = regionprops(BW, 'MajorAxisLength', 'MinorAxisLength');
        MajorAxis = 0;
        MinorAxis = 0;
        for j = 1:length(stats)
            if MajorAxis < stats(j).MajorAxisLength
                MajorAxis = stats(j).MajorAxisLength;
                MinorAxis = stats(j).MinorAxisLength;
            end
        end

        Tex = get_texture(I);
        
        glcm = graycomatrix(I);
        stats = graycoprops(glcm, 'all');
        stats.Entropy = entropy(Tex);

        cMatrix{i + 1, 1} = fName;
        cMatrix{i + 1, 2} = stats.Contrast;
        cMatrix{i + 1, 3} = stats.Correlation;
        cMatrix{i + 1, 4} = stats.Energy;
        cMatrix{i + 1, 5} = stats.Homogeneity;
        cMatrix{i + 1, 6} = stats.Entropy;
        cMatrix{i + 1, 7} = 4*pi*Area/Perimeter^2;
        cMatrix{i + 1, 8} = MinorAxis/MajorAxis;
    end
 xlswrite(['..\all_data'], cMatrix, ['A', num2str(track+1), ':', 'H', num2str(track + NFiles)]) 
 track = NFiles + track;
 
end
%     xlswrite(['..\XLS1\', class], cMatrix)
    