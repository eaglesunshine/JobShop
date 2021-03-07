classdef GLOBAL < handle
    properties(Access = public)
        N          = 126;               % Population size

        M = 5;                              % Number of objectives
        D;                              % Number of decision variables
        lower;                          % Lower bound of each decision variable
        upper;                          % Upper bound of each decision variable
        encoding   = 'real';            % Encoding of the problem
        evaluation = 126*50;             % Maximum number of evaluations

        evaluated  = 0;                 % Number of evaluated individuals

        algorithm  = @NSGAII;       	% Algorithm function
        problem    = @ABZ5;            % Problem function
        gen;                            % Current generation
        maxgen;                         % Maximum generation
        run        = 1;                 % Run number
        runtime    = 0;                 % Runtime
        save       = 1;             	% Number of saved populations
        result     = {};                % Set of saved populations
        PF;                             % True Pareto front
        parameter  = struct();      	% Parameters of functions specified by users
        outputFcn  = @GLOBAL.Output;  	% Function invoked after each generation
        
        %% add
        num_job = 10;   % 工件的数目
        num_mach = 10;  % 机器的数目
        num_process = 10;   % 每个工件需要加工的工序的数目
        process_time = [];  % 工序时间矩阵，其中第i行的第j个(x,y)数值对的形式，表示第i号工件的第j道工序需要在x号机器上加工y时间
    end
    
    methods
        %% 初始化参数
        function obj = GLOBAL(varargin)
            obj.GetObj(obj);
            % 初始化用户可以指定的参数
            propertyStr = {'N','M','D','algorithm','problem','evaluation','run','save','outputFcn'};
            if nargin > 0
                IsString = find(cellfun(@ischar,varargin(1:end-1))&~cellfun(@isempty,varargin(2:end)));
                [~,Loc]  = ismember(varargin(IsString),cellfun(@(S)['-',S],propertyStr,'UniformOutput',false));
                for i = find(Loc)
                    obj.(varargin{IsString(i)}(2:end)) = varargin{IsString(i)+1};
                end
            end
            % 初始化测试集对象
            obj.problem = obj.problem();
            % 将算法和问题集的文件夹添加到搜索路径的顶部
            addpath(fileparts(which(class(obj.problem))));
            addpath(fileparts(which(func2str(obj.algorithm))));
        end
        
        %% Start running the algorithm
        function Start(obj)
        %Start - Start running the algorithm.
        %
        %   obj.Start() runs the algorithm. This method of one GLOBAL
        %   object can only be invoked once.
        %
        %   Example:
        %       obj.Start()

            if obj.evaluated <= 0

                try
                    tic;
                    obj.algorithm(obj);
                catch err
                    if strcmp(err.identifier,'GLOBAL:Termination')
                        return;
                    else
                        rethrow(err);
                    end
                end
                obj.evaluated = max(obj.evaluated,obj.evaluation);
                if isempty(obj.result)
                    obj.result = {obj.evaluated,INDIVIDUAL()};
                end
            	obj.outputFcn(obj);
            end
        end
        %% Randomly generate an initial population
        function Population = Initialization(obj,N)
        %Initialization - Randomly generate an initial population.
        %
        %   P = obj.Initialization() returns an initial population, i.e.,
        %   an array of obj.N INDIVIDUAL objects.
        %
        %   P = obj.Initialization(N) returns an initial population with N
        %   individuals.
        %
        %   Example:
        %       P = obj.Initialization()
        
            if nargin < 2
                N = obj.N;
            end
            Population = INDIVIDUAL(obj.problem.Init(N));
        end
        %% Terminate the algorithm if the number of evaluations has exceeded
        function notermination = NotTermination(obj,Population)
        %NotTermination - Terminate the algorithm if the number of
        %evaluations has exceeded.
        %
        %   obj.NotTermination(P) stores the population P as the final
        %   population for output, and returns true if the number of
        %   evaluations has not exceeded (otherwise returns false). If the
        %   number of evaluations has exceeded, then throw an error to
        %   terminate the algorithm forcibly.
        %
        %   This function should be invoked after each generation, and the
        %   function obj.outputFcn will be invoked when obj.NotTermination
        %   is invoked.
        %
        %   The runtime of executing this function and obj.outputFcn is not
        %   counted as part of the runtime of the algorithm.
        %
        %   Example:
        %       obj.NotTermination(Population)
        
            % Accumulate the runtime
            obj.runtime = obj.runtime + toc;
            % Save the last population
            if obj.save<=0; num=10; else; num=obj.save; end
            index = max(1,min(min(num,size(obj.result,1)+1),ceil(num*obj.evaluated/obj.evaluation)));
            obj.result(index,:) = {obj.evaluated,Population};
            % Invoke obj.outputFcn
            obj.outputFcn(obj);
            % Detect whether the number of evaluations has exceeded
            notermination = obj.evaluated < obj.evaluation;
            if obj.evaluated < obj.evaluation
                disp(obj.evaluated/obj.N)
            end
            assert(notermination,'GLOBAL:Termination','Algorithm has terminated');
            tic;
        end
        %% Obtain the parameter settings from user
        function varargout = ParameterSet(obj,varargin)
        %ParameterSet - Obtain the parameter settings from user.
        %
        %   [p1,p2,...] = obj.ParameterSet(v1,v2,...) returns the values of
        %   p1, p2, ..., where v1, v2, ... are their default values. The
        %   values are specified by the user with the following form:
        %   MOEA(...,'-X_parameter',{p1,p2,...},...), where X is the
        %   function name of the caller.
        %
        %   MOEA(...,'-X_parameter',{[],p2,...},...) indicates that p1 is
        %   not specified by the user, and p1 equals to its default value
        %   v1.
        %
        %   Example:
        %       [p1,p2,p3] = obj.ParameterSet(1,2,3)

            CallStack = dbstack();
            caller    = CallStack(2).file;
            caller    = caller(1:end-2);
            varargout = varargin;
            if isfield(obj.parameter,caller)
                specified = cellfun(@(S)~isempty(S),obj.parameter.(caller));
                varargout(specified) = obj.parameter.(caller)(specified);
            end
        end
        %% Variable constraint
        function set.N(obj,value)
            obj.Validation(value,'int','size of population ''-N''',1);
            obj.N = value;
        end
        function set.M(obj,value)
            obj.Validation(value,'int','number of objectives ''-M''',2);
            obj.M = value;
        end
        function set.D(obj,value)
            obj.Validation(value,'int','number of variables ''-D''',1);
            obj.D = value;
        end
        function set.algorithm(obj,value)
            if iscell(value) 
                obj.Validation(value{1},'function','algorithm ''-algorithm''');
                obj.algorithm = value{1};
                obj.parameter.(func2str(value{1})) = value(2:end);
            else
                obj.Validation(value,'function','algorithm ''-algorithm''');
                obj.algorithm = value;
            end
        end
        function set.problem(obj,value)
            if iscell(value)
                obj.Validation(value{1},'function','test problem ''-problem''');
                obj.problem = value{1};
                obj.parameter.(func2str(value{1})) = value(2:end);
            elseif ~isa(value,'PROBLEM')
                obj.Validation(value,'function','test problem ''-problem''');
                obj.problem = value;
            else
                obj.problem = value;
            end
        end
        function set.evaluation(obj,value)
            obj.Validation(value,'int','number of evaluations ''-evaluation''',1);
            obj.evaluation = value;
        end
        function set.run(obj,value)
            obj.Validation(value,'int','run number ''-run''',1);
            obj.run = value;
        end
        function set.save(obj,value)
            obj.Validation(value,'int','number of saved populations ''-save''',0);
            obj.save = value;
        end
        %% Variable dependence
        function value = get.gen(obj)
            value = ceil(obj.evaluated/obj.N);
        end
        function value = get.maxgen(obj)
            value = ceil(obj.evaluation/obj.N);
        end
    end
    methods(Static)
        %% Get the current GLOBAL object
        function obj = GetObj(obj)
        %GetObj - Get the current GLOBAL object.
        %
        %   Global = GLOBAL.GetObj() returns the current GLOBAL object.
        %
        %   Example:
        %       Global = GLOBAL.GetObj()
        
            persistent Global;
            if nargin > 0
                Global = obj;
            else
                obj = Global;
            end
        end
    end

    % The following functions cannot be invoked by users
    methods(Access = private)
        %% Check the validity of the specific variable
        function Validation(obj,value,Type,str,varargin)
            switch Type
                case 'function'
                    assert(isa(value,'function_handle'),'INPUT ERROR: the %s must be a function handle',str);
                    assert(~isempty(which(func2str(value))),'INPUT ERROR: the function <%s> does not exist',func2str(value));
                case 'int'
                    assert(isa(value,'double') && isreal(value) && isscalar(value) && value==fix(value),'INPUT ERROR: the %s must be an integer scalar',str);
                    if ~isempty(varargin); assert(value>=varargin{1},'INPUT ERROR: the %s must be not less than %d',str,varargin{1}); end
                    if length(varargin) > 1; assert(value<=varargin{2},'INPUT ERROR: the %s must be not more than %d',str,varargin{2}); end
                    if length(varargin) > 2; assert(mod(value,varargin{3})==0,'INPUT ERROR: the %s must be a multiple of %d',str,varargin{3}); end
            end
        end
    end
    methods(Access = private, Static)
        %% Display or save the result after the algorithm is terminated
        function Output(obj)
            clc; fprintf('%s on %s, %d objectives %d variables, run %d (%6.2f%%), %.2fs passed...\n',...
                         func2str(obj.algorithm),class(obj.problem),obj.M,obj.D,obj.run,obj.evaluated/obj.evaluation*100,obj.runtime);
            if obj.evaluated >= obj.evaluation
                folder = fullfile('Data',func2str(obj.algorithm));
                [~,~]  = mkdir(folder);
                result         = obj.result;
                metric.runtime = obj.runtime;
                save(fullfile(folder,sprintf('%s_%s_M%d_D%d_%d.mat',func2str(obj.algorithm),class(obj.problem),obj.M,obj.D,obj.run)),'result','metric');
            end
        end
        function cb_metric(hObject,eventdata,obj,metric)
            metricName   = func2str(metric);
            MetricValues = get(gcbf,'UserData');
            % Calculate the specified metric value of each population
            if ~isfield(MetricValues,func2str(metric)) 
                tempText = text('Units','normalized','Position',[.4 .5 0],'String','Please wait ... ...'); drawnow();
                MetricValues.(metricName)(:,1) = obj.result(:,1);
                MetricValues.(metricName)(:,2) = cellfun(@(S)GLOBAL.Metric(metric,S,obj.PF),obj.result(:,2),'UniformOutput',false);
                set(gcbf,'UserData',MetricValues);
                delete(tempText);
            end
            % Display the results
            cla; Draw(cell2mat(MetricValues.(metricName)),'-k.','LineWidth',1.5,'MarkerSize',10);
            xlabel('Number of Evaluations');
            ylabel(metricName);
            GLOBAL.cb_menu(hObject);
        end
        function cb_menu(hObject)
            % Switch the selected menu
            set(get(get(hObject,'Parent'),'Children'),'Checked','off');
            set(hObject,'Checked','on');
        end
        function value = Metric(metric,Population,PF)
            % Calculate the metric value of the population
            Feasible     = find(all(Population.cons<=0,2));
            NonDominated = NDSort(Population(Feasible).objs,1) == 1;
            try
                value = metric(Population(Feasible(NonDominated)).objs,PF);
            catch
                value = NaN;
            end
        end
    end
end