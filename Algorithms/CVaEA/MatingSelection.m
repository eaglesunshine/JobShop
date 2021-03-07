function MatingPool = MatingSelection(PopObj,N)
% The mating selection of 2REA
    CV = sum(max(0,PopObj),2);
    MatingPool = TournamentSelection(2,N,CV);
end
