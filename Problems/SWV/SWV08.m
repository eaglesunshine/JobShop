classdef SWV08 < PROBLEM
    properties
        num_job = 20;           % ������Ŀ
        num_mach = 15;          	% ������Ŀ
        num_process = 15; 		% ������Ŀ
        process_time = [
            3 8 4 73 2 49 5 24 6 81 1 68 0 23 12 69 8 74 10 45 11 4 14 59 9 25 7 70 13 68 
			3 34 2 33 5 7 1 69 4 54 6 18 0 38 8 28 12 12 14 50 10 66 7 81 9 81 13 91 11 66 
			0 8 6 20 3 52 4 83 5 18 2 82 1 68 7 50 14 54 11 6 10 73 13 48 9 20 8 93 12 99 
			2 41 0 72 1 91 4 52 5 30 3 1 6 92 13 52 8 41 9 45 14 43 12 97 10 64 11 71 7 76 
			0 48 1 44 5 49 6 92 3 29 2 29 4 88 14 14 10 99 8 22 13 79 9 93 12 69 11 63 7 68 
			0 56 6 42 2 42 3 93 1 80 4 54 5 94 12 80 14 69 11 39 8 85 10 95 13 12 9 28 7 64 
			0 90 4 75 6 9 1 46 2 91 3 93 5 93 14 77 9 63 11 50 12 82 13 74 8 67 7 72 10 76 
			0 55 2 90 6 11 3 60 4 75 1 23 5 74 11 54 7 97 12 32 13 67 10 15 14 48 8 100 9 55 
			6 71 5 64 2 40 0 32 3 92 1 59 4 69 13 68 14 34 12 71 8 28 9 94 7 82 10 1 11 58 
			6 36 4 46 1 50 5 87 3 33 2 94 0 3 14 60 11 45 13 84 9 1 8 38 10 22 12 39 7 50 
			1 53 0 34 5 56 6 97 3 95 4 32 2 28 14 48 7 54 12 98 8 84 9 77 10 46 13 65 11 94 
			2 1 5 97 0 77 4 82 6 14 1 18 3 74 14 52 11 14 12 93 9 35 8 34 13 84 10 6 7 81 
			1 62 0 86 2 57 6 80 5 37 3 94 4 77 7 72 9 26 11 41 10 7 8 56 13 98 14 67 12 47 
			5 45 3 30 0 57 6 68 1 61 2 34 4 2 7 57 13 96 9 10 12 85 14 42 10 93 8 89 11 43 
			6 49 4 53 1 51 2 4 0 17 5 21 3 31 10 45 13 45 9 63 11 21 8 4 7 23 14 90 12 1 
			6 68 5 18 0 87 3 6 4 13 2 9 1 40 8 83 7 95 12 27 10 94 14 68 11 22 13 28 9 66 
			2 80 6 14 0 67 5 15 1 14 3 97 4 23 8 45 10 1 11 5 14 87 7 34 12 12 9 98 13 35 
			4 33 2 20 3 74 6 20 5 3 0 90 1 37 13 56 12 38 8 7 14 84 9 100 11 41 10 6 7 97 
			6 47 4 63 3 1 0 28 2 99 1 41 5 45 14 60 13 2 7 25 8 59 9 39 10 76 11 89 12 5 
			6 67 2 46 3 25 1 2 5 22 4 8 0 22 13 64 7 82 12 99 11 79 10 87 8 71 9 24 14 19 ] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
    methods
        %% Initialization
        function obj = SWV08()
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