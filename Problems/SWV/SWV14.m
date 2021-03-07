classdef SWV14 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            4 69 0 37 3 64 1 1 2 65 9 34 5 67 8 43 7 72 6 79 
			1 11 0 7 3 68 4 43 2 52 6 29 9 71 7 81 8 12 5 36 
			4 90 3 29 1 1 2 1 0 14 8 38 5 13 9 21 7 41 6 97 
			1 46 0 26 4 83 2 36 3 20 9 4 8 23 7 65 5 56 6 42 
			4 46 0 39 2 92 3 53 1 62 9 68 7 65 8 74 6 87 5 46 
			4 13 1 44 3 43 2 67 0 75 6 5 9 94 5 95 7 28 8 85 
			1 1 2 99 4 36 3 86 0 65 8 32 5 17 7 71 6 15 9 61 
			2 18 4 63 3 15 0 59 1 33 7 95 5 63 6 85 8 34 9 3 
			4 13 2 25 0 82 3 23 1 26 7 22 9 35 8 16 6 24 5 41 
			3 1 1 7 0 21 2 73 4 39 6 32 7 77 5 29 8 89 9 21 
			1 53 3 27 4 55 0 16 2 64 5 78 9 32 8 60 7 20 6 20 
			1 71 2 54 3 21 0 20 4 23 9 40 5 99 7 61 6 94 8 71 
			2 76 4 72 3 91 0 75 1 7 6 53 8 32 7 71 5 63 9 53 
			2 12 1 3 4 35 0 64 3 30 5 94 8 67 7 31 6 79 9 14 
			4 63 1 28 3 87 0 89 2 52 8 2 9 21 7 92 6 44 5 37 
			0 79 1 65 4 35 3 78 2 17 8 90 5 54 9 91 7 57 6 23 
			3 20 1 93 4 61 0 76 2 23 5 10 8 34 7 20 9 87 6 77 
			0 37 2 17 1 92 4 30 3 59 5 47 8 7 7 45 6 13 9 60 
			4 90 3 74 0 46 2 36 1 2 6 9 5 83 8 90 7 88 9 39 
			3 83 0 85 2 20 4 88 1 94 6 14 5 16 7 62 9 53 8 9 
			0 4 4 16 2 64 1 60 3 79 5 37 6 49 7 67 9 95 8 5 
			3 32 0 86 1 5 4 66 2 77 7 15 5 68 9 40 8 1 6 4 
			0 2 1 48 4 23 3 25 2 58 9 55 7 14 8 21 6 85 5 27 
			1 71 4 92 3 99 2 56 0 81 7 79 6 66 9 42 8 47 5 43 
			1 77 4 85 3 72 2 19 0 71 5 34 7 9 9 14 6 62 8 58 
			4 38 0 3 2 61 3 98 1 76 5 14 9 56 8 26 7 43 6 44 
			1 68 4 54 0 62 2 93 3 22 6 57 7 79 9 19 5 77 8 45 
			2 62 1 96 4 56 0 68 3 24 5 41 6 19 7 2 8 73 9 50 
			2 86 0 53 3 3 1 89 4 37 7 100 5 59 9 23 6 19 8 35 
			3 90 4 94 0 21 2 78 1 85 5 94 6 90 8 28 9 92 7 56 
			4 85 2 97 0 8 3 27 1 86 9 26 7 5 8 96 5 68 6 57 
			0 58 3 4 4 49 2 1 1 79 8 10 6 44 9 87 5 16 7 13 
			3 85 0 24 4 23 1 41 2 59 8 20 6 52 5 58 9 75 7 77 
			0 47 1 89 2 68 4 88 3 17 6 48 8 84 9 100 5 92 7 47 
			1 30 0 1 3 61 4 20 2 73 8 78 7 41 9 52 5 43 6 74 
			0 11 4 58 3 66 2 67 1 18 8 42 7 88 9 49 5 62 6 71 
			4 5 2 51 3 67 1 20 0 11 7 37 6 42 8 25 9 57 5 1 
			0 58 4 83 2 9 3 68 1 21 6 28 9 77 5 19 7 32 8 66 
			3 85 2 58 0 65 1 80 4 50 7 79 5 43 8 29 9 9 6 18 
			3 74 2 29 0 11 1 23 4 34 7 84 8 57 5 77 6 83 9 82 
			2 6 4 67 0 97 3 66 1 21 8 90 9 46 6 12 5 17 7 96 
			4 34 1 5 2 13 0 100 3 12 8 63 7 59 5 75 6 91 9 89 
			1 30 2 66 0 33 3 70 4 16 6 80 5 58 8 8 7 86 9 66 
			3 55 0 46 2 1 1 77 4 19 7 85 9 32 6 59 5 37 8 69 
			2 3 0 16 1 48 4 8 3 51 7 72 6 19 8 58 9 59 5 94 
			3 30 4 23 1 92 0 18 2 19 9 32 6 57 5 50 7 64 8 27 
			2 18 0 72 4 92 1 6 3 67 8 100 6 32 9 14 5 51 7 55 
			4 48 0 87 1 96 2 58 3 83 8 77 5 26 7 77 9 72 6 86 
			1 80 4 5 0 50 3 65 2 85 7 88 5 47 6 33 8 50 9 75 
			1 78 0 96 4 80 3 5 2 99 9 58 5 38 7 29 8 69 6 44 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV14()
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