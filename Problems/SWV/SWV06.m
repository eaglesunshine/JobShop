classdef SWV06 < PROBLEM
    properties
        num_job = 20;           % ������Ŀ
        num_mach = 15;          	% ������Ŀ
        num_process = 15; 		% ������Ŀ
        process_time = [
            1 16 6 58 2 22 4 24 5 53 3 9 0 57 10 63 8 92 12 43 7 41 13 26 14 20 9 44 11 93 
			2 89 1 94 0 86 3 13 6 54 4 41 5 55 7 98 13 38 14 80 9 1 11 100 12 90 10 63 8 14 
			1 26 6 96 3 32 4 75 5 9 0 57 2 39 12 54 14 28 10 8 11 30 13 57 9 75 7 9 8 41 
			3 37 2 36 5 63 0 24 6 71 1 97 4 74 14 19 12 45 8 24 11 71 13 53 10 61 9 6 7 32 
			3 57 0 55 1 21 5 84 2 23 6 79 4 90 11 8 14 59 10 99 9 41 12 68 8 14 13 4 7 55 
			4 10 2 81 1 13 3 78 0 78 5 10 6 48 9 37 11 21 7 88 12 75 14 11 13 55 10 93 8 51 
			6 100 2 52 3 54 1 37 5 26 4 74 0 87 8 13 12 88 10 94 14 73 7 55 11 68 9 50 13 88 
			4 47 5 70 6 7 2 72 0 62 3 30 1 95 10 18 9 65 7 69 13 89 8 89 14 64 12 81 11 25 
			6 1 1 10 0 72 3 59 4 92 5 53 2 89 14 52 7 48 8 8 13 69 10 49 9 26 12 76 11 97 
			6 85 2 47 4 45 1 99 0 39 5 32 3 87 10 56 8 98 11 13 7 96 12 71 14 95 9 11 13 78 
			0 17 2 21 3 87 6 41 5 41 4 31 1 96 8 17 11 95 13 29 14 3 10 71 7 64 9 97 12 31 
			6 9 0 87 4 34 1 62 3 56 5 66 2 95 9 56 14 42 8 86 7 68 12 82 10 82 13 52 11 97 
			3 86 1 37 2 49 0 2 6 30 5 63 4 4 14 47 8 84 10 5 13 13 9 39 12 18 7 76 11 63 
			0 29 6 34 1 53 3 7 5 19 4 26 2 63 12 22 10 98 13 77 14 11 7 87 9 5 11 44 8 42 
			6 44 4 91 1 91 2 58 0 77 3 51 5 14 13 1 9 17 7 55 12 40 8 95 14 31 11 54 10 37 
			5 59 4 47 1 56 6 39 2 7 0 43 3 39 13 75 10 43 12 32 9 6 11 93 7 69 8 47 14 93 
			4 24 1 30 3 97 6 17 0 7 2 55 5 8 7 70 10 87 8 29 12 20 13 29 11 51 9 14 14 32 
			2 29 4 99 3 17 0 96 1 50 5 67 6 91 10 91 13 14 12 14 7 19 8 36 11 11 14 83 9 6 
			0 7 6 60 3 31 5 76 1 23 2 83 4 30 8 73 14 76 11 17 10 53 13 9 12 72 7 89 9 24 
			3 63 0 89 2 2 1 46 6 86 5 74 4 1 7 34 9 30 12 19 13 48 11 75 8 72 14 47 10 58 ] 
        % ��i�еĵ�j��(x,y)��ֵ�Ե���ʽ����ʾ��i�Ź����ĵ�j��������Ҫ��x�Ż����ϼӹ�yʱ��
        
        O = []  % O(k,j)��ʾ����j�ĵ�k��������õĻ���id
        p = []  % p(k,j)��ʾ����j�ĵ�k������ӹ���ʱ��
        p_j = [] % p(j)��ʾ����j���ܼӹ�ʱ��
        p_all = 0 % ���й����ܼӹ���ʱ
    end
    
    methods
        %% Initialization
        function obj = SWV06()
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