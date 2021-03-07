classdef LA34 < PROBLEM
    properties
        num_job = 30;           % ������Ŀ
        num_mach = 10;          % ������Ŀ
        num_process = 10; % ������Ŀ
        process_time = [
            2 51 7 59 1 35 5 73 9 65 0 27 6 13 3 81 8 32 4 74 
			4 64 7 33 5 75 2 33 8 10 0 28 3 38 6 53 9 49 1 55 
			6 83 1 23 2 72 3 7 9 72 0 6 4 39 5 52 8 90 7 21 
			3 82 1 23 2 93 4 78 6 88 7 53 9 28 8 65 5 21 0 61 
			4 41 6 12 9 12 3 77 1 70 7 24 0 81 5 73 2 62 8 6 
			4 98 3 28 6 42 9 72 0 15 8 15 5 94 2 33 1 51 7 99 
			0 32 8 22 9 96 4 15 6 78 3 31 5 7 1 94 2 23 7 86 
			7 93 2 97 3 43 5 73 0 24 8 68 9 88 1 42 4 35 6 72 
			2 14 0 44 8 13 5 67 1 63 3 49 7 5 4 17 6 85 9 66 
			7 82 9 15 3 72 4 26 0 8 1 68 6 21 8 45 2 99 5 27 
			4 93 6 23 0 51 8 54 3 49 1 96 2 56 9 36 5 53 7 52 
			8 60 0 14 4 70 9 55 1 23 5 83 3 38 2 24 7 37 6 48 
			0 62 7 15 8 69 9 23 1 82 6 26 4 45 5 33 3 12 2 37 
			6 72 1 9 7 15 5 28 8 92 9 12 0 59 3 64 4 87 2 73 
			0 50 1 14 7 90 5 46 3 71 4 48 2 80 9 61 8 24 6 44 
			0 22 9 94 5 16 3 73 2 54 8 54 4 46 1 97 6 61 7 75 
			9 55 3 67 6 77 4 30 7 6 1 32 8 47 5 93 2 6 0 40 
			1 30 3 98 7 79 0 22 6 79 2 7 8 36 9 36 5 9 4 92 
			8 37 7 72 2 52 4 31 1 82 9 54 5 7 6 82 3 73 0 49 
			1 73 3 83 7 45 2 76 4 43 9 29 0 35 5 92 8 39 6 28 
			2 58 0 26 1 48 8 52 7 34 6 96 5 70 4 98 3 80 9 94 
			1 70 8 23 5 26 4 14 6 90 2 93 3 21 0 42 7 18 9 36 
			4 28 6 76 7 25 0 17 1 84 2 67 8 87 3 43 9 88 5 84 
			7 30 3 91 8 52 4 80 0 21 5 8 9 37 2 15 6 12 1 92 
			1 28 4 7 7 46 6 92 2 77 3 15 9 69 8 54 0 47 5 39 
			9 50 5 44 2 64 8 38 4 93 6 33 7 75 0 41 1 24 3 5 
			7 94 0 17 6 87 2 21 8 92 9 28 1 61 4 63 3 34 5 77 
			3 72 8 98 9 5 4 28 2 9 5 95 6 64 1 43 0 50 7 96 
			0 85 2 85 8 39 1 98 7 24 3 71 5 60 4 55 9 22 6 35 
			3 78 6 49 2 46 1 11 0 90 5 20 9 34 7 6 4 70 8 74] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
    methods
        %% Initialization
        function obj = LA34()
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