classdef LA33 < PROBLEM
    properties
        num_job = 30;           % 工件数目
        num_mach = 10;          % 机器数目
        num_process = 10; % 工序数目
        process_time = [
            2 38 4 75 9 12 5 97 0 76 1 29 8 14 6 66 7 44 3 12 
			0 43 5 38 1 80 3 82 2 85 4 58 6 87 8 92 9 89 7 69 
			6 48 4 8 8 66 7 7 2 14 3 41 5 61 0 43 1 84 9 5 
			5 19 3 74 6 41 4 59 8 43 2 42 9 73 7 97 1 8 0 96 
			3 75 5 5 2 70 8 42 7 23 6 55 1 48 9 38 4 37 0 7 
			2 72 7 31 3 95 0 79 4 25 1 56 8 9 9 60 5 73 6 43 
			9 31 3 78 6 16 4 94 7 86 5 21 0 97 8 53 1 7 2 64 
			3 86 2 65 6 59 8 44 1 33 7 85 0 61 5 32 9 63 4 30 
			4 11 5 61 9 84 3 16 7 90 1 30 0 60 8 93 2 44 6 45 
			5 11 2 28 0 32 7 36 8 31 4 47 3 20 6 52 9 35 1 49 
			5 17 3 34 6 49 1 84 0 85 8 20 7 74 9 68 4 10 2 77 
			8 71 5 7 3 29 1 85 4 76 6 59 2 17 0 17 9 13 7 48 
			1 39 9 16 4 39 6 87 7 11 3 32 2 15 0 19 5 64 8 43 
			5 33 8 82 2 92 1 83 6 32 3 99 9 99 4 91 0 8 7 57 
			7 7 0 48 9 62 4 88 6 21 5 39 8 27 3 91 1 38 2 69 
			9 64 8 45 3 24 7 80 2 67 4 18 6 38 0 88 5 80 1 44 
			2 15 3 72 4 40 7 21 8 52 0 51 9 59 1 24 6 47 5 43 
			4 77 7 43 1 40 2 31 8 76 6 20 5 88 3 70 9 5 0 32 
			2 14 7 58 9 85 5 64 1 26 6 94 0 32 3 49 8 80 4 47 
			9 23 1 11 8 34 4 75 7 79 3 26 2 96 0 5 6 9 5 59 
			0 75 2 20 8 10 3 66 6 43 7 37 1 9 9 83 4 68 5 52 
			8 54 1 26 4 79 7 88 6 84 0 6 2 54 9 59 3 28 5 42 
			4 56 9 29 3 36 0 40 6 86 8 68 2 69 7 23 5 62 1 16 
			7 53 1 5 6 17 9 59 2 59 8 78 3 64 0 82 4 13 5 12 
			9 7 6 62 7 90 5 83 1 85 3 69 0 16 4 81 2 58 8 66 
			7 24 2 65 1 69 5 42 9 82 6 82 0 83 3 46 8 72 4 33 
			1 10 8 27 7 43 5 20 4 71 9 65 2 73 6 99 0 24 3 64 
			9 35 3 92 0 38 5 35 7 30 8 45 2 8 4 82 1 34 6 21 
			5 23 7 84 9 7 4 85 8 60 1 15 2 52 6 94 3 83 0 6 
			2 70 6 29 8 27 9 80 4 6 7 39 1 79 0 28 3 66 5 66] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = LA33()
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