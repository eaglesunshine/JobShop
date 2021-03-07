classdef ABZ9 < PROBLEM
    properties
        num_job = 20;           % ������Ŀ
        num_mach = 15;          % ������Ŀ
        num_process = 15; % ������Ŀ
        process_time = [
            6 14 5 21 8 13 4 11 1 11 14 35 13 20 11 17 10 18 12 11 2 23 3 13 0 15 7 11 9 35 
            1 35 5 31 0 13 3 26 6 14 9 17 7 38 12 20 10 19 13 12 8 16 4 34 11 15 14 12 2 14 
            0 30 4 35 2 40 10 35 6 30 14 23 8 29 13 37 7 38 3 40 9 26 12 11 1 40 11 36 5 17 
            7 40 5 18 4 12 8 23 0 23 9 14 13 16 12 14 10 23 3 12 6 16 14 32 1 40 11 25 2 29 
            2 35 3 15 12 31 11 28 6 32 4 30 10 27 7 29 0 38 13 11 1 23 14 17 5 27 9 37 8 29 
            5 33 3 33 6 19 12 40 10 19 0 33 13 26 2 31 11 28 7 36 4 38 1 21 14 25 9 40 8 35 
            13 25 0 32 11 33 12 18 4 32 6 28 5 15 3 35 9 14 2 34 7 23 10 32 1 17 14 26 8 19 
            2 16 12 33 9 34 11 30 13 40 8 12 14 26 5 26 6 15 3 21 1 40 4 32 0 14 7 30 10 35 
            2 17 10 16 14 20 6 24 8 26 3 36 12 22 0 14 13 11 9 20 7 23 1 29 11 23 4 15 5 40 
            4 27 9 37 3 40 11 14 13 25 7 30 0 34 2 11 5 15 12 32 1 36 10 12 14 28 8 31 6 23 
            13 25 0 22 3 27 8 14 5 25 6 20 14 18 7 14 1 19 2 17 4 27 9 22 12 22 11 27 10 21 
            14 34 10 15 0 22 3 29 13 34 6 40 7 17 2 32 12 20 5 39 4 31 11 16 1 37 8 33 9 13 
            6 12 12 27 4 17 2 24 8 11 5 19 14 11 3 17 9 25 1 11 11 31 13 33 7 31 10 12 0 22 
            5 22 14 15 0 16 8 32 7 20 4 22 9 11 13 19 1 30 12 33 6 29 11 18 3 34 10 32 2 18 
            5 27 3 26 10 28 6 37 4 18 12 12 11 11 13 26 7 27 9 40 14 19 1 24 2 18 0 12 8 34 
            8 15 5 28 9 25 6 32 1 13 7 38 11 11 2 34 4 25 0 20 10 32 3 23 12 14 14 16 13 20 
            1 15 4 13 8 37 3 14 10 22 5 24 12 26 7 22 9 34 14 22 11 19 13 32 0 29 2 13 6 35 
            7 36 5 33 13 28 9 20 10 30 4 33 14 29 0 34 3 22 11 12 6 30 8 12 1 35 2 13 12 35 
            14 26 11 31 5 35 2 38 13 19 10 35 4 27 8 29 3 39 9 13 6 14 7 26 0 17 1 22 12 15 
            1 36 7 34 11 33 8 17 14 38 6 39 5 16 3 27 13 29 2 16 0 16 4 19 9 40 12 35 10 39  ] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
     methods
        %% Initialization
        function obj = ABZ9()
            % ����ÿ��������Ҫ�Ĺ�����Ŀ
            obj.num_process = size(obj.process_time, 2) / 2;
            % copy���⼯��GLOBAL
            obj.Global.num_job = obj.num_job;
            obj.Global.num_mach = obj.num_mach;
            obj.Global.num_process = obj.num_process;
            obj.Global.process_time = obj.process_time;
            
            % ��������ά�ȴ�С
            obj.Global.D = obj.num_job * obj.num_process;
            % ���߱���ÿ��ά���ϵ�ȡֵ��Χ
            obj.Global.lower    = ones(1,obj.Global.D);
            obj.Global.upper    = ones(1,obj.Global.D) + obj.num_process - 1;
            % ���߱����ı��뷽��
            obj.Global.encoding = 'real';
            
            % Ԥ����
            obj.O = zeros(obj.num_process,obj.num_job);  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
            obj.p = zeros(obj.num_process,obj.num_job);  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
            for k = 1:obj.num_process
               for j = 1:obj.num_job
                   obj.O(k,j) = obj.process_time(j, 2*k - 1) + 1;   % ����0��ʼ��Ÿ�Ϊ��1��ʼ���
                   obj.p(k,j) = obj.process_time(j, 2*k);
               end
            end
            obj.p_j = sum(obj.p, 1);
            obj.p_all = sum(obj.p_j);
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            %{
            n ��������t ̨������m������
            ���ڹ���ı��룺����һ�� n �������� m ̨�����ӹ��ĵ������⣬��Ⱦɫ���� n��m ��������ɣ�ÿ���������
                ֻ����Ⱦɫ���г��� m �Σ�������ɨ��Ⱦɫ�壬���ڵ� k �γ��ֵĹ�����ţ���ʾ�ù����ĵ� k ������
            %}
            
            n = obj.num_job;
            m = obj.num_process;
            t = obj.num_mach;

            % ��ʼ��Ŀ��ֵ��5Ŀ��
            PopObj = zeros(size(PopDec,1), 5);
            
            % �������Ŀ��ֵ
            for index = 1:size(PopDec, 1)
                sub_PopDec = PopDec(index,:);
            
                % ���룺ÿһ�������й����ļӹ�˳��T(i,j)��ʾ����i�ӹ��ĵ�j��������id
                job_index = zeros(1,n);
                T = containers.Map;     % ���� Map ����
                for i = 1:t
                    T(num2str(i)) = [];   % �������
                end
                
                % ����ÿ����������ʱ����C={C(O(j,k),j)|k=1~m,j=1~n}��C(O(j,k),j)��ʾ����j��k�������ڻ���O(j,k)�ϵ��깤ʱ��
                C = zeros(t, m);     
                CT = zeros(n, m);
                
                first_j = -1;    % ��¼��һ������
                last_j =  -1;    % λ�ڱ���������һ������id
                % �ڿ��л����ϰ������й���˳�����μӹ���Ӧ�Ĺ���
                for i = 1:size(sub_PopDec, 2)
                    j = sub_PopDec(i);                          % ��ʾ�ӹ��Ĺ���
                    job_index(j) = job_index(j) + 1;     
                    idx = job_index(j);                         % ��ʾ����j��ǰλ�ڵڼ�������
                    if idx>obj.num_process
                        j_count = sum(find(sub_PopDec==j))
                    end
                    ma = obj.O(idx, j);
                    
                    % ����j�ڽ׶�k���깤ʱ�䣬���ڹ���j��ǰ������깤ʱ���ͬһ������ǰ����j-1���깤ʱ���е����ֵ���Ϲ���j�ڽ׶�k�ļӹ�ʱ��
                    if isempty(T(num2str(ma))) == false 	% ͬһ�������н�ǰ�����ӹ�
                        tmp = T(num2str(ma));
                        last_j = tmp(end);
                        if idx == 1	% ��ǰΪ�ù����ĵ�һ������
                            C(obj.O(idx,j), j) = C(obj.O(idx,j), last_j) + obj.p(idx,j);
                        else 	% ��ǰΪ�ù����ķǵ�һ������
                            C(obj.O(idx,j), j) = max(C(obj.O(idx,j), last_j), C(obj.O(idx - 1,j), j)) + obj.p(idx,j);
                        end  
                    else	% ͬһ������û���н�ǰ����
                        if idx == 1	 % ��ǰΪ�ù����ĵ�һ������
                            C(obj.O(idx,j), j) =  obj.p(idx,j);
                        else 	% ��ǰΪ�ù����ķǵ�һ������
                            C(obj.O(idx,j), j) = C(obj.O(idx - 1,j), j) + obj.p(idx,j);
                        end  
                    end
                    T(num2str(ma)) = [T(num2str(ma)), j];	 % ���ù���push����Ӧ���������������
                    CT(idx, j) = C(obj.O(idx,j), j);    % ����j��ɵ�idx������ķѵ�ʱ��
                end
                
                % ����ÿ���������깤ʱ��
                C1 = CT(m,:);
                
                % ���ڼӹ����ʱ�������ָ�� ������ʱ��:���һ̨�����ӹ�������һ�����������һ����������Ҫ���ѵ�ʱ�䡣ԽСԽ��
                f1 = max(C1);
                % ���ڼӹ����ʱ�������ָ�� ������ʱ��:��ָ���еĹ�����ɸù��������һ���ӹ����������ѵ�ʱ���ܺ͡�ԽСԽ��
                f2 = sum(C1);
                % ���ڽ����ڵ�����ָ�� ������ʱ��:Ϊ���й���������ʱ���ܺ͡�ԽСԽ��
                D = 1.5 * obj.p_j;       % ��������Ϊ���������л����ϵļӹ�ʱ���ܺ͵� 1.5 ��
                f3 = sum(max(0,(C1 - D)));
                % ���ڿ�������ָ�� ƽ����������ʱ��:ÿ̨�����ӿ�ʼ��ͣ���м�Ŀ���ʱ�䡣ԽСԽ��
                [max_C,~]=max(C,[],2);   % ����ÿ̨����������ʱ��
                f4 = (sum(max_C) - obj.p_all) / n;
                % ����׼ʱ�ƣ�JIT������ģʽ������ָ�� E/T ָ�ꡣԽСԽ�� 
                EE = 1.2 * obj.p_j;      % ���罻����
                TT = 1.8 * obj.p_j;      % ��������
                f5 = sum(0.5 * max(0, (EE - C1)) + 0.5 * max(0, (C1 - TT)));     % ��ǰ�깤�������깤��ʱ��ͷ�ϵ��������Ϊ0.5
                
                % �ռ�Ŀ��ֵ
                PopObj(index,:) = [f1 f2 f3 f4 f5];
            end
            
        end
        
        %% cons
        function Cons = CalCon(obj,PopDec)
            Cons = zeros(size(PopDec, 1), 1);
        end
    end

   
end