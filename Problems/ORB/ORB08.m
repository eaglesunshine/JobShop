classdef ORB08 < PROBLEM
    properties
        num_job = 10;           % ������Ŀ
        num_mach = 10;          	% ������Ŀ
        num_process = 10; 		% ������Ŀ
        process_time = [
			0 55 1 74 2 45 3 23 4 76 5 19 6 18 7 61 8 44 9 11 
			0 63 1 43 2 51 3 18 4 42 7 11 6 29 5 52 9 29 8 88 
			2 88 1 31 0 47 4 10 3 62 5 60 6 58 7 29 8 52 9 92 
			2 16 1 71 0 55 4 55 3 9 7 49 6 83 5 54 9 7 8 57 
			1 7 0 41 4 92 3 94 2 46 6 79 5 34 9 38 8 8 7 18 
			1 25 0 5 4 89 3 94 2 14 6 94 5 20 9 23 8 44 7 39 
			1 24 2 21 4 47 0 40 3 94 6 71 7 89 9 75 5 97 8 15 
			1 5 2 7 4 74 0 28 3 72 5 61 7 9 8 53 9 32 6 97 
			0 34 2 52 3 37 4 6 1 94 6 6 7 56 9 41 5 5 8 16 
			0 77 2 74 3 82 4 10 1 29 5 15 7 51 8 65 9 37 6 21] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
    methods
        %% Initialization
        function obj = ORB08()
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