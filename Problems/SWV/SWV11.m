classdef SWV11 < PROBLEM
    properties
        num_job = 50;           % 工件数目
        num_mach = 10;          	% 机器数目
        num_process = 10; 		% 工序数目
        process_time = [
            0 92 4 47 3 56 2 91 1 49 5 39 9 63 7 12 6 1 8 37 
			0 86 2 100 1 75 3 92 4 90 5 11 7 85 8 54 9 100 6 38 
			1 4 4 94 3 44 2 40 0 92 8 53 6 40 9 5 5 68 7 27 
			4 87 0 48 1 59 2 92 3 35 6 99 7 46 9 27 8 83 5 91 
			0 83 1 78 4 76 3 64 2 44 8 12 9 91 6 31 7 98 5 63 
			3 49 0 15 1 100 4 18 2 24 6 92 9 65 5 26 7 29 8 24 
			0 28 3 53 4 84 2 47 1 85 7 100 5 34 6 35 8 90 9 88 
			2 61 4 71 3 54 1 34 0 13 9 47 8 2 6 97 7 27 5 97 
			0 85 2 75 1 33 4 72 3 49 7 23 5 12 8 90 6 87 9 42 
			2 24 3 20 1 65 4 33 0 75 9 47 6 84 8 44 7 74 5 29 
			2 48 3 27 4 1 0 23 1 66 6 35 7 46 9 29 5 63 8 44 
			2 79 0 4 4 61 3 46 1 69 7 10 8 88 9 19 6 50 5 34 
			0 16 4 31 3 77 2 3 1 25 8 88 7 97 9 49 6 79 5 22 
			1 40 0 39 4 15 2 93 3 48 6 63 9 74 8 46 7 91 5 51 
			4 48 0 93 2 8 3 50 1 5 6 48 7 46 9 35 5 88 8 97 
			3 70 1 8 2 65 0 32 4 84 8 9 6 43 7 10 5 72 9 60 
			0 21 2 28 1 26 3 91 4 58 9 90 6 43 8 64 5 39 7 93 
			1 50 2 60 0 51 4 90 3 93 7 20 9 33 8 27 6 12 5 89 
			1 21 3 3 2 47 4 34 0 53 9 67 8 8 5 68 7 1 6 71 
			3 57 4 26 2 36 0 48 1 11 9 44 7 25 5 30 8 92 6 57 
			1 20 0 20 4 6 3 74 2 48 9 77 8 15 5 80 7 27 6 10 
			3 71 1 40 0 86 2 23 4 29 7 99 8 56 6 100 9 77 5 28 
			4 83 0 61 3 27 1 86 2 99 7 31 5 60 8 40 9 84 6 26 
			4 68 1 94 3 46 2 60 0 33 7 46 5 86 9 63 6 70 8 89 
			4 33 1 13 2 91 3 27 0 38 8 82 7 31 6 23 9 27 5 87 
			4 58 3 30 0 24 2 12 1 38 8 2 9 37 5 59 6 37 7 36 
			2 62 1 47 4 5 3 39 0 75 7 60 9 65 8 61 6 77 5 31 
			4 100 0 21 1 53 3 74 2 3 8 34 6 6 7 91 9 80 5 28 
			1 8 0 3 2 88 3 54 4 18 9 4 6 34 5 54 8 59 7 42 
			3 33 4 72 0 83 2 17 1 23 6 24 8 60 9 96 7 78 5 70 
			4 63 2 36 3 70 0 97 1 99 6 71 9 92 5 41 8 73 7 97 
			2 28 1 37 4 24 0 30 3 55 8 38 5 9 9 77 7 17 6 51 
			3 15 0 46 2 14 4 18 1 99 9 48 6 41 5 10 7 47 8 80 
			4 89 3 78 2 51 1 63 0 29 7 70 9 7 5 14 8 84 6 32 
			4 26 1 69 2 92 3 15 0 23 8 42 6 95 5 47 9 83 7 56 
			1 38 2 44 3 47 4 23 0 10 9 63 7 65 6 21 5 70 8 56 
			3 42 4 85 1 29 0 35 2 66 9 46 8 25 5 90 7 85 6 75 
			3 99 0 46 4 74 2 96 1 48 5 52 6 13 7 88 8 4 9 30 
			1 15 3 80 4 47 2 25 0 8 9 61 7 70 8 23 6 93 5 5 
			0 90 2 51 3 66 4 5 1 86 5 59 6 97 9 28 7 85 8 9 
			0 59 1 50 4 40 3 23 2 93 7 61 9 96 8 63 6 34 5 14 
			1 62 2 72 4 30 0 21 3 15 5 77 6 13 7 2 8 22 9 22 
			2 20 4 14 3 85 1 4 0 2 9 33 7 90 5 48 8 90 6 62 
			0 49 3 49 4 46 1 89 2 64 9 72 8 6 5 83 6 13 7 66 
			4 74 1 55 2 73 0 25 3 16 7 19 9 38 6 22 5 26 8 63 
			3 13 2 96 1 8 0 15 4 97 6 95 7 2 5 66 8 57 9 46 
			4 73 1 97 3 39 0 22 2 90 9 64 6 65 8 31 5 98 7 85 
			3 43 2 67 0 38 1 77 4 11 7 61 5 7 9 95 8 97 6 69 
			0 35 2 68 1 5 3 46 4 4 7 51 6 44 5 58 9 69 8 98 
			2 68 1 81 0 2 3 4 4 59 9 53 8 69 5 69 6 14 7 21 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV11()
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