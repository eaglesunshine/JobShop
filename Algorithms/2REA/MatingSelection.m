function MatingPool = MatingSelection(PopObj,N,p,z,znad)
    % Normalization
   PopObj = (PopObj-repmat(z,size(PopObj,1),1))./repmat(znad-z ,size(PopObj,1),1); 
   
   C=Convergence_Calculate(PopObj);
   DAPT=Distribute_Calculate(PopObj,p);
   D  = sort(DAPT,2);
   dk = 1./(sum(D(:,2:ceil(end*0.1)),2)+1);
    
   for i = 1 : N
       Index = randperm(N,2);
       if C(Index(1))<C(Index(2)) & dk(Index(1))<dk(Index(2))
           MatingPool(i) = Index(1);
       elseif C(Index(1))>C(Index(2)) & dk(Index(1))>dk(Index(2))
           MatingPool(i) = Index(2);
       else
           if rand()<0.5
               MatingPool(i) = Index(1);
           else
               MatingPool(i) = Index(2);
           end
       end
   end
end

function [C]=Convergence_Calculate(PopObj)      
     C= sum(PopObj,2);
end
function [DAPT]=Distribute_Calculate(PopObj,Lp)
    [~,M]=size(PopObj);
    PopObj=PopObj+10^-6;
    tran_Obj=PopObj./repmat((sum(PopObj.^Lp,2)).^(1/Lp),1,M);  
    DAPT = pdist2(tran_Obj,tran_Obj,'euclidean');
end
