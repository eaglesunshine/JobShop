function MatingPool = MatingSelection(PopObj)
        PopObj= Normalization(PopObj);
      [N,~]=size(PopObj);
    for i = 1 : N
        temp=PopObj-repmat(PopObj(i,:),N,1);
        d(i,:) = max(temp,[],2);   %��i�����嵽���и����ָ��ֵ
    end
    d(logical(eye(N))) = +inf;  %�Խ���Ԫ��
    d  = sort(d,2);  %��������
    dk = sum(d(:,1:ceil(end*0.1)),2);  % �����10��Ũ��
    for i = 1 : N
        p = randperm(N,2);  %���������������N��
        if(all(PopObj(p(1),:)>=PopObj(p(2),:),2))  %֧��
            index=p(2);
        else
            if (all(PopObj(p(1),:)<=PopObj(p(2),:),2))
                index=p(1);
            else
                 [~,b]=max(dk(p,:));  %����Ũ����С��һ��
                 index=p(b);
            end
        end
         MatingPool(i) = index;
    end
end