classdef SWV12 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            0 92 4 49 1 93 3 48 2 1 7 52 6 57 9 16 5 6 8 6 
			4 82 3 25 2 69 1 86 0 54 6 15 5 31 9 5 7 6 8 18 
			0 31 1 26 3 46 2 49 4 48 8 74 7 82 5 47 9 93 6 91 
			0 34 4 37 1 82 3 25 2 43 6 11 9 71 5 55 7 34 8 77 
			4 22 0 91 3 54 2 49 1 97 9 2 7 46 5 98 6 27 8 89 
			2 46 3 70 1 3 0 44 4 24 9 65 6 60 5 94 8 58 7 22 
			3 53 0 99 1 80 2 74 4 29 6 72 7 54 5 98 8 60 9 69 
			3 96 1 87 0 36 2 57 4 7 8 36 9 26 5 94 6 47 7 70 
			3 5 2 47 1 59 0 57 4 28 9 24 8 79 6 19 5 44 7 35 
			0 96 1 4 3 60 2 43 4 39 7 97 5 2 9 81 6 89 8 91 
			2 23 4 74 3 98 0 24 1 75 9 57 8 93 6 74 5 10 7 44 
			3 36 4 5 2 36 0 49 1 90 8 62 5 74 9 4 6 85 7 53 
			2 44 1 47 3 75 4 81 0 30 7 42 8 100 9 81 6 29 5 31 
			1 2 0 18 3 88 2 27 4 5 5 36 7 30 6 51 8 51 9 31 
			1 21 0 57 3 100 2 100 4 59 8 77 7 21 5 98 6 38 9 84 
			4 97 2 72 1 70 3 99 0 42 6 94 5 59 9 90 8 78 7 13 
			3 16 2 19 1 70 0 7 4 74 6 7 5 50 9 74 8 46 7 88 
			3 45 4 91 2 28 0 52 1 12 5 45 6 7 7 15 9 22 8 31 
			3 56 2 3 1 8 4 25 0 90 8 99 6 22 9 65 7 51 5 31 
			0 23 3 28 1 49 2 5 4 17 7 40 9 30 5 62 8 65 6 84 
			2 88 0 86 4 8 1 41 3 12 6 67 9 77 5 94 7 80 8 11 
			4 81 3 42 0 19 2 100 1 10 5 23 9 71 8 18 6 93 7 36 
			4 74 2 73 3 63 1 9 0 51 8 39 7 7 6 96 5 81 9 22 
			1 1 3 44 0 66 4 19 2 65 7 10 6 23 8 26 9 76 5 77 
			1 54 2 18 4 99 0 79 3 22 5 2 6 42 8 54 7 90 9 28 
			3 16 4 1 1 28 0 54 2 97 5 71 6 53 8 32 7 26 9 28 
			0 82 3 5 2 18 4 71 1 50 5 41 7 62 9 89 6 93 8 54 
			2 63 3 59 0 42 1 74 4 32 5 50 6 21 7 29 8 83 9 64 
			4 29 2 76 1 6 3 44 0 4 9 81 5 29 7 95 8 66 6 89 
			3 55 4 84 1 36 0 42 2 64 5 81 8 85 6 76 7 4 9 16 
			4 100 0 46 1 69 3 41 2 3 6 18 5 41 7 94 8 97 9 30 
			3 34 4 35 2 18 1 58 0 98 9 78 8 17 5 53 6 85 7 86 
			4 68 2 89 1 99 0 3 3 92 5 10 6 52 7 30 8 66 9 69 
			0 21 3 65 4 19 2 14 1 76 9 84 6 45 5 24 8 54 7 73 
			4 47 0 68 2 87 3 92 1 96 6 29 5 90 8 29 7 39 9 100 
			2 35 0 60 4 61 1 61 3 72 9 57 8 94 5 77 7 1 6 53 
			3 85 2 38 0 79 4 43 1 71 6 44 5 87 8 61 7 51 9 37 
			1 100 2 33 3 94 0 59 4 25 5 88 9 50 6 19 8 4 7 66 
			2 8 0 85 1 80 4 75 3 1 7 17 9 32 6 60 5 30 8 57 
			4 25 2 98 1 94 3 49 0 34 9 37 7 80 6 50 8 25 5 72 
			3 51 4 49 1 53 2 7 0 73 6 96 7 19 9 41 5 55 8 42 
			0 57 1 86 2 1 4 61 3 66 6 28 5 56 7 68 8 21 9 65 
			2 98 1 100 0 47 4 28 3 4 7 34 9 55 5 32 6 72 8 66 
			4 2 0 74 2 20 1 39 3 63 5 88 9 3 7 22 6 8 8 73 
			2 44 0 1 3 52 1 43 4 4 6 36 9 75 8 58 5 61 7 38 
			2 21 4 6 3 32 1 74 0 57 5 72 8 10 9 34 6 91 7 94 
			4 26 0 59 3 53 1 45 2 23 5 55 8 12 7 34 6 98 9 43 
			2 4 1 53 4 57 3 95 0 6 6 30 8 1 7 92 9 20 5 86 
			1 98 2 77 3 65 4 51 0 85 7 23 6 79 5 30 8 41 9 17 
			4 58 2 43 3 14 0 74 1 64 7 37 8 78 6 33 9 42 5 80 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV12()
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