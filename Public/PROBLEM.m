classdef PROBLEM < handle
%PROBLEM - The superclass of all the problems.

    properties
        Global; % The current GLOBAL object
    end
    methods(Access = protected)
        %% Constructor
        function obj = PROBLEM()
            obj.Global = GLOBAL.GetObj();
        end
    end
    methods
        %% 创建初始种群
        function PopDec = Init(obj,N)
           %{
            n 个工件，t 台机器，m道工序：
            基于工序的编码：对于一个 n 个工件在 m 台机器加工的调度问题，其染色体由 n×m 个基因组成，每个工件序号
                只能在染色体中出现 m 次，从左到右扫描染色体，对于第 k 次出现的工件序号，表示该工件的第 k 道工序。
           %}
            
           PopDec = []; 
           
           n = obj.Global.num_job;
           m = obj.Global.num_process;
           gene = repmat(1:n, 1, m);
           
           for i = 1:N
               randIndex = randperm(size(gene,2));
               gene_new = gene(randIndex);
               PopDec = [PopDec; gene_new];
           end
        end
        
        %% Repair infeasible solutions
        function PopDec = CalDec(obj,PopDec)
        end
        
        %% Calculate objective values
        function PopObj = CalObj(obj,PopDec)
            PopObj(:,1) = PopDec(:,1)   + sum(PopDec(:,2:end),2);
            PopObj(:,2) = 1-PopDec(:,1) + sum(PopDec(:,2:end),2);
        end
    end
end