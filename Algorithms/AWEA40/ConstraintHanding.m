function [Population,P] = ConstraintHanding(Population,N,alpha,curProgress,P)
    %alpha = Global.evaluated/Global.evaluation;
    CV = sum(max(0,Population.cons),2);
    Population_F = Population(CV<=0);
    Population_I = Population(CV>0);
    Feasible_num = sum(CV<=0,1);
    InFeasible_num = sum(CV>0,1);
    
    if Feasible_num >= ceil(N*alpha) && InFeasible_num >= N - ceil(N*alpha)
        Population_F = EnvironmentalSelection(Population_F,ceil(N*alpha),1,curProgress,P);
        Population_I = EnvironmentalSelection(Population_I,N - ceil(N*alpha),0,curProgress,P);
    elseif InFeasible_num < N - ceil(N*alpha)
        Population_F = EnvironmentalSelection(Population_F,N-InFeasible_num,1,curProgress,P);
        Population_I = EnvironmentalSelection(Population_I,InFeasible_num,0,curProgress,P);
    elseif Feasible_num < ceil(N*alpha)
        Population_F = EnvironmentalSelection(Population_F,Feasible_num,1,curProgress,P);
        Population_I = EnvironmentalSelection(Population_I,N-Feasible_num,0,curProgress,P);
    end   
    Population = [Population_F,Population_I];  
end