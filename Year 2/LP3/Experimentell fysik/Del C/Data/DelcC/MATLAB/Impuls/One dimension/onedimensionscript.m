clf, clc
mass1=0.193;
mass2=0.193;
path0='Z:\.win\My Documents\Impuls\Data\1D\Nya Magneter\';
relativevelocitymag = [];
energycoeffmag=[];
rescoeffmag=[];
for i=1:1:20
    path=strcat(path0,int2str(i),'.tsv')

    if strcmp(path0, 'Z:\.win\My Documents\Impuls\Data\1D\Nya gummiband\En still\1 still\') & i>2
        data = onedimensionfail(path,mass1,mass2)
    else
        data = onedimension(path,mass1,mass2);
    end
    energycoeffmag = [energycoeffmag; data(1)]
    rescoeffmag = [rescoeffmag; data(2)]
    relativevelocitymag = [relativevelocitymag; abs(data(4)-data(3))];
end

plot(relativevelocitymag, energycoeffmag, 'yo')
plot(relativevelocitymag, rescoeffmag, 'go')

mass1=0.193;
mass2=0.193;
path0='Z:\.win\My Documents\Impuls\Data\1D\Nya gummiband\Båda åker\';
relativevelocitygum = [];
energycoeffgum=[];
rescoeffgum=[];

for i=1:1:20
    path=strcat(path0,int2str(i),'.tsv')

    if strcmp(path0, 'Z:\.win\My Documents\Impuls\Data\1D\Nya gummiband\En still\1 still\') & i>2
        data = onedimensionfail(path,mass1,mass2)
    else
        data = onedimension(path,mass1,mass2);
    end
    energycoeffgum = [energycoeffgum; data(1)]
    rescoeffgum = [rescoeffgum; data(2)]
    relativevelocitygum = [relativevelocitygum; abs(data(4)-data(3))];
end

plot(relativevelocitygum, energycoeffgum, 'bo')
plot(relativevelocitygum, rescoeffgum, 'ro')


