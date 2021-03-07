function [Population,z,znad] = EnvironmentalSelection(Population,N,p)
   PopObj =Population.objs ;
    R     = 1 : size(PopObj,1);         % Set of remaining solutions
    [FrontNo,~] = NDSort(PopObj,N); %Non-dominated sorting
    [corner,znad]=SelectCornerSolutions(PopObj,R,FrontNo);
    z =min(PopObj(FrontNo==1,:),[],1);
    % Normalization
   PopObj = (PopObj-repmat(z,size(PopObj,1),1))./repmat(znad-z ,size(PopObj,1),1); 
   C=Convergence_Calculate(PopObj);
   DAPT=Distribute_Calculate(PopObj,p);
   % Set the dmin value of each corner individual to +¡Þ
   DAPT(:,corner)=+99999;
   DAPT(corner,:)=+99999;
   % Move the individual r=arg min(c(R)) to S
   [~,S]=min(C);
   R(R==S)=[];
        
  while length(S)<N    
        %Let RN be the set of all non-dominated individuals in R
        RN=R(FrontNo(R)==min(FrontNo(R)));     
        
        % The first round selection
        APT_min=min(DAPT(RN,S),[],2);    
        [~,APT_Sort]=sort(APT_min,'descend'); 
        [~,Con_sort]=sort(C(RN));      
        Mean_APT=APT_min(APT_Sort(min(N-length(S),length(APT_Sort))));     
        index=find(APT_min(Con_sort)>(Mean_APT-1e-6));
         % The second round selection
         r=RN(Con_sort(index(1)));
        S=[S,r];      % add the selected individual r to S 
        R(R==r)=[];  %Remove r from R
  end
     Population = Population(S);
end
function[corner,znad]=SelectCornerSolutions(PopObj,R,FrontNo)
    [~,M]=size(PopObj);    
    W = zeros(M) + 1e-6;
    W(logical(eye(M))) = 1;
    RN=R(FrontNo(R)==1);
    corner=[];
    PopObj=PopObj(RN,:);
    [N,M]=size(PopObj);
    for i = 1:size(W,2)
        k = PopObj * W(:,i)./ norm(W(:,i));
        perpenVecs = PopObj -repmat(k,1,M).* repmat(W(:,i)',N,1);
        perpDist = sum(abs(perpenVecs).^2,2).^(1/2);
        [~,index] = min(perpDist);
        znad(i)=PopObj(index,i)+10^-6;
        corner = [corner,RN(index)];
    end
    znad(znad<1)=1;
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

