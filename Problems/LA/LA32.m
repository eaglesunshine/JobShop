classdef LA32 < PROBLEM
    properties
        num_job = 30;           % ������Ŀ
        num_mach = 10;          % ������Ŀ
        num_process = 10; % ������Ŀ
        process_time = [
            6 89 1 58 4 97 2 44 8 77 3 5 0 9 5 58 9 96 7 84 
			7 31 2 81 9 73 4 15 1 87 5 39 8 57 0 77 3 85 6 21 
			2 48 5 71 0 40 3 70 1 49 6 22 4 10 8 34 7 80 9 82 
			4 11 6 72 7 62 0 55 2 17 5 75 3 7 1 91 9 35 8 47 
			0 64 6 71 4 12 1 90 2 94 3 75 9 20 8 15 5 50 7 67 
			2 29 6 93 3 68 5 93 1 57 8 77 0 52 9 7 4 58 7 70 
			4 26 3 27 1 63 5 6 6 87 7 56 8 48 9 36 0 95 2 82 
			1 8 7 76 3 76 4 30 6 84 9 78 8 41 0 36 2 36 5 15 
			3 13 8 29 0 75 2 81 1 78 5 88 4 54 9 40 7 13 6 82 
			0 52 2 6 3 6 5 82 6 64 9 88 8 54 4 54 7 32 1 26 
			8 62 1 35 4 72 7 69 0 62 5 32 9 5 3 61 2 67 6 93 
			2 78 3 11 7 82 4 7 1 72 8 64 9 90 0 85 5 88 6 63 
			7 50 4 28 3 35 1 66 2 27 8 49 9 11 6 88 5 31 0 44 
			4 62 5 39 0 76 2 14 6 56 3 97 1 7 7 69 9 66 8 47 
			6 47 2 41 0 64 7 58 9 57 8 93 3 69 5 53 1 18 4 79 
			7 76 9 81 0 76 6 61 4 77 8 26 2 74 5 22 1 58 3 78 
			6 30 8 72 3 43 0 65 1 16 4 92 5 95 9 29 2 99 7 64 
			1 35 3 74 5 16 4 85 0 7 2 81 6 86 8 61 9 35 7 34 
			1 97 7 43 4 72 6 88 5 17 0 43 8 94 3 64 9 22 2 42 
			7 99 2 84 8 99 5 98 1 20 6 31 3 74 0 92 9 23 4 89 
			8 32 0 6 4 55 5 19 9 81 1 81 7 40 6 9 3 37 2 40 
			6 15 2 70 8 25 1 46 9 65 4 64 7 21 0 77 5 65 3 55 
			8 31 7 84 5 37 3 24 2 85 4 89 9 29 1 44 0 40 6 83 
			4 80 0 8 9 41 5 59 7 56 3 38 2 30 8 97 6 77 1 80 
			9 59 0 91 3 50 8 80 1 17 6 40 2 71 5 56 4 88 7 7 
			7 36 3 58 4 54 5 77 2 8 6 9 0 45 9 10 1 29 8 96 
			0 28 3 92 2 73 7 27 8 86 5 87 9 96 1 98 6 99 4 70 
			9 32 1 95 3 85 6 81 2 41 8 39 7 92 0 59 5 56 4 52 
			4 93 2 12 5 22 6 27 8 45 7 69 3 60 1 7 0 88 9 49 
			2 61 5 26 9 71 8 44 0 21 6 82 3 68 7 33 1 84 4 99 ] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
    methods
        %% Initialization
        function obj = LA32()
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