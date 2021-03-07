classdef SWV19 < PROBLEM
    properties
        num_job = 50;           % ������Ŀ
        num_mach = 10;          	% ������Ŀ
        num_process = 10; 		% ������Ŀ
        process_time = [
            7 74 1 27 5 66 3 89 6 58 0 11 8 77 9 17 2 70 4 97 
			5 10 0 11 2 38 3 60 1 50 7 35 6 94 9 52 4 2 8 20 
			7 17 0 65 6 93 8 62 9 91 5 2 1 51 2 4 3 19 4 10 
			4 87 3 3 9 81 0 17 6 44 2 82 7 16 5 13 8 100 1 85 
			9 18 6 33 7 35 0 78 2 68 3 68 8 3 5 2 4 53 1 25 
			2 36 8 41 6 60 9 43 0 66 5 34 3 24 7 11 1 5 4 55 
			9 52 4 99 6 62 0 50 1 24 8 73 7 19 3 23 2 15 5 2 
			4 85 9 21 3 27 7 53 0 86 1 36 6 35 5 99 8 30 2 43 
			6 43 5 31 9 99 2 12 0 6 7 79 3 81 1 18 8 73 4 55 
			4 90 6 100 1 15 0 40 7 96 9 25 5 43 8 23 2 31 3 7 
			5 61 4 88 6 10 3 48 0 100 2 62 1 83 8 20 7 42 9 19 
			9 35 7 41 6 16 3 58 0 86 2 69 5 58 1 93 4 47 8 77 
			2 61 0 40 4 99 1 51 7 46 6 39 3 43 9 37 8 88 5 9 
			4 15 8 38 2 84 5 98 6 17 1 91 7 91 9 23 3 48 0 98 
			3 26 2 42 8 55 4 24 0 43 1 83 9 27 7 38 6 37 5 58 
			5 21 8 78 6 97 0 77 9 82 4 26 3 22 1 90 7 57 2 31 
			4 3 9 44 3 90 1 64 5 52 8 35 7 18 2 45 0 4 6 14 
			8 60 6 59 3 67 2 85 0 43 7 93 5 44 4 22 1 68 9 38 
			4 77 8 41 2 74 6 99 0 100 1 45 9 14 3 26 7 98 5 77 
			8 38 9 57 7 42 5 64 1 80 6 81 4 70 3 13 2 41 0 65 
			9 36 4 22 8 39 0 76 1 78 2 27 5 55 3 10 6 5 7 71 
			7 70 9 81 1 60 5 85 3 63 6 97 2 61 8 44 0 5 4 35 
			9 38 0 94 2 46 5 20 8 87 1 41 4 41 3 40 7 99 6 48 
			7 30 6 9 5 13 2 79 8 81 0 25 9 93 4 85 3 78 1 76 
			4 6 8 58 6 51 7 48 2 68 3 34 5 78 9 59 1 98 0 36 
			4 90 6 56 7 97 9 37 0 38 1 47 2 56 3 8 5 37 8 7 
			0 66 8 15 1 39 5 89 7 3 9 54 3 24 2 14 6 99 4 73 
			3 12 9 37 4 79 8 95 0 50 1 74 6 1 5 55 7 98 2 49 
			8 99 9 79 3 99 2 87 0 80 4 13 5 99 6 13 1 54 7 61 
			1 51 9 21 3 32 6 20 0 80 7 58 2 91 5 84 8 62 4 91 
			1 11 8 38 2 14 9 12 3 39 5 34 0 37 6 94 4 10 7 2 
			6 76 9 86 3 40 4 30 2 97 0 59 8 100 7 9 5 55 1 86 
			3 33 1 49 0 94 2 17 6 17 8 70 5 17 7 42 4 26 9 24 
			4 75 1 20 9 93 2 58 3 51 0 94 6 24 7 70 8 51 5 82 
			8 59 1 9 3 59 5 62 9 79 7 53 6 48 4 98 2 76 0 71 
			6 90 2 35 5 89 0 59 9 28 7 51 4 69 3 36 1 32 8 27 
			5 10 6 85 4 97 1 3 0 79 9 86 3 10 7 80 2 37 8 39 
			7 60 0 27 5 69 8 58 6 67 2 36 9 31 3 69 1 16 4 22 
			2 27 5 16 6 15 4 40 8 16 1 92 9 60 7 43 3 2 0 7 
			1 79 7 99 0 27 9 56 5 29 6 17 8 67 4 34 3 86 2 61 
			6 57 7 100 4 73 9 17 8 3 3 64 2 99 0 71 5 27 1 90 
			2 80 5 23 4 54 6 39 9 77 3 65 7 59 0 7 1 63 8 32 
			4 98 6 17 8 44 5 1 3 10 7 56 2 95 9 80 0 99 1 64 
			8 60 7 74 3 60 6 30 0 81 5 25 4 89 9 19 2 59 1 21 
			1 67 0 42 8 93 2 47 5 34 7 11 6 100 9 15 4 99 3 2 
			9 35 3 61 5 93 8 83 7 87 4 66 0 96 2 55 1 41 6 61 
			8 22 5 25 7 29 3 70 6 93 1 19 0 49 9 62 2 19 4 73 
			8 11 4 93 5 97 1 28 2 14 0 75 7 41 3 40 9 62 6 66 
			7 76 6 61 8 64 3 90 0 20 2 43 9 50 1 13 5 4 4 47 
			3 38 4 11 0 30 5 37 7 57 9 64 1 68 8 42 2 19 6 79  ] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
    methods
        %% Initialization
        function obj = SWV19()
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
                    T(num2str(i)) = [];   % ��������
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
                TT = 1.8 * obj.p_j;      % ����������
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