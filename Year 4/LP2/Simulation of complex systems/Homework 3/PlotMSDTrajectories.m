function PlotMSDTrajectories(MSDMatrix, tauArray, nParticles)
for i = 1:nParticles
    loglog(tauArray, MSDMatrix(1:end,:));
    if i == 1
        hold on
    end
end
xlabel('$\tau$', 'interpreter', 'latex')
ylabel('MSD' , 'interpreter', 'latex')
end

