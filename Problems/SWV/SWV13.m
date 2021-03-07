classdef SWV13 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            4 68 1 39 2 79 0 72 3 65 5 82 7 33 6 82 8 66 9 55 
			2 14 3 45 0 18 4 72 1 27 7 57 6 90 8 19 9 19 5 50 
			4 25 1 77 0 64 3 18 2 19 8 27 6 97 9 81 7 65 5 11 
			3 70 0 29 2 31 1 39 4 62 8 12 9 2 5 91 7 98 6 91 
			2 90 4 51 3 38 1 27 0 29 6 67 8 95 9 60 7 86 5 64 
			4 90 0 55 3 69 1 76 2 97 7 94 5 57 8 65 9 80 6 24 
			1 23 4 13 0 90 3 24 2 41 8 69 7 8 5 81 6 94 9 76 
			3 19 1 37 0 16 4 4 2 68 6 45 8 79 9 4 7 30 5 33 
			2 36 0 76 3 97 4 71 1 19 9 87 6 97 8 64 5 84 7 43 
			2 20 1 77 0 71 3 73 4 47 7 88 5 100 9 16 8 69 6 77 
			3 55 4 96 0 8 2 61 1 40 8 46 7 29 9 71 5 89 6 59 
			2 21 0 18 3 37 4 97 1 59 7 79 6 2 5 80 8 85 9 59 
			4 19 1 83 2 1 0 95 3 48 9 37 7 59 5 56 8 57 6 81 
			0 8 1 60 4 91 3 85 2 27 9 39 5 31 6 62 7 94 8 12 
			4 2 3 10 0 17 1 38 2 96 6 21 9 81 8 64 5 76 7 46 
			2 46 1 4 4 25 3 41 0 11 5 96 9 56 6 10 7 25 8 32 
			0 21 1 77 4 22 2 72 3 53 9 28 7 23 5 2 8 52 6 83 
			3 9 4 37 0 2 2 74 1 15 8 26 5 83 6 90 7 51 9 80 
			3 6 1 7 0 57 2 4 4 56 7 11 5 57 8 12 6 94 9 29 
			1 40 2 93 3 65 4 66 0 96 9 5 7 32 8 85 5 93 6 94 
			1 38 2 19 4 22 0 73 3 7 5 63 8 28 6 23 9 11 7 84 
			1 96 4 10 0 29 3 59 2 94 5 26 7 22 8 52 6 37 9 50 
			1 38 3 31 2 76 0 8 4 8 6 50 5 95 8 5 9 25 7 62 
			0 15 2 84 4 100 3 76 1 66 7 56 5 95 8 94 6 56 9 85 
			3 73 2 38 1 84 0 42 4 37 5 16 7 24 9 59 6 60 8 23 
			3 43 1 79 0 80 2 44 4 65 5 81 7 7 8 93 6 55 9 34 
			2 8 4 2 0 12 3 55 1 60 9 91 6 6 5 83 8 31 7 91 
			0 8 4 46 3 47 2 57 1 47 9 55 8 74 7 98 6 54 5 51 
			2 56 4 90 1 41 0 35 3 62 7 4 5 15 9 89 6 73 8 66 
			0 2 4 39 3 44 1 68 2 54 7 7 8 76 9 29 5 90 6 53 
			2 34 0 94 3 1 1 23 4 45 8 83 7 84 5 49 6 67 9 49 
			4 4 2 70 1 19 0 19 3 92 5 70 7 33 9 50 8 82 6 48 
			4 64 2 76 0 70 3 83 1 91 7 98 8 37 5 3 9 75 6 92 
			3 96 1 17 0 20 4 13 2 28 7 21 9 65 5 87 6 54 8 98 
			0 68 4 40 3 98 2 90 1 38 7 45 8 21 5 9 9 3 6 47 
			0 58 4 19 2 16 3 74 1 32 9 32 5 58 6 93 7 1 8 80 
			0 32 2 99 1 95 3 2 4 8 9 55 6 32 8 26 5 6 7 68 
			3 7 4 45 2 19 0 97 1 56 7 22 9 72 8 98 5 59 6 20 
			2 97 4 98 3 43 0 28 1 23 5 3 8 75 9 43 7 58 6 71 
			3 31 0 88 2 88 1 82 4 65 5 53 9 15 7 68 6 60 8 99 
			4 4 0 100 2 95 1 11 3 28 5 80 7 25 9 87 6 25 8 9 
			0 75 3 10 4 59 2 80 1 60 5 75 8 87 6 33 9 10 7 31 
			0 54 3 6 4 7 1 72 2 49 7 72 8 64 6 32 9 86 5 69 
			4 15 3 19 1 18 0 84 2 96 9 71 8 64 6 38 5 58 7 62 
			1 32 4 80 2 83 3 83 0 50 5 81 7 82 9 33 8 10 6 55 
			0 65 4 95 3 84 2 64 1 18 9 27 6 70 7 74 5 87 8 68 
			1 50 2 49 0 96 3 1 4 89 8 42 5 88 9 91 6 64 7 3 
			3 44 0 91 1 5 2 100 4 77 6 20 5 13 7 25 9 71 8 71 
			0 86 4 91 1 19 2 69 3 71 5 13 8 87 6 98 9 43 7 13 
			4 8 0 60 3 31 2 93 1 8 9 1 7 19 6 8 5 85 8 24 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV13()
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