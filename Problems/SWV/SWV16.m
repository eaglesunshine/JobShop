classdef SWV16 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            1 55 3 46 5 71 8 29 0 47 2 12 7 57 4 79 6 91 9 30 
			2 96 6 94 8 98 0 55 3 10 1 95 5 95 7 37 9 82 4 2 
			6 43 3 93 8 30 2 41 0 23 1 60 7 14 4 15 5 42 9 56 
			0 45 6 85 2 59 7 76 1 93 9 62 4 33 8 46 5 33 3 35 
			2 45 3 36 8 11 6 96 7 96 1 8 0 75 5 6 4 13 9 2 
			9 51 7 75 0 4 3 13 5 12 1 4 2 38 6 30 4 42 8 28 
			9 58 4 33 6 77 2 11 3 37 8 64 5 94 7 89 1 96 0 93 
			6 37 3 67 0 88 9 92 8 19 4 27 7 46 1 58 2 60 5 55 
			4 60 2 88 0 23 5 69 8 60 1 32 7 4 6 56 9 25 3 14 
			2 98 5 56 1 68 6 63 7 61 3 78 8 45 0 62 4 31 9 70 
			7 66 8 80 0 18 3 97 9 47 5 38 1 26 2 8 6 90 4 90 
			0 16 7 6 4 53 6 86 5 81 8 49 3 90 2 57 1 34 9 56 
			2 69 8 65 5 20 4 15 1 61 3 71 6 71 9 58 0 24 7 71 
			4 84 5 20 9 58 0 55 8 98 2 75 7 46 3 81 1 71 6 46 
			5 6 6 58 7 90 1 54 9 73 0 92 4 39 3 23 2 100 8 18 
			2 32 5 58 6 97 1 49 3 61 0 69 8 2 4 3 9 32 7 46 
			0 78 7 14 4 98 3 26 8 25 9 45 6 12 2 98 1 99 5 69 
			2 50 1 95 4 82 9 25 0 68 8 83 5 36 7 78 3 35 6 27 
			6 29 7 20 8 55 4 14 2 66 5 52 0 75 9 63 1 93 3 64 
			1 11 0 18 9 42 4 81 7 2 2 39 3 83 6 11 5 38 8 52 
			4 11 8 99 9 2 7 10 3 91 5 83 6 61 0 21 2 69 1 8 
			9 11 7 65 1 14 2 85 3 5 8 5 5 11 4 47 6 67 0 41 
			9 60 7 9 8 16 2 4 5 34 6 2 4 30 1 32 0 51 3 51 
			9 31 2 41 1 13 6 28 5 97 3 8 7 42 4 95 8 46 0 93 
			4 1 6 91 8 49 3 75 1 19 7 100 0 58 2 14 5 34 9 82 
			3 28 5 68 9 30 7 68 1 10 6 20 8 47 4 51 0 44 2 32 
			9 86 3 9 1 80 0 89 5 93 4 12 8 13 7 10 6 18 2 4 
			0 22 5 12 8 95 4 24 3 30 1 81 2 21 7 28 9 100 6 27 
			1 87 0 68 2 64 3 33 7 59 5 95 6 1 9 14 8 82 4 43 
			2 14 6 98 0 86 1 85 8 85 5 12 4 99 7 8 3 21 9 7 
			5 47 9 90 0 88 1 52 8 43 4 62 7 33 3 51 6 97 2 22 
			2 59 7 26 4 76 0 26 3 71 8 59 1 73 9 70 5 57 6 10 
			6 92 2 10 9 45 0 11 1 53 3 35 8 76 4 83 7 55 5 79 
			9 96 4 3 3 92 7 67 6 60 8 35 5 70 0 52 2 39 1 94 
			4 65 0 17 9 26 7 46 5 81 1 42 2 64 6 46 3 96 8 59 
			9 6 3 21 8 46 0 82 2 74 5 56 7 94 6 83 4 63 1 21 
			6 89 5 23 8 78 2 33 9 4 7 97 3 60 1 29 0 79 4 93 
			0 46 1 46 4 20 7 91 2 76 9 83 3 14 6 61 5 84 8 76 
			7 82 8 43 6 76 1 36 0 27 9 93 5 71 4 81 2 45 3 62 
			7 51 9 27 5 12 6 52 4 85 8 66 0 100 3 44 2 82 1 36 
			3 75 7 13 6 63 1 78 4 1 8 60 2 24 5 10 9 56 0 3 
			5 48 4 32 2 82 0 1 1 2 7 35 3 16 9 67 8 74 6 39 
			7 24 0 8 8 96 3 59 2 41 4 23 1 37 9 4 5 69 6 27 
			1 23 9 3 2 85 6 93 5 18 7 47 0 96 8 6 4 60 3 3 
			6 99 2 14 9 16 3 81 8 89 1 53 7 86 4 39 5 3 0 87 
			5 67 8 53 0 77 4 69 2 55 3 78 6 95 1 76 7 2 9 71 
			1 5 6 89 0 37 3 88 7 20 9 4 4 77 8 27 5 31 2 47 
			1 66 2 55 4 15 7 35 3 76 9 91 6 35 5 37 8 54 0 33 
			3 79 5 2 6 17 1 65 7 27 8 53 4 52 9 35 0 23 2 59 
			9 100 0 55 5 14 2 86 4 69 3 87 8 46 1 3 6 89 7 100  ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV16()
            % 计算每个工件需要的工序数目
            obj.num_process = size(obj.process_time, 2) / 2;
            % copy问题集到GLOBAL
            obj.Global.num_job = obj.num_job;
            obj.Global.num_mach = obj.num_mach;
            obj.Global.num_process = obj.num_process;
            obj.Global.process_time = obj.process_time;
            
            % 决策向量维度大小
            obj.Global.D = obj.num_job * obj.num_process;
            % 决策变量每个维度上的取值范围
            obj.Global.lower    = ones(1,obj.Global.D);
            obj.Global.upper    = ones(1,obj.Global.D) + obj.num_process - 1;
            % 决策变量的编码方法
            obj.Global.encoding = 'real';
            
            % 预处理
            obj.O = zeros(obj.num_process,obj.num_job);  % O(k,j)表示工件j的第k道工序采用的机器id
            obj.p = zeros(obj.num_process,obj.num_job);  % p(k,j)表示工件j的第k道工序加工的时间
            for k = 1:obj.num_process
               for j = 1:obj.num_job
                   obj.O(k,j) = obj.process_time(j, 2*k - 1) + 1;   % 将从0开始编号改为从1开始编号
                   obj.p(k,j) = obj.process_time(j, 2*k);
               end
            end
            obj.p_j = sum(obj.p, 1);
            obj.p_all = sum(obj.p_j);
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            %{
            n 个工件，t 台机器，m道工序：
            基于工序的编码：对于一个 n 个工件在 m 台机器加工的调度问题，其染色体由 n×m 个基因组成，每个工件序号
                只能在染色体中出现 m 次，从左到右扫描染色体，对于第 k 次出现的工件序号，表示该工件的第 k 道工序。
            %}
            
            n = obj.num_job;
            m = obj.num_process;
            t = obj.num_mach;

            % 初始化目标值：5目标
            PopObj = zeros(size(PopDec,1), 5);
            
            % 逐个计算目标值
            for index = 1:size(PopDec, 1)
                sub_PopDec = PopDec(index,:);
            
                % 解码：每一道工序中工件的加工顺序，T(i,j)表示机器i加工的第j各工件的id
                job_index = zeros(1,n);
                T = containers.Map;     % 声明 Map 对象
                for i = 1:t
                    T(num2str(i)) = [];   % 添加数据
                end
                
                % 计算每道工序的完成时间用C={C(O(j,k),j)|k=1~m,j=1~n}：C(O(j,k),j)表示工件j第k道工序在机器O(j,k)上的完工时间
                C = zeros(t, m);     
                CT = zeros(n, m);
                
                first_j = -1;    % 记录第一个工件
                last_j =  -1;    % 位于本机器的上一个工件id
                % 在空闲机器上按编码中工件顺序依次加工相应的工件
                for i = 1:size(sub_PopDec, 2)
                    j = sub_PopDec(i);                          % 表示加工的工件
                    job_index(j) = job_index(j) + 1;     
                    idx = job_index(j);                         % 表示工件j当前位于第几道工序
                    if idx>obj.num_process
                        j_count = sum(find(sub_PopDec==j))
                    end
                    ma = obj.O(idx, j);
                    
                    % 工件j在阶段k的完工时间，等于工件j紧前工序的完工时间或同一机器紧前工件j-1的完工时间中的最大值加上工件j在阶段k的加工时间
                    if isempty(T(num2str(ma))) == false 	% 同一机器上有紧前工件加工
                        tmp = T(num2str(ma));
                        last_j = tmp(end);
                        if idx == 1	% 当前为该工件的第一道工序
                            C(obj.O(idx,j), j) = C(obj.O(idx,j), last_j) + obj.p(idx,j);
                        else 	% 当前为该工件的非第一道工序
                            C(obj.O(idx,j), j) = max(C(obj.O(idx,j), last_j), C(obj.O(idx - 1,j), j)) + obj.p(idx,j);
                        end  
                    else	% 同一机器上没有有紧前工件
                        if idx == 1	 % 当前为该工件的第一道工序
                            C(obj.O(idx,j), j) =  obj.p(idx,j);
                        else 	% 当前为该工件的非第一道工序
                            C(obj.O(idx,j), j) = C(obj.O(idx - 1,j), j) + obj.p(idx,j);
                        end  
                    end
                    T(num2str(ma)) = [T(num2str(ma)), j];	 % 将该工件push到对应机器的任务队列上
                    CT(idx, j) = C(obj.O(idx,j), j);    % 工件j完成第idx道工序耗费的时间
                end
                
                % 计算每个工件的完工时间
                C1 = CT(m,:);
                
                % 基于加工完成时间的性能指标 最大完成时间:最后一台机器加工完成最后一个工件的最后一道工序所需要花费的时间。越小越好
                f1 = max(C1);
                % 基于加工完成时间的性能指标 总流经时间:是指所有的工件完成该工件的最后一道加工工序所花费的时间总和。越小越好
                f2 = sum(C1);
                % 基于交货期的性能指标 总拖期时间:为所有工件的拖期时间总和。越小越好
                D = 1.5 * obj.p_j;       % 交货期设为工件在所有机器上的加工时间总和的 1.5 倍
                f3 = sum(max(0,(C1 - D)));
                % 基于库存的性能指标 平均机器空闲时间:每台机器从开始到停机中间的空闲时间。越小越好
                [max_C,~]=max(C,[],2);   % 计算每台机器的运行时间
                f4 = (sum(max_C) - obj.p_all) / n;
                % 基于准时制（JIT）生产模式的性能指标 E/T 指标。越小越好 
                EE = 1.2 * obj.p_j;      % 最早交货期
                TT = 1.8 * obj.p_j;      % 最晚交货期
                f5 = sum(0.5 * max(0, (EE - C1)) + 0.5 * max(0, (C1 - TT)));     % 提前完工、拖期完工的时间惩罚系数均设置为0.5
                
                % 收集目标值
                PopObj(index,:) = [f1 f2 f3 f4 f5];
            end
            
        end
        
        %% cons
        function Cons = CalCon(obj,PopDec)
            Cons = zeros(size(PopDec, 1), 1);
        end
    end

   
end