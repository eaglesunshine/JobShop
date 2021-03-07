classdef LA35 < PROBLEM
    properties
        num_job = 30;           % 工件数目
        num_mach = 10;          % 机器数目
        num_process = 10; % 工序数目
        process_time = [
            0 66 2 84 3 26 7 29 9 94 6 98 8 7 5 98 1 45 4 43 
			3 32 0 97 6 55 2 88 8 93 9 88 1 20 4 50 7 17 5 5 
			4 43 3 68 8 47 9 68 1 57 6 20 5 81 2 60 7 94 0 62 
			1 57 5 40 0 78 6 9 2 49 9 17 3 32 4 30 8 87 7 77 
			0 52 4 30 3 48 5 48 1 26 9 17 6 93 8 97 7 49 2 89 
			7 95 0 33 1 5 6 17 5 70 3 57 4 34 2 61 8 62 9 39 
			7 97 5 92 1 31 8 5 2 79 4 5 3 67 0 5 9 78 6 60 
			2 79 4 6 7 20 8 45 6 34 3 24 9 26 5 68 1 16 0 46 
			7 58 9 50 2 19 8 93 6 49 3 25 5 85 4 50 0 93 1 26 
			9 81 6 71 5 7 1 39 2 16 8 42 0 71 4 84 3 56 7 99 
			8 9 0 86 9 6 3 71 6 97 5 85 4 16 2 42 7 81 1 81 
			4 72 3 24 0 30 8 56 2 43 1 61 7 82 6 40 5 59 9 43 
			9 43 1 13 6 70 7 93 0 95 8 12 4 15 2 78 5 97 3 14 
			0 14 6 26 1 71 3 46 8 80 5 31 4 37 9 27 7 92 2 67 
			2 12 0 43 5 96 6 7 3 45 7 20 1 13 9 29 4 60 8 33 
			1 78 5 50 6 84 0 42 8 84 4 30 9 76 2 57 7 87 3 59 
			4 49 7 50 1 15 8 13 0 93 6 50 9 32 5 59 3 10 2 35 
			1 25 0 47 7 60 8 33 4 53 5 37 9 73 2 22 3 87 6 79 
			0 84 6 83 1 71 5 68 9 89 8 11 3 60 4 50 2 33 7 97 
			1 14 0 38 6 88 5 5 4 77 7 92 8 24 2 73 9 52 3 71 
			7 62 9 19 6 38 3 15 8 64 2 64 4 8 1 61 0 19 5 33 
			2 33 5 46 4 74 0 56 6 84 9 83 8 19 7 8 3 32 1 97 
			4 50 3 71 6 50 2 97 9 8 0 17 7 19 8 92 5 54 1 52 
			8 32 1 79 3 97 5 38 9 49 4 76 6 76 0 56 2 78 7 54 
			5 13 3 5 2 25 0 86 1 95 9 28 6 78 8 24 7 10 4 39 
			7 48 2 59 0 20 9 7 5 31 6 97 1 89 4 32 3 25 8 41 
			5 87 0 18 9 48 2 43 1 30 6 97 7 47 8 65 3 69 4 27 
			6 71 5 20 8 20 1 78 3 39 0 17 7 50 2 44 9 42 4 38 
			0 50 9 42 3 72 5 7 1 77 7 58 4 78 2 89 6 70 8 36 
			3 32 9 95 2 13 0 73 6 97 8 24 4 49 5 57 1 68 7 94] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = LA35()
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