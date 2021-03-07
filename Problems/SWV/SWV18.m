classdef SWV18 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            7 35 6 23 2 92 4 5 5 40 1 90 3 30 9 35 8 8 0 86 
			2 60 3 97 8 21 9 70 7 82 0 12 4 3 5 45 1 75 6 69 
			7 96 2 38 0 61 1 55 4 31 5 48 9 79 3 4 6 12 8 29 
			4 83 7 82 8 97 1 43 0 95 6 92 2 18 3 29 5 4 9 67 
			3 46 9 80 8 66 2 38 4 95 1 40 7 89 0 32 6 64 5 1 
			6 57 4 80 8 68 7 27 0 90 5 45 3 98 9 59 1 6 2 94 
			5 50 0 91 2 97 9 63 7 52 3 48 4 4 8 96 1 18 6 100 
			7 23 6 43 3 25 8 83 2 76 9 41 1 88 0 31 5 44 4 13 
			2 20 3 90 9 20 4 42 8 72 5 46 1 27 0 81 6 40 7 34 
			7 80 5 97 0 42 2 49 9 10 1 10 3 71 4 71 6 14 8 98 
			2 79 3 29 0 96 7 66 1 58 8 31 4 47 5 76 6 59 9 88 
			8 93 6 3 1 7 3 27 5 66 7 23 0 60 4 97 2 66 9 55 
			9 12 8 39 4 77 5 79 0 26 7 58 2 98 6 38 3 31 1 28 
			6 8 9 48 4 4 1 87 3 38 2 28 8 10 0 19 7 82 5 83 
			5 6 9 13 2 86 6 19 3 26 7 79 0 55 1 85 8 33 4 30 
			3 37 8 26 7 29 6 74 9 43 5 17 0 45 2 28 1 58 4 15 
			7 15 3 37 6 21 5 47 2 90 0 37 9 33 1 42 4 7 8 62 
			8 49 4 46 1 28 7 18 6 41 2 57 0 75 3 21 9 3 5 32 
			6 98 1 30 8 24 4 91 9 73 7 25 5 49 0 40 2 9 3 4 
			6 33 3 94 1 21 2 90 9 86 7 85 5 29 0 17 4 94 8 90 
			6 3 4 85 1 66 7 61 8 57 3 84 2 5 9 40 0 54 5 70 
			7 81 1 98 2 45 0 18 6 65 9 1 4 98 3 30 8 84 5 82 
			6 40 7 77 3 72 1 97 5 39 4 21 0 59 8 42 9 90 2 26 
			5 57 3 63 1 14 4 64 6 23 8 78 2 54 0 51 9 100 7 96 
			5 61 1 55 6 73 2 87 4 35 3 41 7 96 0 32 8 91 9 60 
			9 19 5 90 8 91 0 45 3 66 2 84 1 61 7 3 6 84 4 100 
			2 33 9 72 6 27 8 14 3 59 0 39 7 20 5 29 4 54 1 88 
			4 45 0 18 3 73 2 26 8 55 6 22 7 27 1 46 9 43 5 77 
			2 57 9 16 1 71 8 25 7 50 3 41 6 58 5 71 4 9 0 32 
			8 48 9 32 0 42 3 73 1 56 7 53 6 3 5 66 4 15 2 44 
			6 69 7 14 1 2 8 40 4 70 9 90 3 38 2 31 5 55 0 50 
			9 100 8 14 0 55 2 5 5 12 4 79 1 68 3 83 6 89 7 78 
			4 26 5 44 8 39 1 84 7 64 9 98 3 38 2 2 6 27 0 18 
			3 98 2 10 9 99 8 50 0 20 6 12 4 7 1 57 7 87 5 89 
			0 64 8 63 7 98 5 31 1 30 6 62 3 11 4 89 9 31 2 34 
			3 26 6 43 4 69 7 27 8 92 2 51 1 10 5 29 9 21 0 37 
			8 21 5 98 0 64 6 38 2 23 1 13 7 89 9 89 4 21 3 27 
			4 39 7 32 1 67 0 33 5 16 2 43 6 62 3 42 9 70 8 90 
			7 73 9 45 3 37 0 45 2 61 6 25 5 15 4 5 8 58 1 98 
			7 94 0 17 6 15 5 81 9 64 3 62 1 2 8 16 2 35 4 40 
			5 32 6 37 9 11 0 25 1 37 8 21 2 76 7 52 4 56 3 87 
			3 23 2 40 1 6 7 31 6 25 9 98 8 29 4 4 5 25 0 33 
			8 96 9 30 1 95 3 2 6 3 2 22 0 62 4 30 7 1 5 99 
			9 54 5 3 0 78 2 43 6 90 7 88 4 1 8 97 1 30 3 96 
			5 29 6 60 3 80 1 94 2 67 0 42 8 17 9 27 7 75 4 86 
			1 17 5 62 2 25 7 80 6 62 9 19 8 81 3 73 0 57 4 90 
			9 31 3 54 5 28 1 19 4 4 2 34 8 64 6 46 7 60 0 27 
			9 95 7 1 2 43 3 6 4 7 8 66 1 45 5 13 0 80 6 1 
			3 20 7 82 0 87 1 65 6 64 8 61 2 21 5 32 9 16 4 37 
			0 49 3 54 2 31 8 69 1 21 5 2 6 73 9 35 4 66 7 82 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV18()
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