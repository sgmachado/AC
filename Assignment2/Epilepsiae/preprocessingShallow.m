%alterar para tambem dar para usar autoencoder
function [dataTraining,dataTesting] = preprocessingShallow(data)
    path = 'C:\EpilepsaeData\';
    %path = '/home/sergio/Dropbox/AC/PL2/Data/';

    data = load(strcat(path, data));

    %To transpose FeatVectSel and change classification in Trg
    data = changeData(data);

    %Use autoencoder berfore dividing to make it less complicated
    %data.FeatVectSel = simpleAutoencoder(data1.FeatVectSel, 10);
    %data.FeatVectSel = stackAutoencoder(data1.FeatVectSel, 10, 6);

    %Divide dataset into training, test and validation sets, 
    %considering the intended percentage of seizures pretended in each set
    %80% training+validation (85% training, 15% validation), 20% testing
    divIndex = datasetDivision(data);
    dataTraining = struct('FeatVectSel', data.FeatVectSel(:, 1:divIndex), 'Trg', data.Trg(1:divIndex, :));
    dataTesting = struct('FeatVectSel', data.FeatVectSel(:, divIndex+1:end), 'Trg', data.Trg(divIndex+1:end, :));

    %Balance data, if pretended (only for training)
    dataTraining = balanceData(dataTraining);

    %Target in a form that can be used by the NN's
    dataTraining.Trg = createTarget(dataTraining);
    dataTesting.Trg = createTarget(dataTesting);

end
