function Population = EnvironmentalSelection(Population,W,N)
% The environmental selection of theta-DEA
      %从结合种群中找出满足约束的个体
      CV = sum(max(0,Population.cons),2);
      
      Sc=find(sum(max(0,Population.cons),2)<=0);%可行解      
      
      if length(Sc)==N
          CA=Population(Sc);
      elseif length(Sc)>N
          %进行非支配排序
           ScPopulation=Population(Sc);
           [FrontNo,MaxFNo] = NDSort(ScPopulation.objs,N);
           St = find(FrontNo<=MaxFNo);
           
           Population=ScPopulation(St);
           PopObj =Population.objs;
           %PopObj = Normalization(PopObj);
           normP  = sqrt(sum(PopObj.^2,2));
           Cosine = 1 - pdist2(PopObj,W,'cosine');
           d2     = repmat(normP,1,size(W,1)).*sqrt(1-Cosine.^2);
          %%将个体划分到N个参考向量中
           [~,class] = min(d2,[],2);
           %计算每个个体的切比雪夫值
           for i=1:length(PopObj)
                g(i) =max(PopObj(i,:)./ W(class(i),:),[],2);
           end
           
           %计算个体之间的角度
            Angle = pdist2(PopObj,PopObj,'euclidean');
           Angle(logical(eye(length(PopObj)))) = +inf;
  
           
            Remain = 1 : length(PopObj);
            while length(Remain) > N
                %计算参考向量的密度
                  for i=1:length(W)
                        D(i)=length(find(class==i));
                  end
                     %密度最大的参考向量
                      [~,Tindex]=max(D);
                    %属于这个参考向量的个体
                     ID=find(class==Tindex);

                      [AA,index] = min(Angle(ID,ID),[],2);
                      [~,x] = min(AA);
                      y=index(x,1);
                       Temp_ID=ID([x,y]);

                       [~,in]=max(g(Temp_ID));
                       de=Temp_ID(in);
                       class(de)=-1;                      
                      Remain(Remain==de)=[];
            end
            CA = Population(Remain);
           
      else %Sc中个体不够，需要从剩余种群中挑选个体
          
          Si=find(sum(max(0,Population.cons),2)>0);
          SiPopulation=Population(Si);
          PopObj=SiPopulation.objs;
          PopObj = Normalization(PopObj);
          %参考向量归属
          normP  = sqrt(sum(PopObj.^2,2));
          Cosine = 1 - pdist2(PopObj,W,'cosine');
          d2     = repmat(normP,1,size(W,1)).*sqrt(1-Cosine.^2);
          
          %% Clustering
          [~,class] = min(d2,[],2);
          Cobjs(:,2)=max(PopObj./W(class,:),[],2);
          Cobjs(:,1)=CV(Si);
          
          [FrontNo,MaxFNo] = NDSort(Cobjs,N-length(Sc));
          St = find(FrontNo<MaxFNo);
          St_temp = find(FrontNo==MaxFNo);
          SiPopulation_temp = SiPopulation(St_temp);
          SiPopulation = SiPopulation(St);
          
          %PopObj = SiPopulation_temp.objs;
          %[PopObj,z,znad] = Normalization(PopObj,z,znad);
          %SPopulation=[Population(Sc) SiPopulation(St)];
          %PopObj=SPopulation.objs;
          CV_temp = sum(max(0,SiPopulation_temp.cons),2);
          [~,index] = sort(CV_temp);
          SiPopulation_temp = SiPopulation_temp(index(1:N-length(Sc)-length(St)));
          SiPopulation = [SiPopulation,SiPopulation_temp];
          CA = [Population(Sc),SiPopulation];
          
%           normP  = sqrt(sum(PopObj.^2,2));
%           Cosine = 1 - pdist2(PopObj,W,'cosine');
%           d2     = repmat(normP,1,size(W,1)).*sqrt(1-Cosine.^2);
%           %% Clustering
%           [~,class] = min(d2,[],2);
%           g=max(PopObj./W(class,:),[],2);
%           [~,index]=sort(g);
%           CA=SPopulation(index(1:N));
      end
         Population = CA;
end

