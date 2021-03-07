classdef SWV09 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 15;          	% 机器数目
        num_process = 15; 		% 工序数目
        process_time = [
            5 8 3 73 0 69 2 38 6 6 4 62 1 78 9 79 8 59 13 77 11 22 10 80 12 58 14 49 7 48 
			3 34 4 29 2 69 0 5 5 63 1 82 6 94 14 17 11 94 9 29 10 5 13 75 7 15 8 61 12 61 
			1 52 2 30 0 25 6 17 3 46 4 86 5 3 14 70 11 34 9 23 10 68 13 76 8 53 12 71 7 9 
			2 50 4 20 3 24 0 53 1 97 5 79 6 92 14 3 12 52 10 75 9 74 8 59 7 75 13 84 11 99 
			2 15 0 61 3 47 4 38 6 49 5 21 1 6 11 8 8 71 14 83 13 24 12 18 9 33 7 70 10 100 
			4 48 5 50 2 66 0 92 6 2 3 58 1 23 9 84 8 66 10 12 7 36 14 4 12 88 13 64 11 12 
			3 29 0 25 6 44 5 87 2 42 1 44 4 86 8 28 10 86 9 74 14 77 13 59 12 94 7 58 11 16 
			4 31 3 58 0 94 5 69 2 44 1 93 6 92 9 80 8 63 12 47 13 3 7 79 11 39 14 80 10 75 
			1 69 2 27 0 76 5 19 6 86 3 16 4 31 12 33 9 69 13 19 10 43 14 9 11 37 7 35 8 24 
			2 75 3 78 6 41 4 60 5 59 0 42 1 60 12 18 8 31 10 15 7 54 14 60 9 20 11 61 13 69 
			4 89 6 20 1 27 5 78 3 2 2 21 0 55 13 79 11 77 10 99 9 70 12 30 7 97 8 41 14 98 
			6 1 2 10 4 84 5 72 0 14 1 9 3 51 7 22 14 65 10 100 13 65 11 43 8 10 12 14 9 19 
			5 50 2 13 3 49 6 75 1 42 0 81 4 89 9 100 14 54 13 37 10 7 11 38 8 25 12 78 7 79 
			2 44 3 77 5 26 1 42 4 9 6 73 0 60 9 61 10 85 12 14 11 92 7 100 14 49 8 46 13 12 
			2 72 0 53 1 43 5 65 6 59 4 87 3 13 8 71 12 25 9 71 10 89 11 2 7 76 14 21 13 12 
			2 60 6 28 5 33 1 36 0 6 3 96 4 48 9 40 11 79 10 60 8 39 13 34 7 54 12 20 14 52 
			5 82 2 12 3 11 4 61 1 21 0 21 6 34 12 86 14 53 8 7 9 4 7 95 10 62 13 54 11 82 
			5 72 0 13 3 46 6 97 1 87 4 87 2 11 7 45 14 85 11 66 8 43 9 39 13 34 10 30 12 55 
			1 39 5 19 0 19 4 73 6 63 3 30 2 69 9 36 7 13 10 96 12 27 13 59 14 76 11 62 8 14 
			1 7 4 14 3 79 2 27 6 43 0 96 5 24 11 30 7 27 12 2 8 69 14 75 13 34 10 79 9 96 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV09()
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