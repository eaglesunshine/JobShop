classdef SWV01 < PROBLEM
    properties
        num_job = 20;           % ������Ŀ
        num_mach = 10;          	% ������Ŀ
        num_process = 10; 		% ������Ŀ
        process_time = [
            3 19 2 27 1 39 4 13 0 25 8 37 9 40 5 54 7 74 6 93 
			2 69 0 30 4 1 3 4 1 64 7 71 5 2 9 84 6 31 8 8 
			4 79 3 80 0 86 2 55 1 54 8 81 6 72 7 86 5 59 9 75 
			2 76 3 15 1 26 0 17 4 30 8 44 7 91 6 83 5 52 9 68 
			4 73 3 87 1 74 0 39 2 98 9 100 5 43 8 17 7 7 6 77 
			1 63 0 49 2 16 3 55 4 9 9 73 5 61 8 34 6 82 7 46 
			0 87 1 71 4 43 3 80 2 39 7 70 8 18 6 41 9 79 5 44 
			4 70 2 22 0 73 3 62 1 64 5 25 8 19 6 69 9 41 7 28 
			3 16 0 84 1 58 4 7 2 9 5 8 6 10 7 17 8 42 9 65 
			3 8 0 10 1 3 4 41 2 3 7 40 8 56 5 53 9 96 6 13 
			4 62 1 60 3 64 2 12 0 39 5 2 7 64 6 87 9 21 8 60 
			2 66 1 71 3 23 4 75 0 78 7 74 6 35 9 24 8 23 5 50 
			1 5 3 92 4 6 0 69 2 80 7 13 5 17 9 89 6 80 8 47 
			0 82 3 84 1 24 2 47 4 93 7 85 5 34 6 73 8 28 9 91 
			4 55 0 57 3 63 2 24 1 40 7 30 6 37 5 99 8 88 9 41 
			1 75 2 47 3 68 0 7 4 78 7 80 6 2 9 23 8 49 5 50 
			0 91 4 25 2 10 1 21 3 94 8 6 7 59 5 84 9 75 6 70 
			2 85 1 31 0 94 4 94 3 11 5 21 9 7 6 61 8 50 7 93 
			1 27 0 77 4 13 2 30 3 2 5 88 7 4 9 39 6 53 8 54 
			1 34 2 12 3 31 0 24 4 24 7 16 5 6 9 88 8 81 6 11 ] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
    methods
        %% Initialization
        function obj = SWV01()
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