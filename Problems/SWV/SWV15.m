classdef SWV15 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            2 93 4 40 0 1 3 77 1 77 5 16 9 74 8 11 6 51 7 92 
			0 92 4 80 1 76 3 59 2 70 5 86 9 17 6 78 7 30 8 93 
			1 44 2 92 3 96 4 77 0 53 9 10 7 49 5 84 8 59 6 14 
			1 60 2 19 3 76 0 73 4 85 7 13 8 93 5 68 9 50 6 78 
			2 20 0 24 3 41 1 2 4 4 9 44 7 79 8 81 5 16 6 39 
			3 41 2 35 1 32 4 18 0 15 8 98 6 29 5 19 7 14 9 26 
			1 59 0 45 4 53 3 44 2 98 5 84 6 23 7 45 8 39 9 89 
			1 30 4 51 3 25 0 51 2 84 6 60 5 45 7 89 8 25 9 97 
			0 47 3 18 2 40 4 62 1 58 5 36 7 93 8 77 9 90 6 15 
			3 33 1 68 0 41 4 72 2 20 6 69 7 47 5 22 9 47 8 22 
			2 28 1 100 4 20 0 35 3 26 5 24 9 41 6 42 7 100 8 32 
			0 65 2 12 4 53 3 93 1 40 8 18 7 23 5 60 6 89 9 53 
			0 58 1 60 4 97 3 31 2 50 9 85 5 64 7 38 6 85 8 35 
			3 64 0 58 1 49 2 45 4 9 8 49 6 22 5 99 9 15 7 7 
			0 10 4 85 3 72 2 37 1 77 5 70 7 45 9 8 6 83 8 57 
			4 93 0 87 1 87 2 18 3 4 8 78 5 67 9 20 6 17 7 35 
			4 72 0 56 3 57 2 15 1 45 6 41 5 40 9 85 8 32 7 81 
			0 36 3 63 4 79 2 32 1 5 6 25 7 86 9 91 5 21 8 35 
			2 83 4 29 0 9 1 38 3 73 7 50 9 99 5 18 8 29 6 41 
			0 100 3 29 2 60 4 63 1 64 8 71 6 35 5 26 9 9 7 22 
			1 81 0 60 3 62 4 48 2 68 7 28 5 69 8 92 6 79 9 10 
			0 40 4 80 1 41 2 10 3 68 8 28 9 51 7 33 6 82 5 25 
			4 30 2 12 0 35 3 17 1 70 9 29 7 18 8 93 6 94 5 37 
			1 36 2 41 3 27 4 36 0 78 7 64 6 88 5 25 9 92 8 66 
			2 65 3 27 4 74 0 32 1 40 5 88 8 73 6 92 7 83 9 42 
			0 48 1 85 2 92 4 95 3 61 8 72 9 76 5 58 7 11 6 89 
			3 84 2 50 0 70 4 24 1 42 9 55 5 100 6 70 7 4 8 68 
			0 95 4 41 2 11 3 98 1 85 5 64 6 8 7 26 8 6 9 6 
			0 84 2 49 1 17 3 69 4 55 8 75 6 45 9 38 7 59 5 28 
			2 48 0 29 4 1 1 64 3 41 5 23 7 64 9 31 6 56 8 12 
			2 81 4 25 3 33 0 22 1 50 5 74 9 56 8 33 7 85 6 83 
			1 62 4 25 0 21 2 20 3 8 6 36 9 9 5 91 8 90 7 49 
			1 43 0 16 2 91 3 96 4 24 5 11 9 91 7 41 8 35 6 66 
			1 91 2 20 4 44 0 42 3 87 9 57 6 15 5 38 8 42 7 89 
			0 33 3 95 4 68 2 22 1 80 7 53 8 13 9 70 5 22 6 69 
			0 15 3 47 1 24 2 31 4 41 8 14 9 28 7 59 5 52 6 39 
			2 95 0 42 4 5 1 57 3 67 6 30 9 21 8 70 5 9 7 20 
			2 54 0 15 1 20 3 64 4 83 9 40 7 6 5 89 6 91 8 48 
			0 22 4 27 1 77 3 25 2 16 8 72 9 61 6 75 7 4 5 19 
			3 68 1 82 2 16 0 83 4 2 7 10 8 88 5 41 9 21 6 66 
			1 64 0 76 2 85 3 71 4 97 5 97 7 8 6 40 8 70 9 35 
			0 94 1 45 2 94 4 84 3 44 8 41 5 30 7 47 6 19 9 22 
			2 23 1 10 0 82 3 93 4 90 8 67 7 9 9 18 5 22 6 87 
			0 75 2 27 4 97 3 9 1 57 9 14 5 50 7 31 8 62 6 23 
			1 42 3 41 2 35 0 75 4 18 9 65 7 38 6 38 8 51 5 56 
			4 72 1 63 0 33 2 27 3 41 5 52 7 42 9 10 6 14 8 71 
			2 91 1 89 0 44 4 91 3 26 6 49 5 22 8 31 9 69 7 5 
			3 42 1 34 0 4 4 34 2 16 6 86 7 25 8 99 5 67 9 25 
			4 34 1 93 0 26 3 81 2 9 7 96 8 79 9 68 5 76 6 10 
			3 19 1 47 4 13 2 98 0 32 7 12 9 45 6 52 8 49 5 34 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV15()
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