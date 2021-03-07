classdef SWV07 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 15;          	% 机器数目
        num_process = 15; 		% 工序数目
        process_time = [
            3 92 1 49 2 93 6 48 0 1 4 52 5 57 8 16 12 6 13 6 11 19 9 96 7 27 14 76 10 60 
			5 4 3 96 6 52 1 87 2 94 4 83 0 9 11 85 10 47 8 63 9 31 13 26 12 46 7 49 14 48 
			1 34 6 34 4 37 2 82 0 25 5 43 3 11 9 71 14 55 7 34 11 77 12 20 8 89 10 23 13 32 
			3 49 5 12 6 52 2 76 0 64 1 51 4 84 10 42 12 5 7 45 8 20 11 93 14 48 13 75 9 100 
			2 35 1 1 3 15 6 49 5 78 4 80 0 99 9 88 7 24 11 20 10 100 8 28 14 71 13 1 12 7 
			3 69 6 24 5 21 4 3 1 28 2 8 0 42 10 33 11 40 9 50 8 8 13 5 12 13 7 42 14 73 
			0 83 4 15 2 62 6 27 5 5 1 65 3 100 14 65 10 82 7 89 13 81 9 92 8 38 11 47 12 96 
			6 98 4 24 2 75 0 57 1 93 3 74 5 10 7 44 13 59 11 51 12 82 14 65 10 8 8 12 9 24 
			4 55 0 44 3 47 5 75 2 81 6 30 1 42 10 100 8 81 7 29 13 31 9 47 11 34 12 77 14 92 
			2 18 5 42 0 37 4 1 3 67 6 20 1 91 8 21 14 57 12 100 10 100 11 59 13 77 9 21 7 98 
			3 42 1 16 4 19 6 70 2 7 0 74 5 7 12 50 9 74 8 46 14 88 13 71 10 42 7 34 11 60 
			6 12 4 45 2 7 0 15 1 22 3 31 5 70 13 88 9 46 8 44 14 45 12 87 11 5 7 99 10 70 
			4 51 5 39 0 50 2 9 3 23 6 28 1 49 13 5 12 17 14 40 10 30 11 62 8 65 7 84 9 12 
			6 92 0 67 5 85 1 88 3 18 4 13 2 70 7 69 14 10 13 52 8 42 11 82 10 19 12 21 9 5 
			4 34 0 60 1 52 5 70 2 51 6 2 3 43 10 75 11 45 8 53 12 96 13 1 14 44 7 66 9 19 
			6 31 1 44 0 84 3 16 4 10 2 4 5 48 13 67 14 11 12 21 8 78 7 42 11 44 9 37 10 35 
			1 20 4 40 3 37 2 68 6 42 0 11 5 6 10 44 11 43 12 17 14 3 7 77 13 100 9 82 8 5 
			5 14 0 5 3 40 1 70 4 63 2 59 6 42 9 74 13 32 7 50 10 21 14 29 12 83 11 64 8 45 
			6 70 0 28 3 79 4 25 5 98 2 24 1 54 12 65 13 93 10 74 7 22 9 73 11 75 8 69 14 9 
			5 100 2 46 4 69 3 41 1 3 6 18 0 41 8 94 11 97 12 30 14 96 7 7 9 86 13 83 10 90] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV07()
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