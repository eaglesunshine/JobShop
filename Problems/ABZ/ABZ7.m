classdef ABZ7 < PROBLEM
    properties
        num_job = 20;           % 工件数目
        num_mach = 15;          % 机器数目
        num_process = 15; % 工序数目
        process_time = [
            2 24 3 12 9 17 4 27 0 21 6 25 8 27 7 26 1 30 5 31 11 18 14 16 13 39 10 19 12 26 
            6 30 3 15 12 20 11 19 1 24 13 15 10 28 2 36 5 26 7 15 0 11 8 23 14 20 9 26 4 28 
            6 35 0 22 13 23 7 32 2 20 3 12 12 19 10 23 9 17 1 14 5 16 11 29 8 16 4 22 14 22 
            9 20 6 29 1 19 7 14 12 33 4 30 0 32 5 21 11 29 10 24 14 25 2 29 3 13 8 20 13 18 
            11 23 13 20 1 28 6 32 7 16 5 18 8 24 9 23 3 24 10 34 2 24 0 24 14 28 12 15 4 18 
            8 24 11 19 14 21 1 33 7 34 6 35 5 40 10 36 3 23 2 26 4 15 9 28 13 38 12 13 0 25 
            13 27 3 30 6 21 8 19 12 12 4 27 2 39 9 13 14 12 5 36 10 21 11 17 1 29 0 17 7 33 
            5 27 4 19 6 29 9 20 3 21 10 40 8 14 14 39 13 39 2 27 1 36 12 12 11 37 7 22 0 13 
            13 32 11 29 8 24 3 27 5 40 4 21 9 26 0 27 14 27 6 16 2 21 10 13 7 28 12 28 1 32 
            12 35 1 11 5 39 14 18 7 23 0 34 3 24 13 11 8 30 11 31 4 15 10 15 2 28 9 26 6 33 
            10 28 5 37 12 29 1 31 7 25 8 13 14 14 4 20 3 27 9 25 13 31 11 14 6 25 2 39 0 36 
            0 22 11 25 5 28 13 35 4 31 8 21 9 20 14 19 2 29 7 32 10 18 1 18 3 11 12 17 6 15 
            12 39 5 32 2 36 8 14 3 28 13 37 0 38 6 20 7 19 11 12 14 22 1 36 4 15 9 32 10 16 
            8 28 1 29 14 40 12 23 4 34 5 33 6 27 10 17 0 20 7 28 11 21 2 21 13 20 9 33 3 27 
            9 21 14 34 3 30 12 38 0 11 11 16 2 14 5 14 1 34 8 33 4 23 13 40 10 12 6 23 7 27 
            9 13 14 40 7 36 4 17 0 13 5 33 8 25 13 24 10 23 3 36 2 29 1 18 11 13 6 33 12 13 
            3 25 5 15 2 28 12 40 7 39 1 31 8 35 6 31 11 36 4 12 10 33 14 19 9 16 13 27 0 21 
            12 22 10 14 0 12 2 20 5 12 1 18 11 17 8 39 14 31 3 31 7 32 9 20 13 29 4 13 6 26 
            5 18 10 30 7 38 14 22 13 15 11 20 9 16 3 17 1 12 2 13 12 40 6 17 8 30 4 38 0 13 
            9 31 8 39 12 27 1 14 5 33 3 31 11 22 13 36 0 16 7 11 14 14 4 29 6 28 2 22 10 17  ] 
        % 第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
        
        O = []  % O(k,j)表示工件j的第k道工序采用的机器id
        p = []  % p(k,j)表示工件j的第k道工序加工的时间
        p_j = [] % p(j)表示工件j的总加工时间
        p_all = 0 % 所有工件总加工耗时
    end
    
     methods
        %% Initialization
        function obj = ABZ7()
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