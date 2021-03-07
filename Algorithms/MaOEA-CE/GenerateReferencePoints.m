function [W,Lp,LPAll,isStable] = GenerateReferencePoints(Population,Global,z,znad,LPAll,W,Lp,isStable)
    
    interval = 50;

    if isStable > 0.1*Global.M
       Lp = Shape_Estimate(Population,Global.N,z,znad); 
       [W,~] = UniformPoint2(Global.N,Global.M,Lp); 
	   W = W./repmat(sum(W,2),1,Global.M);
       LPAll = [LPAll,Lp];
       
       if length(LPAll)>interval
           idx = length(LPAll)-interval+1:length(LPAll);
           isStable = sum(abs(LPAll(idx)-LPAll(idx-1)));
       end
       
       if isStable <= 0.1*Global.M
           Lp = mode(LPAll(idx));
           [W,~] = UniformPoint2(Global.N,Global.M,Lp); 
		   W = W./repmat(sum(W,2),1,Global.M);
       end
       
    else
        Lp = Lp;
        W = W;
    end
end

% Estimate the  shape of PF
function p= Shape_Estimate(Population,N,z,znad)
    %% Normalization
    [FrontNo,~] = NDSort(Population.objs,N);
    Population=Population(FrontNo<=1);  
    PopObj =Population.objs ;
    [N,~]=size(PopObj);
    
    % Normalization
    ZD = znad - z;
    ZD(ZD<1) = 1;
    PopObj = (PopObj-repmat(z,size(PopObj,1),1))./repmat(ZD ,size(PopObj,1),1);
    
    k=1.5; 
    CP=0.1:0.1:10; 
    for i=1:length(CP)
        Gp = (sum(PopObj.^CP(i),2)).^(1/CP(i));
        temp=sort(Gp);
        Q1=temp(max(fix(N*0.25),1));
        Q3=temp(max(fix(N*0.75),1));
        Max=Q3+k*(Q3-Q1);
        Gp(Gp>Max)=[]; 
        Vp(i)=std(Gp./max(Gp));  
    end  
    [~,index]=min(Vp);
    p=CP(index);
end

function [W,N] = UniformPoint2(N,M,Lp)
    H1 = 1;
    while nchoosek(H1+M,M-1) <= N
        H1 = H1 + 1;
    end
    W = nchoosek(1:H1+M-1,M-1) - repmat(0:M-2,nchoosek(H1+M-1,M-1),1) - 1;
    W = ([W,zeros(size(W,1),1)+H1]-[zeros(size(W,1),1),W]);  
    Temp_W=Regenerate(H1,Lp);  
   for i=1:H1+1
       W(W==(i-1))=Temp_W(i); 
   end
   
    if H1 < M
        H2 = 0;
        while nchoosek(H1+M-1,M-1)+nchoosek(H2+M,M-1) <= N
            H2 = H2 + 1;
        end
        if H2 > 0
            W2 = nchoosek(1:H2+M-1,M-1) - repmat(0:M-2,nchoosek(H2+M-1,M-1),1) - 1;
            W2 = ([W2,zeros(size(W2,1),1)+H2]-[zeros(size(W2,1),1),W2]);
           Temp_W=Regenerate(H2,Lp);   
           for i=1:H2+1
               W2(W2==(i-1))=Temp_W(i);
           end            
            W  = [W;W2/2+1/(2*M)];  
        end
    end
    W = max(W,1e-6);
    N = size(W,1);
end

function Temp_W = Regenerate(N,p)
    dx=0.00001; 
    x = 0:dx:1; 

    f = @(x) (1-x.^p).^(1/p); 
    y1 = f(x(1:length(x)-1)); 
    y2 = f(x(2:length(x)));   
    Temp=sqrt(dx^2+(y2-y1).^2);
    Sum1 = sum(sqrt(dx^2+(y2-y1).^2)); 
    Sub_Sum=Sum1/N;  

    for i=2:length(Temp)
        Temp(i)=Temp(i)+Temp(i-1);  
    end
		G=0:Sum1/N:Sum1;  
     
     for i=1:N+1
         [~,index]=min(abs(G(i)-Temp));  
         Temp_W(i)=x(index);
     end
end




