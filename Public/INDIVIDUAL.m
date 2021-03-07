classdef INDIVIDUAL < handle
% INDIVIDUAL properties:
%   dec         <read-only>     decision variables of the individual
%   obj         <read-only>     objective values of the individual
%   con         <read-only>     constraint violations of the individual
%   add         <read-only>     additional properties of the individual
%
% INDIVIDUAL methods:
%   INDIVIDUAL	<public>        the constructor, all the properties will be
%                               set when the object is creating
%   decs        <public>      	get the matrix of decision variables of the
%                               population
%   objs        <public>        get the matrix of objective values of the
%                               population
%   cons        <public>        get the matrix of constraint violations of
%                               the population
%   adds        <public>        get the matrix of additional properties of
%                               the population
    properties(SetAccess = private)
        dec;        % Decision variables of the individual
        obj;        % Objective values of the individual
        con;        % Constraint violations of the individual
        add;        % Additional properties of the individual
    end
    methods
        %% Constructor
        function obj = INDIVIDUAL(Decs,AddProper)
            if nargin > 0
                % Create new objects
                obj(1,size(Decs,1)) = INDIVIDUAL;
                Global = GLOBAL.GetObj();
                % Calculte the objective values and constraint violations
                Decs = Global.problem.CalDec(Decs);
                Objs = Global.problem.CalObj(Decs);
                Cons = Global.problem.CalCon(Decs);
                % Assign the decision variables, objective values, and additional properties
                for i = 1 : length(obj)
                    obj(i).dec = Decs(i,:);
                    obj(i).obj = Objs(i,:);
                    obj(i).con = Cons(i,:);
                end
                if nargin > 1
                    for i = 1 : length(obj)
                        obj(i).add = AddProper(i,:);
                    end
                end
                % Increase the number of evaluated individuals
                Global.evaluated = Global.evaluated + length(obj);
            end
        end
        %% Get the matrix of decision variables of the population
        function value = decs(obj)
        %decs - Get the matrix of decision variables of the population.
        %
        %   A = obj.decs returns the matrix of decision variables of the
        %   population obj, where obj is an array of INDIVIDUAL objects.
        
            value = cat(1,obj.dec);
        end
        %% Get the matrix of objective values of the population
        function value = objs(obj)
        %objs - Get the matrix of objective values of the population.
        %
        %   A = obj.objs returns the matrix of objective values of the
        %   population obj, where obj is an array of INDIVIDUAL objects.
        
            value = cat(1,obj.obj);
        end
        %% Get the matrix of constraint violations of the population
        function value = cons(obj)
        %cons - Get the matrix of constraint violations of the population.
        %
        %   A = obj.cons returns the matrix of constraint violations of the
        %   population obj, where obj is an array of INDIVIDUAL objects.
        
            value = cat(1,obj.con);
        end
        %% Get the matrix of additional properties of the population
        function value = adds(obj,AddProper)
        %adds - Get the matrix of additional properties of the population.
        %
        %   A = obj.adds(AddProper) returns the matrix of additional
        %   properties of the population obj. If any individual in obj does
        %   not contain an additional property, assign it a default value
        %   specified in AddProper.

            for i = 1 : length(obj)
                if isempty(obj(i).add)
                    obj(i).add = AddProper(i,:);
                end
            end
            value = cat(1,obj.add);
        end
    end
end