%function [network] = trainLRN(data)
    
    dataB = balanceData(data);
    target = createTarget(dataB);
    
    %***** Usar aqui autoenconder *****

    %layrecnet arguments: [layerDelays,hiddenSizes,trainFcn]
    %Default-> layerDelays=1:2, hiddenSizes=10 h layers, trainFcn ='train lm'
    layerDelays = 1:2;          
    hiddenLayersSize = 2;
    trainFcn = 'trainlm';
    net = layrecnet(layerDelays,hiddenLayersSize,trainFcn);
    %     [Xs,Xi,Ai,Ts] = preparets(net,dataB.FeatVectSel,{},target);
    %network = train(net,data.FeatVectSel,dataT,'UseParallel','yes','UseGPU','yes');
    %     net = train(net,Xs,Ts,Xi,Ai);
    %     Y = net(Xs,Xi,Ai);
    %     plot(cell2mat(Y))
    %     perf = perform(net,Y,Ts)
    
    %Transfer function
    net.layers{1}.transferFcn = 'purelin';
    
    %Parametros de Treino
    net.trainParam.epochs = 1000;
    net.trainParam.min_grad = 1e-9;
    net.trainParam.lr = 0.01;
    net.performFcn = 'msereg';
    net.trainParam.max_fail = 100;
    net.trainParam.goal = 1e-9;
    %net.performParam.regularization = 0.4;
    
    %Divisão do Set Balanceado para treino e validação
    net.divideFcn = 'divideblock';
    net.divideParam.trainRatio = 85/100;
    net.divideParam.valRatio = 15/100;
    
    [~,C] = size(target);
    interIctalL = nnz(all(target==[1 0 0]'));
    preIctalL = nnz(all(target==[0 1 0]'));
    ictalL = nnz(all(target==[0 0 1]'));
    
    %Calculate de error weight matrix
    EW = all(target==[1 0 0]')*(C/interIctalL) + all(target==[0 1 0]')*(C/preIctalL) + all(target==[0 0 1]')*(C/ictalL);    
    
    %view(net)
    network = train(net,dataB.FeatVectSel,target,[],[],EW);
    y = network(dataB.FeatVectSel);
    perf = perform(network,y,target,EW); 
%end

