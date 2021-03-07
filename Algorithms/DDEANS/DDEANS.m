function DDEANS(Global)
% <algorithm> <D>
% DDEA + non-dominated sorting

%------------------------------- Reference --------------------------------
% X. He, Y. Zhou, Z. Chen, and Q. Zhang, 
% Evolutionary Many-objective Optimization based on Dynamical Decomposition, 
% IEEE Transactions on Evolutionary Computation, pp. 1, 2018.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    Population = Global.Initialization();
    N = Global.N;
    FrontNo = zeros(1,N);
    rankings = zeros(1,N);
    while Global.NotTermination(Population)
        MatingPool = TournamentSelection(2,length(Population),FrontNo,rankings);
        Offspring  = GA(Population(MatingPool));
        All = [Population Offspring];
        Next = false(1,length(All));
	    % Non-dominated sorting
	    [FrontNo,MaxFNo] = NDSort(All.objs,N);
        Next(FrontNo<MaxFNo) = true;
	    % ranking 
	    rankings = inf(size(FrontNo));
	    for level = 1 : (MaxFNo-1)
		    rankings(FrontNo==level) = DDRanking(All(FrontNo==level).objs,sum(FrontNo==level));
	    end
	    rankings(FrontNo==MaxFNo) = DDRanking(All(FrontNo==MaxFNo).objs,N-sum(FrontNo<MaxFNo));
	    Next(~isinf(rankings)) = true;
	    Population = All(Next);
        FrontNo = FrontNo(Next);
	    rankings = rankings(Next);
    end
end

