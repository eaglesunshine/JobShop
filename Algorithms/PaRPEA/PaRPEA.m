function PaRPEA(Global)
% <algorithm> <A-A>
    %% Generate random population
    %[W,Global.N] = UniformPoint(Global.N,Global.M);
    Population   = Global.Initialization();
    
    %% Optimization
    while Global.NotTermination(Population)
        %MatingPool = TournamentSelection(2,Global.N,sum(max(0,Population.cons),2));
        MatingPool = randi(Global.N,1,Global.N);
        Offspring  = GA(Population(MatingPool)); 
        Population = EnvironmentalSelection([Population,Offspring],Global.N);
        
    end
end