function CTAEA(Global)
% <algorithm> <A-A>
% A New Dominance Relation Based Evolutionary Algorithm for Many-Objective
% Optimization

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Generate the reference points and random population
    [W,Global.N] = UniformPoint(Global.N,Global.M);
    Population   = Global.Initialization();
    DA=Population;
    %CA=Population;
    %[z,znad]     = deal(min(Population.objs),max(Population.objs));

    %% Optimization
    while Global.NotTermination(Population) 
          MatingPool = MatingSelection(Population,DA,Global.N);
          Offspring  = GA(MatingPool);
          Population = EnvironmentalSelection([Population,Offspring],W,Global.N);
          DA = Updade_DA([DA,Offspring],Population,W,Global.N);
    end
end