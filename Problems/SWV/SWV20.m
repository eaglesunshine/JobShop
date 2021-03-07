classdef SWV20 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            8 100 7 30 4 42 9 11 2 31 1 71 5 41 0 1 3 55 6 94 
			4 81 6 20 3 96 7 39 8 29 0 90 9 61 2 64 1 86 5 47 
			5 80 0 56 1 88 7 19 2 68 8 95 3 44 4 22 9 60 6 80 
			4 86 6 70 0 88 2 15 7 50 1 54 9 88 3 25 8 89 5 33 
			0 48 1 57 4 86 8 60 3 78 5 4 9 60 7 40 2 11 6 25 
			6 23 7 9 1 90 0 51 2 52 9 14 5 30 4 1 8 25 3 83 
			1 30 4 75 5 76 9 100 7 54 2 41 6 50 8 75 0 1 3 28 
			2 46 3 78 1 37 7 12 6 56 4 50 8 66 5 39 0 8 9 72 
			1 24 6 90 0 32 3 6 2 99 9 22 8 12 4 63 7 81 5 52 
			6 62 3 9 8 59 0 66 4 41 1 32 5 29 7 79 9 84 2 4 
			9 57 5 99 6 2 3 17 0 51 7 10 4 14 1 64 2 99 8 27 
			7 81 0 67 9 83 2 30 5 25 6 87 1 29 3 7 8 93 4 1 
			5 65 8 53 9 48 4 28 7 74 0 60 6 77 2 22 1 5 3 98 
			1 97 5 37 0 71 7 49 6 51 3 17 4 38 9 67 8 28 2 31 
			0 20 8 94 3 39 6 73 9 63 4 8 2 57 1 27 7 26 5 42 
			8 77 1 68 9 20 7 100 4 1 5 77 6 17 3 35 2 65 0 86 
			8 68 6 62 4 79 7 84 1 60 3 56 0 10 9 86 5 60 2 30 
			4 71 2 74 6 6 1 56 3 69 0 8 8 50 9 78 5 4 7 89 
			8 29 5 5 1 59 3 96 0 46 4 91 2 48 7 53 6 21 9 82 
			2 19 9 96 0 73 1 39 5 54 8 50 7 60 3 50 4 65 6 78 
			7 68 4 15 2 26 3 26 0 13 9 13 5 96 8 70 6 27 1 93 
			6 41 8 18 4 66 7 9 1 31 2 92 0 3 3 78 5 41 9 53 
			5 9 0 64 2 15 6 73 4 12 1 43 8 89 7 69 3 32 9 22 
			5 93 6 19 3 74 8 81 0 72 2 94 9 19 1 26 4 53 7 7 
			3 48 2 29 5 51 8 72 7 35 6 32 1 38 0 98 4 58 9 54 
			0 94 9 23 4 41 6 53 2 53 7 27 1 62 3 68 8 84 5 49 
			4 4 1 4 0 66 7 90 9 78 2 29 5 2 6 86 3 23 8 46 
			3 78 5 61 2 97 7 68 8 92 0 15 4 12 6 77 1 12 9 22 
			0 100 7 89 6 71 2 70 8 89 4 72 5 78 3 23 9 37 1 2 
			0 91 3 74 2 36 4 72 6 62 1 80 9 20 7 77 5 47 8 80 
			1 44 0 67 4 66 8 99 6 59 5 5 7 15 2 38 3 40 9 19 
			1 69 9 35 3 86 0 7 2 35 5 32 6 66 4 89 8 63 7 52 
			3 3 4 68 1 66 7 27 6 41 5 2 9 77 0 45 2 40 8 39 
			4 66 3 42 7 79 0 55 6 98 9 44 5 6 8 73 1 55 2 1 
			3 80 8 18 9 94 2 27 5 42 4 17 7 74 0 65 6 6 1 27 
			2 73 4 70 5 51 0 84 8 29 9 95 1 97 7 28 3 68 6 89 
			9 85 6 56 5 54 3 76 2 50 0 43 1 8 7 93 4 17 8 65 
			1 1 3 17 2 61 5 38 4 71 7 18 0 40 9 94 6 41 8 74 
			3 30 8 22 6 39 9 56 5 3 7 64 4 74 2 21 0 93 1 1 
			0 17 8 8 9 20 5 38 3 85 7 5 2 63 1 18 4 89 6 88 
			8 87 5 44 0 42 1 34 9 11 7 13 3 71 4 88 6 32 2 12 
			2 39 1 73 6 43 0 48 9 77 8 48 5 23 7 66 3 94 4 68 
			1 98 7 19 3 69 6 5 8 85 9 19 0 30 2 43 5 87 4 70 
			2 45 1 60 4 30 9 71 5 35 0 75 3 75 6 41 8 67 7 37 
			3 63 7 39 2 16 9 69 1 46 5 20 6 57 4 51 0 66 8 40 
			2 7 7 73 6 17 1 21 0 24 8 2 5 68 4 22 9 36 3 60 
			1 20 4 17 8 12 9 29 5 28 0 7 3 38 6 57 7 22 2 75 
			5 53 4 7 7 5 8 27 9 38 2 100 6 48 0 53 1 11 3 18 
			1 49 7 47 4 81 8 9 0 20 2 63 3 15 6 1 9 10 5 5 
			4 49 6 27 7 17 5 64 2 30 8 56 0 42 3 97 9 82 1 34 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV20()
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