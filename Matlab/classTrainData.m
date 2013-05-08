function [ cMatrix ] = classTrainData( class )
% gives trainig data set for a class.

    directory = ['..\data\train_data\', class, '\'];
    dirList = dir([directory, '*.jpg']);
    NFiles = length(dirList);
    
    cMatrix = zeros(NFiles, 7);
   
    
    for i = 1:NFiles
        clc;
        disp(i/NFiles*100)
        
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
        glcm = graycomatrix(Tex);
        stats = graycoprops(glcm, 'all');
        stats.Entropy = entropy(Tex);
        
        cMatrix(i, 1) = stats.Contrast;
        cMatrix(i, 2) = stats.Correlation;
        cMatrix(i, 3) = stats.Energy;
        cMatrix(i, 4) = stats.Homogeneity;
        cMatrix(i, 5) = stats.Entropy;
        cMatrix(i, 6) = 4*pi*Area/Perimeter^2;
        cMatrix(i, 7) = MinorAxis/MajorAxis;
    end
end

