mass1=0.181;
mass2=0.191;
path='Z:\.win\My Documents\Impuls\Data\1D\Nya gummiband\En still\2 still\2.tsv';
data = onedimension(path,mass1,mass2);
energycoeff=[];
energycoeff = [energycoeff; data(1)]
rescoeff=[];
rescoeff = [rescoeff; data(2)]

