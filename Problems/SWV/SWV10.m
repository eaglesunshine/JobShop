classdef SWV10 < PROBLEM
    properties
        num_job = 20;           % ������Ŀ
        num_mach = 15;          	% ������Ŀ
        num_process = 15; 		% ������Ŀ
        process_time = [
            3 8 2 73 1 79 0 95 6 69 4 9 5 5 8 85 9 52 11 43 14 32 7 91 10 24 13 89 12 38 
			6 45 1 70 4 84 3 24 5 18 0 20 2 71 8 21 7 60 9 98 10 70 13 52 12 34 11 23 14 52 
			6 16 4 68 1 85 0 39 5 40 2 98 3 61 10 77 7 60 11 73 9 66 14 84 8 16 13 43 12 88 
			0 72 1 17 3 68 4 89 2 94 6 98 5 56 10 88 13 27 9 60 12 61 8 8 7 88 11 48 14 65 
			6 78 2 24 5 28 0 73 4 21 1 69 3 52 14 32 8 83 11 48 10 29 13 48 12 92 9 43 7 82 
			4 54 6 31 5 14 3 47 0 82 1 75 2 4 8 31 12 72 7 58 9 45 13 91 14 31 11 61 10 27 
			4 88 1 28 5 92 6 62 3 93 0 14 2 65 7 33 9 44 8 31 14 32 11 72 13 47 12 61 10 34 
			0 52 1 59 5 98 3 6 2 19 6 53 4 39 8 74 12 48 10 33 13 49 11 92 7 22 14 41 9 37 
			0 2 6 85 3 34 2 51 4 97 5 95 1 73 14 61 9 28 12 73 8 21 11 85 7 75 13 42 10 7 
			5 94 1 28 0 77 2 56 6 79 4 2 3 82 9 88 10 93 12 44 14 5 8 96 7 34 13 56 11 41 
			2 15 5 88 6 18 3 14 1 82 0 58 4 33 13 19 10 42 9 36 14 57 12 85 7 3 11 62 8 36 
			3 30 6 33 0 13 4 4 2 74 1 37 5 78 14 2 13 56 9 21 10 61 11 81 7 18 8 59 12 62 
			5 40 1 75 6 45 0 41 3 97 2 65 4 92 7 11 12 44 8 40 9 100 11 91 14 66 13 53 10 27 
			1 83 2 52 0 84 3 66 5 3 6 5 4 71 13 41 10 42 11 63 12 50 14 43 8 3 9 35 7 18 
			4 44 0 26 1 59 6 81 2 84 5 81 3 91 13 41 7 42 11 53 8 63 14 89 9 15 10 64 12 40 
			1 46 0 97 5 67 4 97 3 71 6 88 2 69 14 44 12 20 11 52 13 34 10 74 8 79 7 10 9 87 
			3 71 6 13 4 100 2 67 1 57 5 24 0 36 7 88 14 79 8 21 9 86 12 60 11 28 10 14 13 3 
			0 97 6 24 2 41 4 40 1 51 5 73 3 19 9 27 12 70 13 98 10 11 11 83 7 76 8 60 14 12 
			5 88 3 48 1 33 4 96 6 10 0 49 2 52 10 38 13 49 7 31 12 94 14 23 9 7 11 5 8 4 
			2 85 0 100 5 51 6 91 1 21 3 83 4 30 12 23 9 48 8 19 11 47 10 95 7 23 14 78 13 22 ] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
    methods
        %% Initialization
        function obj = SWV10()
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