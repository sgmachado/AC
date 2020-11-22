function [autoenc, features] = simpleAutoencoder(X, nFeatures)
%function features = simpleAutoencoder(X, nFeatures)

    %train autoencoder
    hiddenSize = nFeatures;
    autoenc = trainAutoencoder(X, hiddenSize, ...
        'MaxEpochs',1000,...
        'L2WeightRegularization', 0.001, ...
        'SparsityRegularization', 4, ...
        'SparsityProportion', 0.05, ...
        'EncoderTransferFunction','logsig',...
        'DecoderTransferFunction', 'purelin',...
        'TrainingAlgorithm', 'trainscg',...
        'ShowProgressWindow',true);
    
    %extract the n features
    features = encode(autoenc, X);
end

