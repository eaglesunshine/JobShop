function alpha = AdaptiveTolerate2(Population,curProgress,N)
    %%
    CV = sum(max(0,Population.cons),2);
    %N=length(Population);
    [FrontNo,~] = NDSort(Population.objs,N);
    St = FrontNo==1;
    Feasible_num_NDS = length(find(CV(St)<=0));
    InFeasible_num_NDS = length(find(CV(St)>0));
    feasible_Rate = Feasible_num_NDS/(Feasible_num_NDS+InFeasible_num_NDS);
    inFeasible_Rate = 1 - feasible_Rate;
    control_Rate = 0.8 + inFeasible_Rate * 0.2;
    alpha = (1/(1+exp(-18*(curProgress-control_Rate*0.6))))*0.9+0.1;
%     if alpha<=0.1
%         alpha=0.1;
%     end
    
    %if curProgress>0.2
    %  alpha=1;
    %end
end

