classdef SWV06 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 15;          	% 机器数目
        num_process = 15; 		% 工序数目
        process_time = [
            1 16 6 58 2 22 4 24 5 53 3 9 0 57 10 63 8 92 12 43 7 41 13 26 14 20 9 44 11 93 
			2 89 1 94 0 86 3 13 6 54 4 41 5 55 7 98 13 38 14 80 9 1 11 100 12 90 10 63 8 14 
			1 26 6 96 3 32 4 75 5 9 0 57 2 39 12 54 14 28 10 8 11 30 13 57 9 75 7 9 8 41 
			3 37 2 36 5 63 0 24 6 71 1 97 4 74 14 19 12 45 8 24 11 71 13 53 10 61 9 6 7 32 
			3 57 0 55 1 21 5 84 2 23 6 79 4 90 11 8 14 59 10 99 9 41 12 68 8 14 13 4 7 55 
			4 10 2 81 1 13 3 78 0 78 5 10 6 48 9 37 11 21 7 88 12 75 14 11 13 55 10 93 8 51 
			6 100 2 52 3 54 1 37 5 26 4 74 0 87 8 13 12 88 10 94 14 73 7 55 11 68 9 50 13 88 
			4 47 5 70 6 7 2 72 0 62 3 30 1 95 10 18 9 65 7 69 13 89 8 89 14 64 12 81 11 25 
			6 1 1 10 0 72 3 59 4 92 5 53 2 89 14 52 7 48 8 8 13 69 10 49 9 26 12 76 11 97 
			6 85 2 47 4 45 1 99 0 39 5 32 3 87 10 56 8 98 11 13 7 96 12 71 14 95 9 11 13 78 
			0 17 2 21 3 87 6 41 5 41 4 31 1 96 8 17 11 95 13 29 14 3 10 71 7 64 9 97 12 31 
			6 9 0 87 4 34 1 62 3 56 5 66 2 95 9 56 14 42 8 86 7 68 12 82 10 82 13 52 11 97 
			3 86 1 37 2 49 0 2 6 30 5 63 4 4 14 47 8 84 10 5 13 13 9 39 12 18 7 76 11 63 
			0 29 6 34 1 53 3 7 5 19 4 26 2 63 12 22 10 98 13 77 14 11 7 87 9 5 11 44 8 42 
			6 44 4 91 1 91 2 58 0 77 3 51 5 14 13 1 9 17 7 55 12 40 8 95 14 31 11 54 10 37 
			5 59 4 47 1 56 6 39 2 7 0 43 3 39 13 75 10 43 12 32 9 6 11 93 7 69 8 47 14 93 
			4 24 1 30 3 97 6 17 0 7 2 55 5 8 7 70 10 87 8 29 12 20 13 29 11 51 9 14 14 32 
			2 29 4 99 3 17 0 96 1 50 5 67 6 91 10 91 13 14 12 14 7 19 8 36 11 11 14 83 9 6 
			0 7 6 60 3 31 5 76 1 23 2 83 4 30 8 73 14 76 11 17 10 53 13 9 12 72 7 89 9 24 
			3 63 0 89 2 2 1 46 6 86 5 74 4 1 7 34 9 30 12 19 13 48 11 75 8 72 14 47 10 58 ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
    methods
        %% Initialization
        function obj = SWV06()
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