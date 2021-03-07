function Population = EnvironmentalSelection(Population,N,theta)
% The environmental selection of VaEA

%--------------------------------------------------------------------------
% Copyright (c) 2016-2017 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform
% for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
%    CV = sum(max(0,Population.cons),2);
   Sc=find(sum(max(0,Population.cons),2)<=0);
   Cand_Population=Population(sum(max(0,Population.cons),2)>0);
   Cand_CV = sum(max(0,Cand_Population.cons),2);
  [~,index]=sort(Cand_CV);
       
   if length(Sc)<=N
       Population=[Population(Sc) Cand_Population(index(1:N-length(Sc)))];
   else
         %% Non-dominated sorting
         RC_N=fix(theta*N);
         RC=[];
         if ~isempty(index) & RC_N>0
             RC=Cand_Population(index(1:min(RC_N,length(index))));
         end
         Population=Population(Sc);

         [FrontNo,MaxFNo] = NDSort(Population.objs,N-RC_N);
         
         %% Association operation
         Next   = [find(FrontNo<MaxFNo),find(FrontNo==MaxFNo)];
         Cons=[sum(max(Population(FrontNo<MaxFNo).cons,0),2);sum(max(Population(FrontNo==MaxFNo).cons,0),2)];
         
         Choose = Association(Population(FrontNo<MaxFNo).objs,Population(FrontNo==MaxFNo).objs,N-RC_N,Cons);
         Next   = Next(Choose);
         % Population for next generation
         Population = [RC Population(Next)];
   end
end

function Choose = Association(PopObj1,PopObj2,N,Cons)
% Association operation in the algorithm

    [N1,~] = size(PopObj1);
    [N2,M] = size(PopObj2);
    PopObj = [PopObj1;PopObj2];

    %% Normalization
    Zmin   = min(PopObj,[],1);
    Zmax   = max(PopObj,[],1);
%      PopObj = (PopObj-repmat(Zmin,size(PopObj,1),1))./repmat(Zmax-Zmin,size(PopObj,1),1);
    
    %% Calculate the fitness value of each solution
    fit = sum(PopObj,2);
    
    %% Angle between each two solutions
    angle = acos(1-pdist2(PopObj,PopObj,'cosine'));
    
    %% Niching
    Choose = [true(1,N1),false(1,N2)];
    if ~any(Choose)
        % Select the extreme solutions first
        [~,extreme]        = min(pdist2(PopObj2,eye(M),'cosine'),[],1);
        Choose(N1+extreme) = true;
        % Select the first M best converged solutions
        [~,rank] = sort(fit(N1+1:end));
        Choose(N1+rank(1:min(M,length(rank)))) = true;
    end
    while sum(Choose) < N
        % Maximum vector angle first
        Select  = find(Choose);
        Remain  = find(~Choose);
        [~,rho] = max(min(angle(Remain,Select),[],2));
        Choose(Remain(rho)) = true;
        % Worse elimination
        if ~all(Choose)
            Select      = [Select,Remain(rho)];
            Remain(rho) = [];
            [~,mu]      = min(min(angle(Remain,Select),[],2));
            [theta,r]   = min(angle(Remain(mu),Select));
            if  (Cons(Select(r))>0 & Cons(Remain(mu))<=0)    |  (theta < pi/2/(N+1) && fit(Select(r)) > fit(Remain(mu)))
                Choose(Select(r))  = false;
                Choose(Remain(mu)) = true;
            end
        end
    end
end