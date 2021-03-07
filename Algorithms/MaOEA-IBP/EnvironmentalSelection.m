function Population= EnvironmentalSelection(Population,K)
% The environmental selection of MaOEA-IBP

  %% Non-dominated sorting
  [FrontNo,MaxFNo] = NDSort(Population.objs,K);
  St = find(FrontNo<=MaxFNo);
  Population=Population(St);
  
  %% normalization of the Population
  PopObj= Normalization(Population.objs);
    [N,~]=size(PopObj);
    
   %% calculate the Euclidean distance between each individual and the curve/surface C
   P=0.3;
   Con= (sum(PopObj.^P,2)).^(1/P)-1;
  
   %% calculate the I?+(x, y) value of each two individuals 
    for i = 1 : N
        temp=repmat(PopObj(i,:),N,1)-PopObj;
        Angle(i,:) = max(temp,[],2);
    end
    Angle(logical(eye(N))) = +inf;
    
    %% eliminate
    Remain = 1 : length(PopObj);
    while length(Remain) > K
        % find a pair of the individuals with minimum I?+ value in population 
        [AA,index] = min(Angle(Remain,Remain),[],2);
        [teda,x] = min(AA);
        y=index(x,1);
        % eliminated the dominated individual from population
        if teda<0
            Remain(y) = [];
        else
            % boundary protection strategy to eliminate a individual
            if Con(Remain(x)) > Con(Remain(y)) 
                      Remain(x) = [];
                  else
                     Remain(y) = [];
            end
        end
    end
    Population = Population(Remain);
end
