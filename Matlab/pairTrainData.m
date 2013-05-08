function [ TD ] = pairTrainData( class1, class2 )
% gives trainig data set for two classes.
    class1_mat = classTrainData(class1);
    class2_mat = classTrainData(class2);
    
    TD.numLeafClass1 = size(class1_mat, 1);
    TD.numLeafClass2 = size(class2_mat, 1);
    TD.nameClass1 = class1;
    TD.nameClass2 = class2;
    TD.groupData = [zeros(TD.numLeafClass1, 1); ones(TD.numLeafClass2, 1)];
    TD.trainData = [class1_mat; class2_mat];
end

