classdef YN4 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 20;          	% 机器数目
        num_process = 20; 		% 工序数目
        process_time = [
            16 34 17 38 0 21 6 15 15 42 8 17 7 41 18 10 10 26 11 24 1 31 19 25 14 31 13 33 4 35 9 30 3 16 12 16 5 30 2 13 
			5 41 11 33 6 15 16 38 0 40 14 38 3 37 1 20 13 22 4 34 7 16 17 39 9 15 2 19 10 36 12 39 18 26 8 19 15 39 19 34 
			17 34 1 12 16 10 7 47 13 28 15 27 0 19 6 34 19 33 12 40 9 37 14 24 8 15 10 34 2 44 3 37 18 22 11 31 4 39 5 26 
			5 48 7 46 16 47 10 45 14 15 8 25 0 34 3 24 12 35 18 15 2 48 13 19 11 10 1 48 17 16 15 28 4 18 6 17 9 44 19 41 
			12 47 3 23 9 48 16 45 14 39 6 42 8 32 15 11 13 16 5 14 11 19 1 46 19 10 10 17 7 41 2 47 17 32 4 17 0 21 18 17 
			18 14 16 20 1 18 12 14 13 10 6 16 5 24 4 18 0 24 11 18 15 42 19 13 3 23 14 40 9 48 8 12 2 24 10 23 7 45 17 30 
			0 27 12 15 4 26 13 19 17 14 5 49 7 16 18 28 16 16 8 20 9 36 2 21 14 30 3 36 1 17 15 22 6 43 11 32 10 23 19 17 
			0 32 16 15 17 12 7 46 3 37 18 43 11 40 13 43 9 48 4 36 15 24 8 25 1 33 14 32 5 26 6 37 12 24 10 24 2 15 19 22 
			10 34 6 33 15 25 8 46 0 20 18 33 4 19 13 45 2 47 1 32 3 12 11 29 16 29 5 46 12 17 7 48 14 39 17 40 19 41 9 37 
			13 26 3 47 5 44 6 49 1 22 17 12 10 28 19 36 9 27 4 25 14 48 7 11 16 49 12 24 11 48 2 19 0 47 18 49 8 46 15 36 
			13 23 18 48 14 15 0 42 3 36 8 15 6 32 10 18 1 45 15 23 11 45 2 13 17 21 12 32 7 44 5 25 19 34 16 22 9 11 4 43 
			17 37 7 49 15 45 2 28 9 15 8 35 12 29 13 44 1 26 4 25 5 30 3 39 0 15 14 28 18 23 6 42 11 33 16 45 10 10 19 20 
			0 10 6 37 3 15 13 13 10 11 2 49 1 28 14 28 15 13 8 29 12 21 16 32 11 21 4 48 5 11 17 26 9 33 18 22 7 21 19 49 
			18 38 0 41 4 30 13 43 6 11 2 43 14 27 3 26 9 30 15 19 16 36 1 31 17 47 5 41 10 34 8 40 12 32 7 13 11 18 19 27 
			6 24 5 30 7 10 10 35 8 28 16 43 19 12 9 44 15 15 3 15 2 35 18 43 0 38 4 16 1 29 17 40 14 49 13 38 12 16 11 30 
			3 48 6 35 13 43 2 37 17 18 5 27 9 27 7 41 1 22 15 28 16 18 10 37 18 48 4 10 8 14 11 18 14 43 0 48 12 12 19 49 
			0 13 13 38 7 34 6 42 1 36 5 45 18 24 8 35 14 26 19 30 12 47 16 24 11 47 4 40 10 43 3 16 15 10 2 12 9 39 17 22 
			16 30 13 47 19 49 8 20 4 40 3 46 17 21 14 33 6 44 7 23 9 24 0 48 10 43 15 41 2 32 5 29 11 36 1 38 12 47 18 12 
			13 10 5 36 12 18 16 48 0 27 14 43 10 46 6 27 7 46 19 35 11 31 2 18 8 24 3 23 17 29 18 14 9 19 1 40 15 38 4 13 
			9 45 16 44 0 43 17 31 14 35 13 17 12 42 3 14 18 37 10 39 6 48 7 38 15 26 4 49 2 28 11 35 1 42 5 24 8 44 19 38] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = YN4()
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