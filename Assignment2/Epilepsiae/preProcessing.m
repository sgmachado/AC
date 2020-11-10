%data1 = load('/home/sergio/Dropbox/AC/PL2/Data/54802.mat');
%data2 = load('/home/sergio/Dropbox/AC/PL2/Data/112502.mat');

data1 = load('C:\EpilepsaeData\54802.mat');
data2 = load('C:\EpilepsaeData\112502.mat');

%Classification:
%   1 - Inter-ictal: [1 0 0]
%   2 - Pre-ictal:   [0 1 0]
%   3 - Ictal:       [0 0 1]

%To transpose FeatVectSel and change classification in Trg
data1 = changeData(data1);
data2 = changeData(data2);

%ter uma variavel com o path para nao dar erro a fazer commit
save('Data/data1.mat', 'data1');
save('Data/data2.mat', 'data2');


%Divide dataset
%Train + validation (75%) -> train (85%), validation (25%)
%Test (25%)
%ALTERAR PARA TER EM CONTA QUANTAS SEIZURES FICAM EM CADA SET

%Balance data, if pretended

%DEPOIS TER CONTA TAMBÉM SE QUEREMOS FAZER PARA DETECTION OU PREDICITON
%alterando os error weights

%dividir o set em train e validacao, 85% <-> 15%| 30-20%
%so o training e que tem o balanceamento
%CNN podemos fazer mais ictal com overlap
%Mais usada é a ReLu mas podemos usar outras

%data1 = balanceData(data1);
%target1 = createTarget(data1);
%features = simpleAutoencoder(data1.FeatVectSel, 10);
%features = stackAutoencoder(data1.FeatVectSel, 10, 6);

%data2 = balanceData(data2);
%target2 = createTarget(data2);
%features = simpleAutoencoder(data2.FeatVectSel, 10);
%features = stackAutoencoder(data2.FeatVectSel, 10, 6);

