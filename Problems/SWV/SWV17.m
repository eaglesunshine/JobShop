classdef SWV17 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            7 9 2 57 9 62 5 34 6 83 0 33 1 80 4 46 3 21 8 89 
			9 82 1 35 8 37 5 26 6 21 3 78 7 64 4 33 2 40 0 21 
			7 14 5 49 3 48 9 34 4 52 1 16 2 78 0 24 8 58 6 43 
			2 94 3 86 8 41 5 27 7 29 6 53 9 5 0 36 4 98 1 37 
			7 55 1 87 8 51 5 29 9 93 3 51 0 54 6 85 2 20 4 29 
			2 88 1 98 3 67 8 41 6 23 9 70 7 26 4 28 5 17 0 87 
			2 78 0 18 4 43 3 86 9 78 6 43 7 62 8 42 1 44 5 9 
			9 37 4 89 3 26 6 59 0 89 5 90 1 91 8 28 7 37 2 51 
			3 82 2 31 1 98 5 25 0 16 7 23 9 92 4 89 6 32 8 12 
			6 66 1 58 5 14 3 42 0 62 8 66 4 46 7 88 2 89 9 97 
			8 94 9 11 6 3 1 86 2 4 5 19 7 93 4 43 0 78 3 11 
			5 22 1 87 9 61 2 2 3 15 6 37 7 81 0 17 8 31 4 73 
			6 28 0 86 3 54 2 68 4 63 1 33 8 22 5 35 9 84 7 15 
			6 18 1 2 2 23 8 49 7 82 9 8 4 73 5 31 3 20 0 1 
			7 49 5 8 2 36 8 31 6 47 3 90 0 7 9 6 1 44 4 51 
			4 43 1 95 0 18 9 99 7 98 3 26 8 99 5 90 2 24 6 91 
			1 49 6 69 3 73 9 52 0 10 7 41 8 42 5 96 4 85 2 76 
			0 5 1 69 3 38 7 35 5 23 2 40 8 17 4 33 6 99 9 82 
			3 42 1 93 4 90 6 88 2 70 8 11 9 54 7 76 5 40 0 94 
			5 88 9 44 0 63 7 92 1 4 4 91 6 92 8 53 3 52 2 38 
			5 83 3 75 1 44 2 79 7 63 6 32 0 10 4 2 9 6 8 56 
			7 71 0 23 5 93 3 44 6 36 4 27 2 96 1 23 9 35 8 21 
			5 42 2 43 6 37 9 98 0 55 3 35 4 45 1 8 8 5 7 100 
			0 40 8 34 2 7 9 17 5 60 4 98 7 34 6 23 1 37 3 58 
			9 87 2 39 3 23 8 48 6 83 7 50 5 9 1 49 0 37 4 42 
			6 60 5 3 2 60 7 40 0 54 1 68 4 49 8 50 9 22 3 34 
			5 22 1 55 2 32 0 83 8 38 4 22 6 29 7 23 9 59 3 90 
			9 51 2 27 6 81 8 87 0 79 7 1 3 14 5 73 4 25 1 14 
			6 88 1 46 5 16 2 62 9 95 7 63 4 78 0 9 3 68 8 37 
			4 77 2 13 8 96 3 61 0 21 7 39 5 12 6 49 9 73 1 86 
			7 91 5 14 3 37 0 17 9 49 4 27 1 68 2 60 6 42 8 15 
			9 13 4 25 6 62 0 4 1 31 8 76 5 3 7 8 3 26 2 95 
			7 45 5 50 1 14 0 69 9 43 4 1 6 73 8 35 3 1 2 61 
			4 57 1 1 0 74 8 1 6 96 2 92 7 85 5 42 3 12 9 38 
			7 49 5 31 8 79 6 83 1 40 4 65 3 34 2 32 9 97 0 25 
			9 24 5 40 4 81 3 10 6 59 8 83 2 66 1 28 7 33 0 31 
			5 33 4 39 3 50 1 96 7 62 2 72 8 42 6 86 9 66 0 80 
			3 88 7 47 0 35 4 69 1 79 9 61 2 25 8 56 5 68 6 96 
			9 23 6 95 0 42 1 84 8 57 4 42 2 2 5 79 3 29 7 90 
			9 96 8 21 4 17 7 12 1 25 2 9 6 7 5 26 0 81 3 51 
			1 63 7 16 6 40 2 22 9 48 5 87 0 15 8 24 3 37 4 55 
			7 95 0 60 3 62 2 7 9 2 8 81 5 83 4 64 1 68 6 66 
			3 24 7 60 6 35 2 77 1 85 8 57 9 29 5 59 4 53 0 14 
			1 24 6 30 0 9 3 89 8 72 4 77 2 7 5 23 9 73 7 35 
			0 66 8 12 1 9 5 50 2 14 9 76 4 90 3 43 7 48 6 63 
			3 97 1 29 0 59 4 64 9 17 2 77 5 60 7 16 6 61 8 40 
			9 5 4 22 2 3 8 63 5 1 7 23 0 1 3 61 1 92 6 19 
			6 91 8 74 1 88 5 2 7 61 4 39 0 35 2 23 9 84 3 27 
			8 87 5 58 7 44 1 6 6 22 3 57 9 78 4 19 2 74 0 6 
			4 6 1 94 0 45 2 54 9 67 7 90 5 19 8 72 6 70 3 58 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV17()
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