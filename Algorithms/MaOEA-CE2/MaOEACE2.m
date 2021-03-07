function MaOEACE2(Global)
% <algorithm> <M>
% A Many-Objective Evolutionary Algorithm Based on Curvature Estimation of Pareto Front

    %% random population
    Population   = Global.Initialization();
    [z,znad]     = deal(min(Population.objs),max(Population.objs)); 
	
    %% Optimization
    LPAll = [];
    Lp = 1;
    W = [];
    isStable = inf;
    FrontNo = zeros(1,Global.N);
    Rank = zeros(1,Global.N);
    while Global.NotTermination(Population)
        [W,Lp,LPAll,isStable] = GenerateReferencePoints(Population,Global,z,znad,LPAll,W,Lp,isStable);    
		MatingPool = MatingSelection(Population.objs);	
        Offspring  = GA(Population(MatingPool));
        a = Global.gen/Global.maxgen;
        [Population,z,znad,W,FrontNo,Rank] = EnvironmentalSelectionCE([Population,Offspring],Global.N,W,Lp,a); 
    end
end