function  [network] = trainFeedForwardN(data, target, trainF, neuronsN, hLayersN, transferF, errorsOn, parallelOn)
    
    hiddenLayers = zeros(1, hLayersN);
    hiddenLayers(1,:) = neuronsN;
    %Create feedfoward nn
    net = feedforwardnet(hiddenLayers,trainF);
  
    %Transfer function
    for i = 1: hLayersN
        net.layers{i}.transferFcn = transferF;
    end
    
   %Train parameters
    net.trainParam.lr = 0.01;
    net.performFcn = 'msereg';
    %net.performParam.regularization = 0.9;

    %Stopping Criteria
    net.trainParam.min_grad = 1e-9;
    net.trainParam.max_fail = 100;
    net.trainParam.goal = 1e-9;
    net.trainParam.epochs = 1000;
    
    %Dataset division
    net.divideFcn = 'divideblock';
    net.divideParam.trainRatio = 0.85;
    net.divideParam.valRatio = 0.15;
    
    [~,C] = size(target);
    interIctalL = nnz(all(target==[1 0 0]'));
    preIctalL = nnz(all(target==[0 1 0]'));
    ictalL = nnz(all(target==[0 0 1]'));
    
    %Calculate de error weight matrix
    EW = all(target==[1 0 0]')*(C/interIctalL) + all(target==[0 1 0]')*(C/preIctalL) + all(target==[0 0 1]')*(C/ictalL);    
    
    view(net)
    
    if(errorsOn == 1)
        if(parallelOn == 1)
            network = train(net,data,target,[],[],EW, 'UseParallel','yes','UseGPU','yes'); %verificar se esta bem
        else
            network = train(net,data,target,[],[],EW);
        end  
    else
        if(parallelOn == 1)
            network = train(net,data,target,'UseParallel','yes','UseGPU','yes');
        else
            network = train(net,data,target);
        end 
    end
    
end

