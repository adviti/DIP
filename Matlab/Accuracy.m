clc
clear all
close all


list = {    'coggygria';
            'oleander';
            'opalus';
            'sativa';
            'serotina';
            'spinosa';
            'tobira'};

list_len = length(list);

load SVMStruct.mat

identified = 0;
total_leaves = 0;
for k = 1:list_len
    
    clc
    disp('Progress ...');
    disp(k/list_len)
    
    class = list{k};
    directory = ['../data/test_data/', class, '/'];
    dirList = dir([directory, '*.jpg']);
    NFiles = length(dirList);
    
    for i=1:NFiles
        fName = dirList(i).name(1:end-4);
        sample_vector = getSample([directory, dirList(i).name]);
        result = classifyLeaf(list, svm_struct, sample_vector);
        total_leaves = total_leaves + 1;
        if strcmp(class, result)
            identified = identified + 1;
        end
    end
end
disp(identified/total_leaves * 100)
