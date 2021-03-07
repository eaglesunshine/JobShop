function MatingPool = MatingSelection(PopObj)

 %% normalization of the Population
      PopObj= Normalization(PopObj);
      [N,~]=size(PopObj);
      
 %% calculate the I?+(x, y) value of each two individuals 
    for i = 1 : N
        temp=PopObj-repmat(PopObj(i,:),N,1);
        d(i,:) = max(temp,[],2);
    end
    d(logical(eye(N))) = +inf;
    d  = sort(d,2);
    
    %% calculate the density of each solution 
    dk = sum(d(:,1:ceil(end*0.1)),2);
    
    %% Selection
    for i = 1 : N
        % randomly selection  two individuals  from the parent population
        p = randperm(N,2);
        % select the dominate individual  to join the mating pool
        if(all(PopObj(p(1),:)>=PopObj(p(2),:),2))
            index=p(2);
        else
            % density estimate to select individual
            if (all(PopObj(p(1),:)<=PopObj(p(2),:),2))
                index=p(2);
            else
                 [~,b]=max(dk(p,:));
                 index=p(b);
            end
        end
         MatingPool(i) = index;
    end
end