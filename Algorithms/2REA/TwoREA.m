function TwoREA(Global)
% <algorithm> <A-G>
% A Many-Objective Evolutionary Algorithm Based On A Two-Round-Selection Strategy
    Population   = Global.Initialization();
    [z,znad]     = deal(min(Population.objs),max(Population.objs));
    %% Optimization
     while Global.NotTermination(Population)  
            Lp= Shape_Estimate(Population,Global.N,z,znad);
            MatingPool=MatingSelection(Population.objs,Global.N,Lp,z,znad);
            Offspring  = GA(Population(MatingPool));  
            [Population,z,znad] = EnvironmentalSelection([Population,Offspring],Global.N,Lp);
     end
end