function Population = EnvironmentalSelection(Population,N)

    %% Normalization
    [PopObj,Extreme] = Normalization(Population);
    
    %% Constraint Handing
    CV = sum(max(0,Population.cons),2);
    PopObj_F = PopObj(CV<=0,:);
    %PopObj_I = PopObj(CV>0,:);
    Feasible_num = sum(CV<=0,1);
    Population_F = Population(CV<=0);
    Population_I = Population(CV>0);
    if Feasible_num < N
        %Population = Population_F;
        CV_I = CV(CV>0,:);
        [~,index] = sort(CV_I,1);
        K = N - Feasible_num;
        Population_I = Population_I(index(1:K));
        Population = [Population_F,Population_I]; 
    else
        [PopObj_F,Extreme] = Normalization(Population_F);
        Population = WithoutConstraint(PopObj_F,Population_F,Extreme,N);
    end
    
end

function [PopObj,Extreme] = Normalization(Population)
    %% Normalization
    %Zmin         = min(Population(all(Population.cons<=0,2)).objs,[],1);
    PopObj = Population.objs;
    Zmin= min(PopObj,[],1);
    [N,M]  = size(PopObj);
    PopObj = PopObj - repmat(Zmin,N,1);
    
    % Detect the extreme points
    Extreme = zeros(1,M);
    w       = zeros(M)+1e-6+eye(M);
    for i = 1 : M
        [~,Extreme(i)] = min(max(PopObj./repmat(w(i,:),N,1),[],2));
    end
    % Calculate the intercepts of the hyperplane constructed by the extreme
    % points and the axes
    Hyperplane = PopObj(Extreme,:)\ones(M,1);
    a = 1./Hyperplane;
    if any(isnan(a))
        a = max(PopObj,[],1)';
    end
    % Normalization
    PopObj = PopObj./repmat(a',N,1);
end

function Population = WithoutConstraint(PopObj,Population,Extreme,N)
    [NN,~] = size(PopObj);
    %% Non-dominated sorting
    %[FrontNo,MaxFNo] = NDSort(Population.objs,N);
    [FrontNo,MaxFNo] = NDSort(PopObj,N);
    Snd_temp = find(FrontNo == 1);
    Sd_temp = find(FrontNo > 1);
    PopObj_Snd = PopObj(Snd_temp,:);
    PopObj_Sd = PopObj(Sd_temp,:);
    [N_Snd,M] = size(PopObj_Snd);
    
    Extreme_In_Snd = zeros(1,length(Extreme));
    for i=1:length(Extreme)
        Extreme_pos = find(Snd_temp==Extreme(i));
        if isempty(Extreme_pos)
            Extreme_pos = 0;
        end
        Extreme_In_Snd(i) = Extreme_pos;
    end
    
    %% Estimate shape
    q = EstimateShape(PopObj_Snd);
    I = ones(1,M);
    O = zeros(1,M);
    if q < 0.9
        referencePoint = I;
    else
        referencePoint = O;
    end
    
    %fitnessValue
    if q < 0.9
        PopObj_temp = PopObj - ones(NN,M);
        Con = sum(PopObj_temp.^2,2).^(1/2);
        Con = 1./Con;
    elseif q > 1.1
        Con = sum(PopObj.^2,2).^(1/2);
    else %Æ½Ãæ
        Con = sum(PopObj,2);
    end
    
    if N_Snd > N
        S_Minus_index = any(PopObj_Snd>1,2);
        S_Plus_index = ~S_Minus_index;
        if sum(S_Plus_index)>N
            Pop_index = Selection(PopObj_Snd,Con,Extreme_In_Snd,S_Plus_index,S_Minus_index,Snd_temp,N,q);
            %Population = Population(Pop_index);
        else
            %S_Plus_index_No = find(S_Plus_index==1);
            Pop_index = Snd_temp(S_Plus_index);
            K = N - length(Pop_index);
            Global_index = Snd_temp(S_Minus_index);
            ConST = Con(Global_index);
            [~,index] = sort(ConST,1);
            Pop_index = [Pop_index Global_index(index(1:K))];
        end
    else
        Pop_index = Snd_temp;
        K = N - length(Pop_index);
        ConST = Con(Sd_temp);
        [~,index] = sort(ConST,1);
        Pop_index = [Pop_index index(1:K)'];
    end
    Population = Population(Pop_index);
end

function q = EstimateShape(PopObj_Snd)
    [N,M]  = size(PopObj_Snd); 
    v = ones(1,M);
    Angle = acos(1-pdist2(PopObj_Snd,v,'cosine'));
    [~,index] = sort(Angle,1);
    indexS = index(1:min(M,length(index)));
    ClosestObj = PopObj_Snd(indexS,:);
    
    
    [N_temp,M]  = size(ClosestObj);
    d1_temp = sum(ClosestObj.^2,2).^(1/2);
    d1 = sum(d1_temp,1)/N_temp;
    
    q = d1*sqrt(M);
    
end

function Pop_index = Selection(PopObj_Snd,Con,Extreme_In_Snd,S_Plus_index,S_Minus_index,Snd_temp,N,q)
    Original_Snd_temp = Snd_temp;
    if q < 0.9
        Angle = acos(1-pdist2(1-PopObj_Snd,1-PopObj_Snd,'cosine'));
    else
        Angle = acos(1-pdist2(PopObj_Snd,PopObj_Snd,'cosine'));
    end
    %Angle = acos(1-pdist2(PopObj_Snd,PopObj_Snd,'cosine'));
    Angle(logical(eye(length(Snd_temp)))) = +inf;
    %Pop_index = Extreme;
    Extreme_In_Snd(Extreme_In_Snd==0) = [];
    Extreme_In_Snd = unique(Extreme_In_Snd);
    Pop_index = Original_Snd_temp(Extreme_In_Snd);
    S_Plus_index(Extreme_In_Snd) = 0;
    S_Plus_index_No = find(S_Plus_index==1);
    Remain_Snd = Extreme_In_Snd;
    %Snd_temp(Extreme_In_Snd) = [];
    
    if sum(S_Minus_index)>0
        %remove_one_by_one procedure
        while length(Pop_index)+length(S_Plus_index_No)>N
            [AA,BB] = min(Angle(S_Plus_index_No,S_Plus_index_No),[],2);
            [~,index1] = min(AA);
            index2 = BB(index1);
            Snd_index = [index1 index2];
            Global_index = [Snd_temp(S_Plus_index_No(index1)) Snd_temp(S_Plus_index_No(index2))];
            %Global_index1 = Snd_temp(index1);
            %Global_index2 = Snd_temp(index2);
            [~,index]=max(Con(Global_index));% index = 1 or 2

            r = Snd_index(index);
            %Snd_temp(S_Plus_index_No(r)) = [];
            S_Plus_index_No(r) = [];
            
        end
        Pop_index = [Pop_index Original_Snd_temp(S_Plus_index_No)];
    else
        %add_one_by_one procedure
        while length(Pop_index) < N
            [AA,~] = min(Angle(S_Plus_index_No,Remain_Snd),[],2);
            [~,index1] = max(AA);
            Remain_Snd = [Remain_Snd S_Plus_index_No(index1)];
            r = S_Plus_index_No(index1);
            Global_index = Snd_temp(r);
            Pop_index = [Pop_index Global_index];
            %Snd_temp(r) = [];
            S_Plus_index_No(index1) = [];
        end
    end

end
