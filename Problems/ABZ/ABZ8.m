classdef ABZ8 < PROBLEM
    properties
        num_job = 20;           % ������Ŀ
        num_mach = 15;          % ������Ŀ
        num_process = 15; % ������Ŀ
        process_time = [
            0 19 9 33 2 32 13 18 10 39 8 34 6 25 4 36 11 40 12 33 1 31 14 30 3 34 5 26 7 13 
            9 11 10 22 14 19 5 12 4 25 6 38 0 29 7 39 13 19 11 22 1 23 3 20 2 40 12 19 8 26 
            3 25 8 17 11 24 13 40 10 32 14 16 5 39 9 19 0 24 1 39 4 17 2 35 7 38 6 20 12 31 
            14 22 3 36 2 34 12 17 4 30 13 12 1 13 6 25 9 12 7 18 10 31 0 39 5 40 8 26 11 37 
            12 32 14 15 1 35 7 13 8 32 11 23 6 22 4 21 0 38 2 38 3 40 10 31 5 11 13 37 9 16 
            10 23 12 38 8 11 14 27 9 11 6 25 5 14 4 12 2 27 11 26 7 29 3 28 13 21 0 20 1 30 
            6 39 8 38 0 15 12 27 10 22 9 27 2 32 4 40 3 12 13 20 14 21 11 22 5 17 7 38 1 27 
            11 11 13 24 10 38 8 15 9 19 14 13 5 30 0 26 2 29 6 33 12 21 1 15 3 21 4 28 7 33 
            8 20 6 17 5 26 3 34 9 23 0 16 2 18 4 35 12 24 10 16 11 26 7 12 14 13 13 27 1 19 
            1 18 7 37 14 27 9 40 5 40 6 17 8 22 3 17 10 30 0 38 4 21 12 32 11 24 13 24 2 30 
            11 19 0 22 13 36 6 18 5 22 3 17 14 35 10 34 7 23 8 19 2 29 1 22 12 17 4 33 9 39 
            6 32 3 22 12 24 5 13 4 13 1 11 0 11 13 25 8 13 2 15 10 33 11 17 14 16 9 38 7 24 
            14 16 13 16 1 37 8 25 2 26 3 11 9 34 4 14 0 20 6 36 12 12 5 29 10 25 7 32 11 12 
            8 20 10 24 11 27 9 38 5 34 12 39 7 33 4 37 2 31 13 15 14 34 3 33 6 26 1 36 0 14 
            8 31 0 17 9 13 1 21 10 17 7 19 13 14 3 40 5 32 11 25 2 34 14 23 6 13 12 40 4 26 
            8 38 12 17 3 14 13 17 4 12 1 35 6 35 0 19 10 36 7 19 9 29 2 31 5 26 11 35 14 37 
            14 20 3 16 0 33 10 14 5 27 7 31 8 16 6 31 12 28 9 37 4 37 2 29 11 38 1 30 13 36 
            11 18 3 37 14 16 6 15 8 14 12 11 13 32 5 12 1 11 10 29 7 19 4 12 9 18 2 26 0 39 
            11 11 2 11 12 22 9 35 14 20 7 31 4 19 3 39 5 28 6 33 10 34 1 38 0 20 13 17 8 28 
            2 12 12 25 5 23 8 21 6 27 9 30 14 23 11 39 3 26 13 34 7 17 1 24 4 12 0 19 10 36 ] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
     methods
        %% Initialization
        function obj = ABZ8()
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