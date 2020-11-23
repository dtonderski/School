function [susceptible, infected] = Infect(susceptible, infected, susceptibleLattice, beta)
flag = -1;
nInfected = size(infected,1);
for i = 1:nInfected
    susceptibleOnTile = susceptibleLattice(infected(i,1), infected(i,2)).susceptibleAgents;
    for j = 1:length(susceptibleOnTile)
       if rand < beta
           currentAgent = susceptibleOnTile(j);
           infected = [infected; susceptible(currentAgent,:)];
           susceptible(currentAgent,1) = flag;
       end
    end
end
susceptible(susceptible(:,1) == flag, :) = [];

end