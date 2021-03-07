function P = Estimate_P(Population)
    P_Pool = 0.1:0.1:2.5;
    Concavity = 0;%0��flat��ƽ�棩,-1��convex��͹����1��concave������
    CV = sum(max(0,Population.cons),2);
    Population = Population(CV<=0);%ֻ�Կ��н���й���
    PopObj = Normalization(Population.objs);
    [N,M] = size(PopObj);
    if N>5*M
        %%����ƽ��,����ȡ��͹��
        %��ȡ��ֵ��
        Extreme_PopObj = PopObj(SelectCornerSolutions(PopObj),:);
        %��ȡ���ĵ�
        CenterRef = ones(1,M);
        CenterRef = [CenterRef;(repmat(ones(1,M),M,1)+Extreme_PopObj)./2];
        Angle = acos(1-pdist2(CenterRef,PopObj,'cosine'));
        [~,BB] = min(Angle,[],2);
        Center_Objs = PopObj(BB,:);%M+1�����ĵ�
        
        %����ƽ��
        var = sym('x',[1,M]);
        d=-det([ones(M+1,1),[var;Extreme_PopObj]]);%ƽ�淽��
        aa = zeros(1,N);
        for i=1:N
            aa(i) = subs(d,var,PopObj(i,:));%��������б���Ƿ���ƽ���ϣ������ƽ���ϣ�������Ϊ�㡣
        end
        aa(aa<0) = -1;
        aa(aa>0) = 1;
        if sum(aa,2) > N/5
            Concavity = 1;
        elseif sum(aa,2) < -N/5
            Concavity = -1;
        else
            Concavity = 0;
        end
        
        %%������͹�̶�P
        trans_Center_Objs = cell(length(P_Pool),1);%length(P_Pool)=40
        trans_Extreme_PopObj = cell(length(P_Pool),1);
        for i=1:length(P_Pool)
            trans_Center_Objs(i)={Transfer_Obj(Center_Objs,P_Pool(i))};
            trans_Extreme_PopObj(i)={Transfer_Obj(Extreme_PopObj,P_Pool(i))};
        end
        
        Candidate = ones(1,M+1);
        for i=1:M+1
            PV = ones(1,M);
            for j=1:M
                EC = Center_Objs(i,:) - Extreme_PopObj(j,:);
                EC1=zeros(length(P_Pool),M);
                for k=1:length(P_Pool)
                    EC1(k,:) = trans_Center_Objs{k}(i,:) - trans_Extreme_PopObj{k}(j,:);
                end
                Angle = acos(1-pdist2(EC,EC1,'cosine'));
                [~,BB] = min(Angle,[],2);
                Can_PV=P_Pool(BB);%Can_PV:0.1~4
                if Concavity==0    %ƽ��
                    Can_PV=1;
                elseif Concavity==-1 && Can_PV>1.0%͹��
                    Can_PV=1;
                elseif Concavity==1 && Can_PV<1.0%����
                    Can_PV=1;
                end
                PV(j)=Can_PV;
            end
            statistics_PV = sortrows(tabulate(PV),2,'descend');
            Candidate(i) = statistics_PV(1,1);
        end
        statistics_Candidate = sortrows(tabulate(Candidate),2,'descend');
        P=statistics_Candidate(1,1);
        
    else
        P = 1.0;
    end
        
end

function tran_Obj=Transfer_Obj(PopObj,trans_P)
    Lp=trans_P;
    [~,M]=size(PopObj);
    PopObj=PopObj+10^-6;
    tran_Obj=PopObj./repmat((sum(PopObj.^Lp,2)).^(1/Lp),1,M);  
    %DAPT = pdist2(tran_Obj,tran_Obj,'euclidean');
end


