function [ sample_vector ] = getSample( filename)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    cMatrix = zeros(1, 7);
    I = imread(filename);
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

    cMatrix(1) = stats.Contrast;
    cMatrix(2) = stats.Correlation;
    cMatrix(3) = stats.Energy;
    cMatrix(4) = stats.Homogeneity;
    cMatrix(5) = stats.Entropy;
    cMatrix(6) = 4*pi*Area/Perimeter^2;
    cMatrix(7) = MinorAxis/MajorAxis;
    
    sample_vector = cMatrix;
end

