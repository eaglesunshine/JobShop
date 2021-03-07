classdef LA32 < PROBLEM
    properties
        num_job = 30;           % 工件数目
        num_mach = 10;          % 机器数目
        num_process = 10; % 工序数目
        process_time = [
            6 89 1 58 4 97 2 44 8 77 3 5 0 9 5 58 9 96 7 84 
			7 31 2 81 9 73 4 15 1 87 5 39 8 57 0 77 3 85 6 21 
			2 48 5 71 0 40 3 70 1 49 6 22 4 10 8 34 7 80 9 82 
			4 11 6 72 7 62 0 55 2 17 5 75 3 7 1 91 9 35 8 47 
			0 64 6 71 4 12 1 90 2 94 3 75 9 20 8 15 5 50 7 67 
			2 29 6 93 3 68 5 93 1 57 8 77 0 52 9 7 4 58 7 70 
			4 26 3 27 1 63 5 6 6 87 7 56 8 48 9 36 0 95 2 82 
			1 8 7 76 3 76 4 30 6 84 9 78 8 41 0 36 2 36 5 15 
			3 13 8 29 0 75 2 81 1 78 5 88 4 54 9 40 7 13 6 82 
			0 52 2 6 3 6 5 82 6 64 9 88 8 54 4 54 7 32 1 26 
			8 62 1 35 4 72 7 69 0 62 5 32 9 5 3 61 2 67 6 93 
			2 78 3 11 7 82 4 7 1 72 8 64 9 90 0 85 5 88 6 63 
			7 50 4 28 3 35 1 66 2 27 8 49 9 11 6 88 5 31 0 44 
			4 62 5 39 0 76 2 14 6 56 3 97 1 7 7 69 9 66 8 47 
			6 47 2 41 0 64 7 58 9 57 8 93 3 69 5 53 1 18 4 79 
			7 76 9 81 0 76 6 61 4 77 8 26 2 74 5 22 1 58 3 78 
			6 30 8 72 3 43 0 65 1 16 4 92 5 95 9 29 2 99 7 64 
			1 35 3 74 5 16 4 85 0 7 2 81 6 86 8 61 9 35 7 34 
			1 97 7 43 4 72 6 88 5 17 0 43 8 94 3 64 9 22 2 42 
			7 99 2 84 8 99 5 98 1 20 6 31 3 74 0 92 9 23 4 89 
			8 32 0 6 4 55 5 19 9 81 1 81 7 40 6 9 3 37 2 40 
			6 15 2 70 8 25 1 46 9 65 4 64 7 21 0 77 5 65 3 55 
			8 31 7 84 5 37 3 24 2 85 4 89 9 29 1 44 0 40 6 83 
			4 80 0 8 9 41 5 59 7 56 3 38 2 30 8 97 6 77 1 80 
			9 59 0 91 3 50 8 80 1 17 6 40 2 71 5 56 4 88 7 7 
			7 36 3 58 4 54 5 77 2 8 6 9 0 45 9 10 1 29 8 96 
			0 28 3 92 2 73 7 27 8 86 5 87 9 96 1 98 6 99 4 70 
			9 32 1 95 3 85 6 81 2 41 8 39 7 92 0 59 5 56 4 52 
			4 93 2 12 5 22 6 27 8 45 7 69 3 60 1 7 0 88 9 49 
			2 61 5 26 9 71 8 44 0 21 6 82 3 68 7 33 1 84 4 99 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = LA32()
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