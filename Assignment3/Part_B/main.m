%%Get discrete trasfer function
%Our transfer function values
num = [2 3];
den = [1 2 2.5 1.25];

%Results
[numd, dend] = getDiscreteTF(num, den);