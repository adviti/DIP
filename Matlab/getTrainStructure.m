function [ svm_struct ] = getTrainStructure( list )
    list_len = length(list);
    
    for i=1:list_len
        for j=1:list_len
            if i~=j
                TD = pairTrainData(list{i}, list{j});
                svm_struct(i, j) = svmtrain(TD.trainData, TD.groupData, 'Kernel_Function', 'rbf');
            end
        end
    end
end

