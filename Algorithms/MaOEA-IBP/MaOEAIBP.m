function MaOEAIBP(Global)
% <algorithm> <H-N>
    Population = Global.Initialization();
    %% Optimization
    while Global.NotTermination(Population)
        MatingPool=MatingSelection(Population.objs);
        Offspring  = Global.Variation(Population(MatingPool));
        Population = EnvironmentalSelection([Population,Offspring],Global.N);
    end
end