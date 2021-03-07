function Population = EnvironmentalSelection(Population,N,FeasibleFlag,curProgress,P)
    
    if curProgress<0.1 && FeasibleFlag==0
        [FrontNo,MaxFNo] = NDSort(max(0,Population.cons),N);
    else
        [FrontNo,MaxFNo] = NDSort(Population.objs,N);
    end
%     St_All = find(FrontNo<=MaxFNo);
%     PopObj = Normalization(Population(St_All).objs);
    St_In = find(FrontNo < MaxFNo);
    St_Fl = find(FrontNo == MaxFNo);
    St_All = [St_In St_Fl];
    Population = Population(St_All);
    CV = sum(max(0,Population.cons),2);
    PopObj = Normalization(Population.objs);
    %PopObj = Population.objs;
    %% Calculate the angle between each two solutions
    %%角度
    %Angle = acos(1-pdist2(PopObj,PopObj,'cosine'));
    Angle=Distribute_Calculate(PopObj,P);
    %Angle = pdist2(PopObj,PopObj,'euclidean');    
    Angle(logical(eye(length(St_All)))) = +inf;
    
    %Con = sum(PopObj.^2,2).^(1/2);
    %Con = sum(PopObj,2);
    if curProgress<0.1 && FeasibleFlag==0
        Con = CV;
    else
        %Con = sum(PopObj,2);
        %Con = sum(PopObj.^2,2).^(1/2);
        %Con = Calculate_Convergence(PopObj);
        Con = Calculate_Convergence3(PopObj,P);
    end
    %Con_backup = Con;
    %Con    = F_distance(PopObj); 
    Con(SelectCornerSolutions(PopObj)) = -inf;%M个边界点
    
    %Remain = 1 : length(St_Fl);
    St_In_length = length(St_In);
    Remain_All = 1 : length(St_All);
    %Remain_In = 1 : St_In_length;
    Remain_Fl = St_In_length+1 : length(St_All);
    %Deleted_Fl = 1 : 0;
    
    while length(Remain_Fl)+St_In_length > N
        [AA,BB] = min(Angle(Remain_Fl,Remain_All),[],2);
        
        Angle_temp = Angle;
        for i = 1:length(Remain_Fl)
            Angle_temp(Remain_Fl(i),Remain_All(BB(i)))=+inf;
        end
        [AA_second,BB_second] = min(Angle_temp(Remain_Fl,Remain_All),[],2);
        
        
        [~,index] = sort(AA,1);
        %ConS = Con(Remain_Fl)-Con(Remain_All(BB));
        ConST = Con(Remain_Fl)-0.25*(AA_second+AA);
        %nextToCorner = find(ConS==+inf);
        %ConS(nextToCorner) = Con(Remain_Fl(nextToCorner))-Con_backup(Remain_All(BB(nextToCorner)));
        indexS = index(1:min(length(Remain_Fl)+St_In_length - N+1,length(index)));
        RT=Remain_Fl(indexS);
        [~,index]=max(ConST(indexS));
        r=RT(index);
        Remain_Fl(Remain_Fl==r) = [];
        Remain_All(Remain_All==r) = [];
        %Deleted_Fl = [Deleted_Fl r];
    end
    
%     Angle2 = acos(1-pdist2(PopObj,PopObj,'cosine'));
%     Angle2(logical(eye(length(St_All)))) =+ inf;
%     for i = 1 : length(Deleted_Fl)
%         temp = Deleted_Fl(i);
%         [AA,BB] = min(Angle2(temp,Remain_All),[],2);
%         ConS = Con(temp)-Con(Remain_All(BB));
%         if AA < pi/2/(N+1) && ConS >0
%             Remain_All(BB)=[];
%             Remain_All= [Remain_All Deleted_Fl(i)];
%         end
%     end
    
      
%     [~,M]=size(PopObj);
%     %Distance = pdist2(PopObj(Deleted_Fl),PopObj(Remain_All),'euclidean');
%     Distance = pdist2(PopObj,PopObj,'euclidean');
%     %Distance = Angle;
%     Distance(logical(eye(length(St_All)))) =+ inf;
%     for i = 1 : 5
%         if isempty(Deleted_Fl)
%             break;
%         end
%         [AA,~] = min(Distance(Deleted_Fl,Remain_All),[],2);
%         [~,index] = max(AA);
%         r1=Deleted_Fl(index);
%         %要淘汰个体的选择
%         [AA,BB] = min(Distance(Remain_All,Remain_All),[],2);
%         [~,index] = sort(AA,1);
%         ConS = Con(Remain_All)-Con(Remain_All(BB));
%         indexS = index(1:min(2,length(index)));
%         RT=Remain_All(indexS);
%         [~,index]=max(ConS(indexS));
%         r2=RT(index);
%         
%         Deleted_Fl(Deleted_Fl==r1) = [];
%         Deleted_Fl=[Deleted_Fl r2];
%         Remain_All(Remain_All==r2) = [];
%         Remain_All=[Remain_All r1];
%     end
%     %确定哪些留下
%     %Remain = [Remain_In Remain_Fl];
    Population = Population(Remain_All);
end

function [c]=Calculate_Convergence(PopObj)      
      [~,M]=size(PopObj);
      if M==0
        c=[];
      else
        %reference = max(PopObj,[],1).*(1.1*ones(1,M));
        %reference = max(PopObj,[],1).*(1.1*ones(1,M));
        reference=1.1*ones(1,M);
        newPopObj=repmat(reference,size(PopObj,1),1)-PopObj;
        gg=cumprod(newPopObj,2);
         c=-gg(:,M);
         kk= sum(newPopObj<0,2);
        %c(kk>0,:)=sum(PopObj(kk>0,:).^2,2).^(1/2);
        c(kk>0,:)=sum(PopObj(kk>0,:),2);
      end
end

function [c]=Calculate_Convergence2(PopObj)      
      [~,M]=size(PopObj);
      if M==0
        c=[];
      else
        %c=sum(PopObj,2)./sqrt(M);
        c=sum(PopObj,2);
      end
end

function [c]=Calculate_Convergence3(PopObj,P)
        [~,M]=size(PopObj);
        Lp=P;
        if M==0
            c=[];
        else
            c=sum(PopObj.^Lp,2).^(1/Lp);
        end
end

function DAPT=Distribute_Calculate(PopObj,P)
    Lp=P;
    [~,M]=size(PopObj);
    PopObj=PopObj+10^-6;
    tran_Obj=PopObj./repmat((sum(PopObj.^Lp,2)).^(1/Lp),1,M);  
    DAPT = pdist2(tran_Obj,tran_Obj,'euclidean');
end
