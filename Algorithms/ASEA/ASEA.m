function ASEA(Global)
% <algorithm> <A-A>
% --------------------------------------------------------------------------
% Source coed of the Adaptive Sorting-Based Evolutionary Algorithm (ASEA).
%
% See details of the algorithm in the following paper:
%
% C. Liu, Q. Zhao, B. Yan, S. Elsayed, T. Ray, and R. Sarker.
% Adaptive Sorting-Based Evolutionary Algorithm for Many-Objective
% Optimization [J]. IEEE transactions on Evolutionary Computation, to be
% published, DOI: 10.1109/TEVC.2018.2848254.
%
% If you have any questions about the code, please contact:
% Qi Zhao at qzhao@emails.bjut.edu.cn
%--------------------------------------------------------------------------
%% Generate the reference points and random population
[W,Global.N] = UniformPoint(Global.N,Global.M);
Population = Global.Initialization();
[z,znad] = deal(min(Population.objs),max(Population.objs));

%% Optimization
while Global.NotTermination(Population)
    MatingPool = randi(size(Population,2),1,size(Population,2));
    Offspring  = GA(Population(MatingPool));
    [Population,z,znad] = EnvironmentalSelectionASEA([Population,Offspring],W,Global.N,z,znad,Global.gen/Global.maxgen);
end
end