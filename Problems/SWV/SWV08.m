classdef SWV08 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 15;          	% 机器数目
        num_process = 15; 		% 工序数目
        process_time = [
            3 8 4 73 2 49 5 24 6 81 1 68 0 23 12 69 8 74 10 45 11 4 14 59 9 25 7 70 13 68 
			3 34 2 33 5 7 1 69 4 54 6 18 0 38 8 28 12 12 14 50 10 66 7 81 9 81 13 91 11 66 
			0 8 6 20 3 52 4 83 5 18 2 82 1 68 7 50 14 54 11 6 10 73 13 48 9 20 8 93 12 99 
			2 41 0 72 1 91 4 52 5 30 3 1 6 92 13 52 8 41 9 45 14 43 12 97 10 64 11 71 7 76 
			0 48 1 44 5 49 6 92 3 29 2 29 4 88 14 14 10 99 8 22 13 79 9 93 12 69 11 63 7 68 
			0 56 6 42 2 42 3 93 1 80 4 54 5 94 12 80 14 69 11 39 8 85 10 95 13 12 9 28 7 64 
			0 90 4 75 6 9 1 46 2 91 3 93 5 93 14 77 9 63 11 50 12 82 13 74 8 67 7 72 10 76 
			0 55 2 90 6 11 3 60 4 75 1 23 5 74 11 54 7 97 12 32 13 67 10 15 14 48 8 100 9 55 
			6 71 5 64 2 40 0 32 3 92 1 59 4 69 13 68 14 34 12 71 8 28 9 94 7 82 10 1 11 58 
			6 36 4 46 1 50 5 87 3 33 2 94 0 3 14 60 11 45 13 84 9 1 8 38 10 22 12 39 7 50 
			1 53 0 34 5 56 6 97 3 95 4 32 2 28 14 48 7 54 12 98 8 84 9 77 10 46 13 65 11 94 
			2 1 5 97 0 77 4 82 6 14 1 18 3 74 14 52 11 14 12 93 9 35 8 34 13 84 10 6 7 81 
			1 62 0 86 2 57 6 80 5 37 3 94 4 77 7 72 9 26 11 41 10 7 8 56 13 98 14 67 12 47 
			5 45 3 30 0 57 6 68 1 61 2 34 4 2 7 57 13 96 9 10 12 85 14 42 10 93 8 89 11 43 
			6 49 4 53 1 51 2 4 0 17 5 21 3 31 10 45 13 45 9 63 11 21 8 4 7 23 14 90 12 1 
			6 68 5 18 0 87 3 6 4 13 2 9 1 40 8 83 7 95 12 27 10 94 14 68 11 22 13 28 9 66 
			2 80 6 14 0 67 5 15 1 14 3 97 4 23 8 45 10 1 11 5 14 87 7 34 12 12 9 98 13 35 
			4 33 2 20 3 74 6 20 5 3 0 90 1 37 13 56 12 38 8 7 14 84 9 100 11 41 10 6 7 97 
			6 47 4 63 3 1 0 28 2 99 1 41 5 45 14 60 13 2 7 25 8 59 9 39 10 76 11 89 12 5 
			6 67 2 46 3 25 1 2 5 22 4 8 0 22 13 64 7 82 12 99 11 79 10 87 8 71 9 24 14 19 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV08()
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