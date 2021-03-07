classdef YN1 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 20;          	% 机器数目
        num_process = 20; 		% 工序数目
        process_time = [
            17 13 2 26 11 35 4 45 12 29 13 21 7 40 0 45 3 16 15 10 18 49 10 43 14 25 8 25 1 40 6 16 19 43 5 48 9 36 16 11 
			8 21 6 22 14 15 5 28 10 10 2 46 11 19 19 13 13 18 18 14 3 11 4 21 16 30 1 29 0 16 15 41 17 40 12 38 7 28 9 39 
			4 39 3 28 8 32 17 46 0 35 14 14 1 44 10 20 13 12 6 23 18 22 9 15 11 35 7 27 16 26 5 27 15 23 2 27 12 31 19 31 
			4 31 10 24 3 34 6 44 18 43 12 32 2 35 15 34 19 21 7 46 13 15 5 10 9 24 14 37 17 38 1 41 8 34 0 32 16 11 11 36 
			19 45 1 23 5 34 9 23 7 41 16 10 11 40 12 46 14 27 8 13 4 20 2 40 15 28 13 44 17 34 18 21 10 27 0 12 6 37 3 30 
			13 48 2 34 3 22 7 14 12 22 14 10 8 45 19 38 6 32 16 38 11 16 4 20 0 12 5 40 9 33 17 35 1 32 10 15 15 31 18 49 
			9 19 5 33 18 32 16 37 12 28 3 16 2 40 10 37 4 10 11 20 1 17 17 48 6 44 13 29 14 44 15 48 8 21 0 31 7 36 19 43 
			9 20 6 43 1 13 5 22 2 33 7 28 16 39 12 16 13 34 17 20 10 47 18 43 19 44 8 29 15 22 4 14 11 28 14 44 0 33 3 28 
			7 14 12 40 8 19 0 49 13 11 10 13 9 47 18 22 2 27 17 26 3 47 5 37 6 19 15 43 14 41 1 34 11 21 4 30 19 32 16 45 
			16 32 7 22 15 30 6 18 18 41 19 34 9 22 11 11 17 29 10 37 4 30 2 25 1 27 0 31 14 16 13 20 3 26 12 14 5 24 8 43 
			18 22 17 22 12 30 15 31 13 15 4 13 16 47 19 18 6 33 3 30 7 46 2 48 11 42 0 18 1 16 8 25 10 43 5 21 9 27 14 14 
			5 48 1 39 2 21 18 18 13 20 0 28 15 20 8 36 6 24 9 35 7 22 19 36 3 39 14 34 4 49 17 36 11 38 10 46 12 44 16 13 
			14 26 1 32 2 11 15 10 9 41 13 10 6 26 19 26 12 13 11 35 5 22 0 11 7 24 17 33 8 11 10 34 16 11 3 22 4 12 18 17 
			16 39 10 24 17 43 14 28 3 49 15 34 18 46 13 29 6 31 11 40 7 24 1 47 9 15 2 26 8 40 12 46 5 18 19 16 4 14 0 21 
			11 41 19 26 16 14 3 47 0 49 5 16 17 31 9 43 15 20 10 25 14 10 13 49 8 32 6 36 7 19 4 23 2 20 18 15 12 34 1 33 
			11 37 5 48 10 31 7 42 2 24 1 13 9 30 15 24 0 19 13 34 19 35 8 42 3 10 14 40 4 39 6 42 12 38 16 12 18 27 17 40 
			14 19 1 27 8 39 12 41 5 45 11 40 10 46 6 48 7 37 3 30 17 31 4 16 18 29 15 44 0 41 16 35 13 47 9 21 2 10 19 48 
			18 38 0 27 13 32 9 30 7 17 14 21 1 14 4 37 17 15 16 31 5 27 10 25 15 41 11 48 3 48 6 36 2 30 12 45 8 26 19 17 
			1 17 10 40 9 16 5 36 4 34 16 47 19 14 0 24 18 10 6 14 13 14 3 30 12 23 2 37 17 11 11 23 8 40 15 15 14 10 7 46 
			14 37 10 28 13 13 0 28 2 18 1 43 16 46 8 39 3 30 12 15 11 38 17 38 18 45 19 44 9 16 15 29 5 33 6 20 7 35 4 34] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = YN1()
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