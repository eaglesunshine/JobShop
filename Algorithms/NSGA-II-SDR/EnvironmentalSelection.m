function [Population,FrontNo,CrowdDis] = EnvironmentalSelection(Population,N,zmin,zmax)
% The environmental selection of NSGA-II

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    %% Normalization
    PopObj = Population.objs - repmat(zmin,length(Population),1);	% 每个目标向量减去各个维度的最小值
    range  = zmax - zmin;	% 数据在各个维度的宽度范围是range
    if 0.05*max(range) < min(range) % 如果维度的最小宽度大于最大宽度的0.05倍，则目标向量除以各个维度宽度。即————如果存在某个维度宽度极端小，或者某个维度宽度极端大时，将不会采用归一化，因为认为此时归一化是错误的
        PopObj = PopObj./repmat(range,length(Population),1);
    end
    [~,x]      = unique(roundn(PopObj,-6),'rows');	% roundn函数是四舍五入函数，正负号代表是小数点的右边还是左边到第几位。a=unique(A,'rows')返回的a值变为矩阵中每一个列向量中的唯一元素。
    PopObj     = PopObj(x,:);
    Population = Population(x);
    N          = min(N,length(Population));

    %% Non-dominated sorting
    [FrontNo,MaxFNo] = NDSort_SDR(PopObj,N);
    Next = FrontNo < MaxFNo;
    
    %% Calculate the crowding distance of each solution
    CrowdDis = CrowdingDistance(PopObj,FrontNo);
    
    %% Select the solutions in the last front based on their crowding distances
    Last     = find(FrontNo==MaxFNo);
    [~,Rank] = sort(CrowdDis(Last),'descend');
    Next(Last(Rank(1:N-sum(Next)))) = true;
    
    %% Population for next generation
    Population = Population(Next);
    FrontNo    = FrontNo(Next);
    CrowdDis   = CrowdDis(Next);
end