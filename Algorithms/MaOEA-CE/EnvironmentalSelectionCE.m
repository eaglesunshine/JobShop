function [Population,z,znad,W,Rank,FrontNo] = EnvironmentalSelectionCE(Population,N,W,LP,a)
    PopObj =Population.objs ; 
    R     = 1 : size(PopObj,1);  
    M     = size(PopObj,2);
    [FrontNo,~] = NDSort(PopObj,N);     
    [corner]=SelectCornerSolutions1(PopObj,R,FrontNo);
    Rank = inf(1,size(PopObj,1));
    
    Front = find(FrontNo==1);
    znad  = max(PopObj(Front,:),[],1);
    z  = min(PopObj(Front,:),[],1);
    ZD = znad - z;
    ZD(ZD<1) = 1;
    PopObj = (PopObj-repmat(z,size(PopObj,1),1))./repmat(ZD ,size(PopObj,1),1);
    
    C = Convergence(PopObj);  
    D = Distribute(PopObj,LP,W); 
        
    [N1,~]=size(PopObj);    
    R     = 1 : N1;        
	oldR  = R;
    RNA = R(FrontNo(R)==1);  

    PopObj(PopObj<1e-6) = 1e-6;
    Angle_P=pdist2(W,PopObj(RNA,:),'cosine');
    oldW = W;
    W(min(Angle_P,[],2)>(0.01),:)=[]; 
    
    mdis = pdist2(PopObj(corner,:),PopObj(corner,:),'euclidean');
    mdis(logical(eye(size(mdis,1)))) = inf;
    mdis_min = min(mdis);
    for i=1:M
        if mdis_min(i)<0.1
            corner(i)=[];
            break;
        end
    end
    S = unique(corner);
    Rank(S)=0;
    R(S)=[];  
          
    for i = 1:M    
        RN=R(FrontNo(R)==min(FrontNo(R)));   
        APT_min=min(D(RN,S),[],2);    
        [~,APT_Sort]=sort(APT_min,'descend');      
        r=RN(APT_Sort(1));     
        S=unique([S,r]);       
        R(R==r)=[];  
        Rank(r)=1;
    end
    
	W(W<1e-6) = 1e-6;
	R = oldR;
    if size(W,1)>0
        for i=1:size(W,1)
            if LP>= 1.0
                normW   = sqrt(sum(W(i,:).^2,2));
                normP   = sqrt(sum(PopObj(RNA,:).^2,2));
                CosineP = sum(PopObj(RNA,:).*W(i,:),2)./normW./normP;
                g       = normP.*CosineP + 5*normP.*sqrt(1-CosineP.^2);
            else
                g = max(abs(PopObj(RNA,:))./W(i,:),[],2);
            end
            [~,rank] = min(g);
            S=unique([S,RNA(rank(1))]);
            [~,iR,~] = intersect(R,S);
            R(iR) = [];
            Rank(RNA(rank(1)))=2;
        end
    end
    
    while length(S)>N
        d = D(S,S);
        d(logical(eye(length(S)))) = +inf;
        d  = sort(d,2);
        dk = sum(d(:,1:5),2);
        [~,b]=min(dk);
        Rank(S(b))=inf;
        S(b)=[];       
    end
    
    [S,Rank] = Selection(S,R,C,D,N,FrontNo,PopObj,LP,M,Rank);

    Population=Population(S); 
    W = oldW;
    Rank(Rank==inf)=[];
    FrontNo = FrontNo(S);
end

function [S,Rank]=Selection(S,R,C,D,N,FrontNo,PopObj,LP,M,Rank)
    
    nrank=3;
    while length(S)<N    
        RN=R(FrontNo(R)==min(FrontNo(R)));      
        D_min=min(D(RN,S),[],2);    
        [~,D_Sort]=sort(D_min,'descend');
        bestD = RN(D_Sort(1));
        w = PopObj(bestD,:);
		w(w<1e-6) = 1e-6;
        
		if LP >= 1.0
			normW   = sqrt(sum(w.^2,2));
			normP   = sqrt(sum(PopObj(RN,:).^2,2));
			CosineP = sum(PopObj(RN,:).*w,2)./normW./normP;
			g       = normP.*CosineP + 5*normP.*sqrt(1-CosineP.^2);
		else         
			g = max(abs(PopObj(RN,:))./w,[],2);        
		end 
		
        [~,rank] = min(g);
        S=unique([S,RN(rank(1))]);
        [~,iR,~] = intersect(R,S);
        R(iR) = [];
        Rank(RN(rank(1)))=nrank;
        nrank=nrank+1;
    end    
end

function [corner]=SelectCornerSolutions1(PopObj,R,FrontNo)
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
        corner = [corner,RN(index)];
    end
end

function [C]=Convergence(PopObj)  
      C= sum(PopObj,2);
end

function [D]=Distribute(PopObj,Lp,W)
    if Lp>1
        D = pdist2(PopObj,PopObj,'cosine');
    elseif Lp==1
        PopObj=PopObj./repmat(sum(PopObj,2),1,size(PopObj,2));    
        D = pdist2(PopObj,PopObj,'euclidean');
    else
        PopObj = 1- PopObj;
        W = 1- W;
        D = pdist2(PopObj,PopObj,'cosine');
    end    
end
