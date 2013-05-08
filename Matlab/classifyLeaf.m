function [ leaf_class ] = classifyLeaf( list, svm_struct, sample )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [im_row im_col] = size(svm_struct);
    vote_array = zeros(im_row, 1);
    for i=1:im_row
        for j=1:im_col
            if i ~= j
                if (svmclassify(svm_struct(i, j), sample) == 0) 
                    vote_array(i)=vote_array(i) + 1;
                end
            end
        end
    end
    var = 0;
    index = 0;
    
    for k=1:length(vote_array)
        if vote_array(k)>var
            var = k;
            index = k;
        end
    end
        
    leaf_class = list{index};    
 end

