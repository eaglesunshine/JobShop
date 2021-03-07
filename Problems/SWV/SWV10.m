classdef SWV10 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 15;          	% 机器数目
        num_process = 15; 		% 工序数目
        process_time = [
            3 8 2 73 1 79 0 95 6 69 4 9 5 5 8 85 9 52 11 43 14 32 7 91 10 24 13 89 12 38 
			6 45 1 70 4 84 3 24 5 18 0 20 2 71 8 21 7 60 9 98 10 70 13 52 12 34 11 23 14 52 
			6 16 4 68 1 85 0 39 5 40 2 98 3 61 10 77 7 60 11 73 9 66 14 84 8 16 13 43 12 88 
			0 72 1 17 3 68 4 89 2 94 6 98 5 56 10 88 13 27 9 60 12 61 8 8 7 88 11 48 14 65 
			6 78 2 24 5 28 0 73 4 21 1 69 3 52 14 32 8 83 11 48 10 29 13 48 12 92 9 43 7 82 
			4 54 6 31 5 14 3 47 0 82 1 75 2 4 8 31 12 72 7 58 9 45 13 91 14 31 11 61 10 27 
			4 88 1 28 5 92 6 62 3 93 0 14 2 65 7 33 9 44 8 31 14 32 11 72 13 47 12 61 10 34 
			0 52 1 59 5 98 3 6 2 19 6 53 4 39 8 74 12 48 10 33 13 49 11 92 7 22 14 41 9 37 
			0 2 6 85 3 34 2 51 4 97 5 95 1 73 14 61 9 28 12 73 8 21 11 85 7 75 13 42 10 7 
			5 94 1 28 0 77 2 56 6 79 4 2 3 82 9 88 10 93 12 44 14 5 8 96 7 34 13 56 11 41 
			2 15 5 88 6 18 3 14 1 82 0 58 4 33 13 19 10 42 9 36 14 57 12 85 7 3 11 62 8 36 
			3 30 6 33 0 13 4 4 2 74 1 37 5 78 14 2 13 56 9 21 10 61 11 81 7 18 8 59 12 62 
			5 40 1 75 6 45 0 41 3 97 2 65 4 92 7 11 12 44 8 40 9 100 11 91 14 66 13 53 10 27 
			1 83 2 52 0 84 3 66 5 3 6 5 4 71 13 41 10 42 11 63 12 50 14 43 8 3 9 35 7 18 
			4 44 0 26 1 59 6 81 2 84 5 81 3 91 13 41 7 42 11 53 8 63 14 89 9 15 10 64 12 40 
			1 46 0 97 5 67 4 97 3 71 6 88 2 69 14 44 12 20 11 52 13 34 10 74 8 79 7 10 9 87 
			3 71 6 13 4 100 2 67 1 57 5 24 0 36 7 88 14 79 8 21 9 86 12 60 11 28 10 14 13 3 
			0 97 6 24 2 41 4 40 1 51 5 73 3 19 9 27 12 70 13 98 10 11 11 83 7 76 8 60 14 12 
			5 88 3 48 1 33 4 96 6 10 0 49 2 52 10 38 13 49 7 31 12 94 14 23 9 7 11 5 8 4 
			2 85 0 100 5 51 6 91 1 21 3 83 4 30 12 23 9 48 8 19 11 47 10 95 7 23 14 78 13 22 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV10()
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