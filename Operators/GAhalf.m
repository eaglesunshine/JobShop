function Offspring = GAhalf(Parent,Parameter)
%% Parameter setting
    if nargin > 1
        [proC,disC,proM,disM] = deal(Parameter{:});
    else
        [proC,disC,proM,disM] = deal(1,20,1,20);
    end
    if isa(Parent(1),'INDIVIDUAL')
        calObj = true;
        Parent = Parent.decs;
    else
        calObj = false;
    end
    Parent1 = Parent(1:floor(end/2),:);
    Parent2 = Parent(floor(end/2)+1:floor(end/2)*2,:);
    [N,D]   = size(Parent1);
    Global  = GLOBAL.GetObj();
 
    % �����������
    p_cross = 0.8;
    % �����������: p_muta = 1/D
    p_muta = 1/size(Parent,2);
    
    Offspring = [];
    
    for i = 1:N
        fa = Parent1(i,:);
        ma = Parent2(i,:);
        
        % ��ʼ�Ӵ�
        offspring1    = fa;
        offspring2    = ma;
        
        % ��������
        t_rand = rand();
        if t_rand < p_cross
            J1 = randperm(Global.num_job, randperm(Global.num_job,1));   % ������ֹ�����J1��J2
            if size(J1,2) < Global.num_job
                index_1 = ismember(fa,J1) > 0;
                index_2 = ones(1, D) - index_1  > 0;
                index_3 = ismember(ma,J1) > 0;
                index_4 = ones(1, D) - index_3 > 0;
                offspring1(index_2) = ma(index_4);      % ��fa������J1��λ���滻Ϊma
                offspring2(index_4) = fa(index_2);      % ��ma������J1��λ���滻Ϊfa
            end
        end
        
        % ��������
        t_rand = rand();
        if t_rand < p_muta
            k = 3;   % ȡ���k��λ�õĻ���������任˳��
            change_pos = randperm(D, k);
            index = randperm(k);
            old_data = offspring1(change_pos);
            new_data = old_data(index);
            offspring1(change_pos) = new_data;
            old_data = offspring2(change_pos);
            new_data = old_data(index);
            offspring2(change_pos) = new_data;
        end
        
        % �ռ��Ӵ�
        Offspring = [offspring1];
    end
    
    if calObj
        Offspring = INDIVIDUAL(Offspring);
    end
end