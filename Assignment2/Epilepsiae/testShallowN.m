%function [SE_Dp,SE_Pp,SP_Dp,SP_Pp,SE_Dss,SE_Ps,SP_Ds,SP_Ps] = testShallowN(type)
    %Get data
    data = load('/home/sergio/Dropbox/AC/PL2/Data/54802.mat');
    data = changeData(data);
    [trIndex, ~, ttIndex] = datasetDivision(data);
    
    %Devide the dataset into training and testing
        %Training
    training.FeatVectSel = data.FeatVectSel(:,trIndex:ttIndex);
    training.Trg = data.Trg(trIndex:ttIndex,:);
        %Testing
    testing.FeatVectSel = data.FeatVectSel(:,ttIndex+1:end);
    testing.Trg = data.Trg(ttIndex+1:end,:);
    
    %Balance the data
    dataB = balanceData(training);
    %dataB = balanceData(data);
    
    %Train the Network
    if type == 1
        [network] = trainLRN(dataB,'trainlm',10,1,'purelin',0);
    else
        [network] = trainFeedForwardN(dataB,'trainlm',10,1,'purelin',1);
    end
        
    %Teste the network
    output = network(testing.FeatVectSel);
    targetT = createTarget(testing);
    %perf = perform(network,y,target,EW);
    %sprintf("Perform: %s",perf);
    
    %Calculate table values
    [SE_Dp,SE_Pp,SP_Dp,SP_Pp] = getNNPerformPbP('Shallow', targetT, output);
    [SE_Dss,SE_Ps,SP_Ds,SP_Ps] = getNNPerformSbS('Shallow', T, R);
    
%end