classdef YN2 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 20;          	% 机器数目
        num_process = 20; 		% 工序数目
        process_time = [
            17 15 2 28 11 10 4 46 12 19 13 13 7 18 0 14 3 11 15 21 18 30 10 29 14 16 8 41 1 40 6 38 19 28 5 39 9 39 16 28 
			8 32 6 46 14 35 5 14 10 44 2 20 11 12 19 23 13 22 18 15 3 35 4 27 16 26 1 27 0 23 15 27 17 31 12 31 7 31 9 24 
			4 34 3 44 8 43 17 32 0 35 14 34 1 21 10 46 13 15 6 10 18 24 9 37 11 38 7 41 16 34 5 32 15 11 2 36 12 45 19 23 
			4 34 10 23 3 41 6 10 18 40 12 46 2 27 15 13 19 20 7 40 13 28 5 44 9 34 14 21 17 27 1 12 8 37 0 30 16 48 11 34 
			19 22 1 14 5 22 9 10 7 45 16 38 11 32 12 38 14 16 8 20 4 12 2 40 15 33 13 35 17 32 18 15 10 31 0 49 6 19 3 33 
			13 32 2 37 3 28 7 16 12 40 14 37 8 10 19 20 6 17 16 48 11 44 4 29 0 44 5 48 9 21 17 31 1 36 10 43 15 20 18 43 
			9 13 5 22 18 33 16 28 12 39 3 16 2 34 10 20 4 47 11 43 1 44 17 29 6 22 13 14 14 28 15 44 8 33 0 28 7 14 19 40 
			9 19 6 49 1 11 5 13 2 47 7 22 16 27 12 26 13 47 17 37 10 19 18 43 19 41 8 34 15 21 4 30 11 32 14 45 0 32 3 22 
			7 30 12 18 8 41 0 34 13 22 10 11 9 29 18 37 2 30 17 25 3 27 5 31 6 16 15 20 14 26 1 14 11 24 4 43 19 22 16 22 
			16 30 7 31 15 15 6 13 18 47 19 18 9 33 11 30 17 46 4 48 10 42 2 18 1 16 0 25 14 43 13 21 3 27 12 14 5 48 8 39 
			18 21 17 18 12 20 15 28 13 20 4 36 16 24 19 35 7 22 3 36 6 39 10 34 11 49 0 36 1 38 8 46 9 44 5 13 2 26 14 32 
			9 11 1 10 2 41 11 10 13 26 0 26 12 13 10 35 6 22 5 11 7 24 19 33 3 11 14 34 17 11 4 22 18 12 8 17 15 39 16 24 
			1 43 15 28 2 49 14 34 4 46 12 29 18 31 19 40 13 24 11 47 5 15 0 26 7 40 17 46 8 18 10 16 16 14 3 21 9 41 6 26 
			16 14 6 47 17 49 10 16 3 31 12 43 4 20 8 25 14 10 18 49 7 32 0 36 9 19 2 23 15 20 5 15 13 34 19 33 11 37 1 48 
			4 31 11 42 7 24 6 13 0 30 14 24 17 19 19 34 16 35 10 42 15 10 13 40 2 39 8 42 5 38 9 12 1 27 18 40 12 19 3 27 
			6 39 5 41 13 45 15 40 2 46 9 48 7 37 0 30 1 31 12 16 19 29 14 44 3 41 8 35 10 47 11 21 4 10 16 48 18 38 17 27 
			16 32 1 30 8 17 18 21 0 14 17 37 10 15 12 31 7 27 3 25 5 41 4 48 13 48 6 36 2 30 15 45 11 26 9 17 14 17 19 40 
			18 16 17 36 4 34 2 47 10 14 15 24 1 10 3 14 7 14 12 30 5 23 9 37 8 11 14 23 11 40 6 15 16 10 0 46 13 37 19 28 
			17 13 13 28 11 18 16 43 7 46 8 39 3 30 5 15 4 38 2 38 14 45 0 44 10 16 6 29 12 33 1 20 19 35 15 34 9 16 18 40 
			17 14 2 30 0 27 15 47 18 43 3 17 14 13 6 43 7 45 12 32 13 13 16 48 1 10 4 14 10 42 9 38 5 43 19 22 11 43 8 23] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = YN2()
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