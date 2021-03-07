classdef LA31 < PROBLEM
    properties
        num_job = 30;           % 工件数目
        num_mach = 10;          % 机器数目
        num_process = 10; % 工序数目
        process_time = [
            4 21 7 26 9 16 2 34 3 55 8 52 5 95 6 71 1 21 0 53 
			8 77 5 98 1 42 7 66 2 31 3 39 6 77 9 79 4 55 0 12 
			2 64 4 92 3 34 1 19 8 62 6 54 7 43 0 83 9 79 5 37 
			0 93 8 24 3 69 7 38 5 77 2 87 4 60 6 41 1 87 9 83 
			9 77 0 44 4 96 8 79 6 75 2 98 5 25 3 17 7 43 1 49 
			3 76 2 35 5 28 0 95 7 95 4 61 8 35 1 7 6 9 9 10 
			1 91 7 27 8 50 3 16 4 28 5 59 6 52 0 46 2 59 9 43 
			1 45 7 71 2 39 0 87 8 14 6 54 3 41 9 43 5 9 4 20 
			2 37 3 26 4 33 9 42 0 78 6 89 7 8 8 66 1 28 5 33 
			1 74 0 69 5 84 3 27 9 81 7 45 8 69 2 94 6 78 4 96 
			5 76 7 32 6 18 0 20 3 87 2 17 9 25 4 24 1 31 8 81 
			9 97 8 90 5 28 7 86 0 58 1 72 2 23 6 76 3 99 4 45 
			9 48 5 27 6 67 7 62 4 98 0 42 1 46 8 27 3 48 2 17 
			9 80 3 19 5 28 1 12 4 94 6 63 7 98 8 50 0 80 2 50 
			2 50 1 41 4 61 8 79 5 14 9 72 7 18 3 55 6 37 0 75 
			9 22 5 57 4 75 2 14 7 65 3 96 1 71 0 47 8 79 6 60 
			3 32 2 69 4 44 1 31 9 51 0 33 6 34 5 58 7 47 8 58 
			8 66 7 40 2 17 0 62 9 38 5 8 6 15 3 29 1 44 4 97 
			3 50 2 58 6 21 4 63 7 57 8 32 5 20 9 87 0 57 1 39 
			4 20 6 67 1 85 2 90 7 70 0 84 8 30 5 56 3 61 9 15 
			6 29 0 82 4 18 3 38 7 21 8 50 1 23 5 84 2 45 9 41 
			3 54 9 37 6 62 5 16 0 52 8 57 4 54 2 38 7 74 1 52 
			4 79 1 61 8 11 0 81 7 89 6 89 5 57 3 68 9 81 2 30 
			9 24 1 66 4 32 3 33 8 8 2 20 6 84 0 91 7 55 5 20 
			3 54 2 64 6 83 9 40 7 8 0 7 4 19 5 56 1 39 8 7 
			1 6 4 74 0 63 2 64 9 15 6 42 7 98 8 61 5 40 3 91 
			1 80 3 75 0 26 2 87 9 22 7 39 8 24 4 75 6 44 5 6 
			5 8 3 79 6 61 1 15 0 12 7 43 8 26 9 22 2 20 4 80 
			1 36 0 63 7 10 4 22 3 96 5 40 9 5 8 18 6 33 2 62 
			4 8 8 15 2 64 3 95 1 96 6 38 7 18 9 23 5 64 0 89] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = LA31()
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