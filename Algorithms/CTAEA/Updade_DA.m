function DA = Updade_DA(DA,CA,W,N)
          %将DA划分到N个参考向量中
           DAPopObj=DA.objs;
           %DAPopObj = Normalization(DAPopObj);
           normP  = sqrt(sum(DAPopObj.^2,2));
           Cosine = 1 - pdist2(DAPopObj,W,'cosine');
           d2     = repmat(normP,1,size(W,1)).*sqrt(1-Cosine.^2);
          %%将个体划分到N个参考向量中
           [~,DAclass] = min(d2,[],2);
           
           %将CA划分到N个参考向量中
          CAPopObj=CA.objs;
          %CAPopObj = Normalization(CAPopObj);
          normP  = sqrt(sum(CAPopObj.^2,2));
          Cosine = 1 - pdist2(CAPopObj,W,'cosine');
          d2     = repmat(normP,1,size(W,1)).*sqrt(1-Cosine.^2);
          %%将个体划分到N个参考向量中
           [~,CAclass] = min(d2,[],2);
           
             for i=1:length(W)
                  %计算CA个体参考向量的密度
                   CD(i)=length(find(CAclass==i));
                  %计算DA个体参考向量的密度
                   %DD(i)=length(find(DAclass==i));
             end
            
              %计算每个DA个体的切比雪夫值
           for i=1:length(DAPopObj)
                g(i) =max(DAPopObj(i,:)./ W(DAclass(i),:),[],2);
           end

            %Remain     = 1 : N;       
            Rp=[];
            itl=1;
            while length(Rp)<N
                 %计算参考向量的密度
                  Index=max(itl-CD,0);

                  for i=1:N
                      if Index(i)>0 && ~isempty(find(DAclass==i, 1))
                          for j=1:Index(i)
                              in=find(DAclass==i);
                              if isempty(in)
                                  break;
                              end

                              [FrontNo,~] = NDSort(DAPopObj(in),1); 
                              St = find(FrontNo==1);
                              inn = in(St);
                              [~,b]=min(g(inn));
                              inn=inn(b);
                              Rp=[Rp inn];
                              DAclass(inn)=-1;
                              if length(Rp)==N
                                  break;
                              end
                          end
                      end
                      if length(Rp)==N
                          break;
                      end
                  end
                  itl=itl+1;
            end
           DA=DA(Rp);
end

