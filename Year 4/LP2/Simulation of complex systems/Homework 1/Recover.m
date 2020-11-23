function [infected, recovered] = Recover(infected, recovered, gamma)
flag = -1;
nInfected = size(infected,1);
for i = 1:nInfected
   if rand < gamma
       currentAgent = infected(i,:);
       recovered = [recovered; currentAgent];
       infected(i, 1) = flag;   
   end
end

infected(infected(:,1) == flag, :) = [];

end

