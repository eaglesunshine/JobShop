function MatingPool = MatingSelection(PopObj)
        PopObj= Normalization(PopObj);
      [N,~]=size(PopObj);
    for i = 1 : N
        temp=PopObj-repmat(PopObj(i,:),N,1);
        d(i,:) = max(temp,[],2);   %第i个个体到所有个体的指标值
    end
    d(logical(eye(N))) = +inf;  %对角线元素
    d  = sort(d,2);  %按行排序
    dk = sum(d(:,1:ceil(end*0.1)),2);  % 最近的10个浓度
    for i = 1 : N
        p = randperm(N,2);  %随机生成两个数在N中
        if(all(PopObj(p(1),:)>=PopObj(p(2),:),2))  %支配
            index=p(2);
        else
            if (all(PopObj(p(1),:)<=PopObj(p(2),:),2))
                index=p(1);
            else
                 [~,b]=max(dk(p,:));  %保留浓度最小的一个
                 index=p(b);
            end
        end
         MatingPool(i) = index;
    end
end