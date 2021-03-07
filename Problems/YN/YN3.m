classdef YN3 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 20;          	% 机器数目
        num_process = 20; 		% 工序数目
        process_time = [
            13 47 16 21 17 27 8 46 1 27 14 39 19 24 4 34 7 27 3 36 6 11 5 32 0 13 9 40 2 40 15 20 18 45 10 23 12 36 11 31 
			1 40 11 20 12 27 6 32 16 26 13 36 10 37 7 26 3 22 4 44 18 18 2 11 17 15 9 27 15 39 5 25 8 16 14 13 0 49 19 25 
			9 40 8 11 14 47 2 35 13 41 7 37 1 37 18 28 6 42 3 23 10 41 5 33 17 25 0 19 19 15 16 42 12 37 11 34 4 10 15 41 
			2 28 4 18 11 42 5 26 13 27 6 24 12 41 0 25 1 27 7 40 17 40 14 49 10 33 3 30 15 34 16 17 8 49 9 21 18 35 19 42 
			7 26 9 27 4 25 3 42 19 28 15 22 17 34 0 15 6 46 1 34 12 47 2 16 16 34 10 31 14 24 5 43 13 45 11 47 8 18 18 15 
			4 30 8 48 1 46 15 13 9 20 7 31 14 20 2 20 16 34 19 38 18 12 17 11 11 47 5 19 0 35 13 17 10 23 12 11 3 22 6 11 
			3 27 2 11 5 17 0 43 1 25 15 24 18 36 8 12 9 21 13 44 10 17 17 41 16 34 11 14 12 45 7 45 14 27 6 47 4 47 19 11 
			5 27 4 41 17 44 16 16 11 42 10 29 3 23 2 15 0 22 13 28 7 16 14 39 9 21 12 15 18 32 15 36 1 29 8 18 6 39 19 33 
			4 44 19 38 11 24 17 21 13 34 15 11 10 16 8 43 16 41 7 45 3 37 9 10 6 36 18 31 2 17 14 28 12 43 0 22 1 25 5 15 
			7 40 15 23 4 37 2 12 8 28 12 19 10 30 17 40 13 20 18 11 5 23 16 46 3 40 1 37 14 17 0 16 11 31 6 15 9 10 19 22 
			5 10 1 37 15 22 2 28 6 10 9 21 19 38 16 35 7 34 0 13 14 33 11 16 4 26 3 20 17 10 18 37 13 21 8 31 10 27 12 23 
			16 32 6 32 7 20 1 14 0 11 19 27 3 21 18 32 10 33 13 13 17 36 8 25 4 32 5 41 15 44 2 32 14 12 9 32 12 10 11 28 
			7 28 9 33 11 35 17 44 4 43 16 35 12 31 2 14 6 48 8 40 15 28 0 31 3 22 5 30 13 27 10 24 18 47 14 38 1 46 19 22 
			12 33 6 33 14 38 9 15 10 16 13 24 1 30 8 18 7 46 2 30 17 37 11 24 5 13 3 14 18 11 16 38 0 31 4 24 19 42 15 30 
			10 15 16 12 6 43 18 27 0 24 9 20 3 41 2 22 12 41 11 30 5 26 4 24 7 45 13 46 14 22 15 11 8 20 1 42 19 11 17 49 
			4 14 19 30 17 15 7 17 8 34 2 48 3 45 14 16 12 23 16 29 13 28 6 28 18 24 10 21 5 37 1 38 11 31 0 29 9 42 15 22 
			15 41 17 19 5 37 7 36 8 47 12 49 11 29 6 18 9 33 10 30 0 49 16 37 3 11 2 46 14 36 18 35 13 45 1 31 4 33 19 18 
			9 42 4 11 15 28 18 48 6 22 8 15 1 37 11 36 3 26 19 21 2 48 16 17 12 30 10 27 13 35 17 20 0 18 7 14 14 20 5 41 
			19 35 17 19 16 20 15 36 1 15 3 46 4 13 8 42 18 19 5 37 2 10 13 44 10 30 11 20 14 42 6 35 0 26 9 29 7 21 12 42 
			17 33 3 11 7 42 16 45 9 29 0 27 5 15 13 37 2 32 11 25 14 21 8 49 19 34 1 31 15 35 6 32 4 20 18 30 10 24 12 29] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = YN3()
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