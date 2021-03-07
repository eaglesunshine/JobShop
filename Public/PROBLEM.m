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
        %% ������ʼ��Ⱥ
        function PopDec = Init(obj,N)
           %{
            n ��������t ̨������m������
            ���ڹ���ı��룺����һ�� n �������� m ̨�����ӹ��ĵ������⣬��Ⱦɫ���� n��m ��������ɣ�ÿ���������
                ֻ����Ⱦɫ���г��� m �Σ�������ɨ��Ⱦɫ�壬���ڵ� k �γ��ֵĹ�����ţ���ʾ�ù����ĵ� k ������
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