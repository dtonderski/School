function iSelected = TournamentSelect(fitness, pTournament, tournamentSize)

populationSize = size(fitness,1);
iPreSelected = randi([1 populationSize], tournamentSize, 1);

% Creates a 2-d matrix with the randomly chosen indices as the first column
% and the corresponding fitness values as the second column
iPreSelectedWithFitnessValues = [iPreSelected fitness(iPreSelected)];


while size(iPreSelectedWithFitnessValues, 1) > 1
    r = rand;
    
    % Assigns to iRow the matrix row with the highest fitness value.
    % Depending on r, this row is then either deleted (the tournament 
    % continues), or used to find iSelected.
    
    [~,iRow] = max(iPreSelectedWithFitnessValues(:,2));

    if r < pTournament
        iSelected = iPreSelectedWithFitnessValues(iRow,1);
        return
    else
        iPreSelectedWithFitnessValues(iRow,:) = [];
    end
end

% Only one value
iSelected = iPreSelectedWithFitnessValues(1,1);

end

