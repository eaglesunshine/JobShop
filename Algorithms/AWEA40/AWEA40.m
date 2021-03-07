function AWEA40(Global)
% <algorithm> <A-A>
    %% Generate random population
    Population = Global.Initialization();
    P = 1.0;
    
    %% Optimization
    while Global.NotTermination(Population)
        %MatingPool = randi(Global.N,1,Global.N);
        %if mod(Global.gen,ceil(Global.maxgen/10))==0 && Global.evaluated/Global.evaluation>0.6
        nowProcess = Global.gen/Global.maxgen;
        if nowProcess==0.6 || nowProcess==0.7 || nowProcess==0.8 || nowProcess==0.9
            P = Estimate_P(Population);
        end
        MatingPool=MatingSelection(Population.objs);
        Offspring  = GA(Population(MatingPool)); 
        curProgress = Global.evaluated/Global.evaluation;%0~1
        alpha = AdaptiveTolerate2([Population,Offspring],curProgress,Global.N);%���������Ӵ���
        %�����alphaҲ��0~1��ʾ�Կ��н��ѡ��

        Population = ConstraintHanding([Population,Offspring],Global.N,alpha,curProgress,P);
    end
    %Population.objs
end