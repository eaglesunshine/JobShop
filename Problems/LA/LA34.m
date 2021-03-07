classdef LA34 < PROBLEM
    properties
        num_job = 30;           % 工件数目
        num_mach = 10;          % 机器数目
        num_process = 10; % 工序数目
        process_time = [
            2 51 7 59 1 35 5 73 9 65 0 27 6 13 3 81 8 32 4 74 
			4 64 7 33 5 75 2 33 8 10 0 28 3 38 6 53 9 49 1 55 
			6 83 1 23 2 72 3 7 9 72 0 6 4 39 5 52 8 90 7 21 
			3 82 1 23 2 93 4 78 6 88 7 53 9 28 8 65 5 21 0 61 
			4 41 6 12 9 12 3 77 1 70 7 24 0 81 5 73 2 62 8 6 
			4 98 3 28 6 42 9 72 0 15 8 15 5 94 2 33 1 51 7 99 
			0 32 8 22 9 96 4 15 6 78 3 31 5 7 1 94 2 23 7 86 
			7 93 2 97 3 43 5 73 0 24 8 68 9 88 1 42 4 35 6 72 
			2 14 0 44 8 13 5 67 1 63 3 49 7 5 4 17 6 85 9 66 
			7 82 9 15 3 72 4 26 0 8 1 68 6 21 8 45 2 99 5 27 
			4 93 6 23 0 51 8 54 3 49 1 96 2 56 9 36 5 53 7 52 
			8 60 0 14 4 70 9 55 1 23 5 83 3 38 2 24 7 37 6 48 
			0 62 7 15 8 69 9 23 1 82 6 26 4 45 5 33 3 12 2 37 
			6 72 1 9 7 15 5 28 8 92 9 12 0 59 3 64 4 87 2 73 
			0 50 1 14 7 90 5 46 3 71 4 48 2 80 9 61 8 24 6 44 
			0 22 9 94 5 16 3 73 2 54 8 54 4 46 1 97 6 61 7 75 
			9 55 3 67 6 77 4 30 7 6 1 32 8 47 5 93 2 6 0 40 
			1 30 3 98 7 79 0 22 6 79 2 7 8 36 9 36 5 9 4 92 
			8 37 7 72 2 52 4 31 1 82 9 54 5 7 6 82 3 73 0 49 
			1 73 3 83 7 45 2 76 4 43 9 29 0 35 5 92 8 39 6 28 
			2 58 0 26 1 48 8 52 7 34 6 96 5 70 4 98 3 80 9 94 
			1 70 8 23 5 26 4 14 6 90 2 93 3 21 0 42 7 18 9 36 
			4 28 6 76 7 25 0 17 1 84 2 67 8 87 3 43 9 88 5 84 
			7 30 3 91 8 52 4 80 0 21 5 8 9 37 2 15 6 12 1 92 
			1 28 4 7 7 46 6 92 2 77 3 15 9 69 8 54 0 47 5 39 
			9 50 5 44 2 64 8 38 4 93 6 33 7 75 0 41 1 24 3 5 
			7 94 0 17 6 87 2 21 8 92 9 28 1 61 4 63 3 34 5 77 
			3 72 8 98 9 5 4 28 2 9 5 95 6 64 1 43 0 50 7 96 
			0 85 2 85 8 39 1 98 7 24 3 71 5 60 4 55 9 22 6 35 
			3 78 6 49 2 46 1 11 0 90 5 20 9 34 7 6 4 70 8 74] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = LA34()
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