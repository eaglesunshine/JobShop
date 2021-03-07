function main(varargin)
    cd(fileparts(mfilename('fullpath')));
    addpath(genpath(cd));   
    
%     %% ������
%     Score_1 = CalculateCoverage('MaOEACE2', 'MaOEACE', 'ABZ6', 5, 100, 1, 126)
%     Score_2 = CalculateCoverage('MaOEACE', 'MaOEACE2', 'ABZ6', 5, 100, 1, 126)
%     
    
    %% ��¼����ʵ��������ã�ÿ��ʵ�����������main.m�еĲ�������
    fid_info=fopen('Result/info.txt','w');
    now_date = datestr(date);
    fprintf(fid_info,'ʵ��ʱ��=%s\n', now_date);
    
    %% ʵ���������
    N = 126;        % ��Ⱥ��С
    M = 5;          % Ŀ�����
    FT = 50;        % ��������
    Run_Num = 10;    % ���д���
    fprintf(fid_info,'��Ⱥ��С=%d Ŀ�����=%d ��������=%d ���д���=%d\n\n', N, M, FT, Run_Num);
 
    %% �Ա����⼯
    Problems_FT = {'FT06';'FT10'; 'FT20'};  % 3����6x6~20x5
    Problems_D_FT = [6*6 10*10 20*5];
    Problems_YN = {'YN1'; 'YN2'; 'YN3'; 'YN4'};   % 4����20x20~20x20
    Problems_D_YN = [20*20 20*20 20*20 20*20];
    Problems_ABZ = {'ABZ5'; 'ABZ6'; 'ABZ7'; 'ABZ8'; 'ABZ9'};  % 5����10x10~20x15
    Problems_D_ABZ = [10*10 10*10 20*15 20*15 20*15];
    Problems_ORB = {'ORB01'; 'ORB02'; 'ORB03'; 'ORB04'; 'ORB05'; 'ORB06'; 'ORB07'; 'ORB08'; 'ORB09'; 'ORB10'};   % 10����10x10~10x10
    Problems_D_ORB = [10*10 10*10 10*10 10*10 10*10 10*10 10*10 10*10 10*10 10*10];
    Problems_SWV = {'SWV01'; 'SWV02'; 'SWV03'; 'SWV04'; 'SWV05'; 'SWV06'; 'SWV07'; 'SWV08'; 'SWV09'; 'SWV10'; ...
                    'SWV11'; 'SWV12'; 'SWV13'; 'SWV14'; 'SWV15'; 'SWV16'; 'SWV17'; 'SWV18'; 'SWV19'; 'SWV20'};   % 20����20x10~50x10
    Problems_D_SWV = [20*10 20*10 20*10 20*10 20*10 20*15 20*15 20*15 20*15 20*15 ...
                      50*10 50*10 50*10 50*10 50*10 50*10 50*10 50*10 50*10 50*10];
    Problems_LA = {'LA01'; 'LA02'; 'LA03'; 'LA04'; 'LA05'; 'LA06'; 'LA07'; 'LA08'; 'LA09'; 'LA10'; ...
                   'LA11'; 'LA12'; 'LA13'; 'LA14'; 'LA15'; 'LA16'; 'LA17'; 'LA18'; 'LA19'; 'LA20'; ...
                   'LA21'; 'LA22'; 'LA23'; 'LA24'; 'LA25'; 'LA26'; 'LA27'; 'LA28'; 'LA29'; 'LA30'; ...
                   'LA31'; 'LA32'; 'LA33'; 'LA34'; 'LA35'; 'LA36'; 'LA37'; 'LA38'; 'LA39'; 'LA40' };   % 40����10x5~30x10
    Problems_D_LA = [10*5 10*5 10*5 10*5 10*5 15*5 15*5 15*5 15*5 15*5 ...
                     20*5 20*5 20*5 20*5 20*5 10*10 10*10 10*10 10*10 10*10 ...
                     15*10 15*10 15*10 15*10 15*10 20*10 20*10 20*10 20*10 20*10 ...
                     30*10 30*10 30*10 30*10 30*10 15*15 15*15 15*15 15*15 15*15];
    
    %% �Ա��㷨
    Algorithms = {'MaOEACE'; 'NSGAIII';  'MaOEACSS'; 'NSGAIISDR'; 'SRA'};
    
    % ������Ӧָ���ļ�
    fid_Coverage = fopen('Result/Coverage.csv','w');
    fid_Coverage_std = fopen('Result/Coverage_std.csv','w');
    fid_PD = fopen('Result/PD.csv','w');
    fid_Spacing = fopen('Result/Spacing.csv','w');
    
    % д��ÿ���ļ��ı�ͷ
    fprintf(fid_Coverage,'Problem,D_Num,');
    fprintf(fid_Coverage_std,'Problem,D_Num,');
    fprintf(fid_PD,'Problem,D_Num,');
    fprintf(fid_Spacing,'Problem,D_Num,');
    base_alg = Algorithms{1}; 
    for k = 1:size(Algorithms, 1)
        algorithm = Algorithms{k}; 
        fprintf(fid_PD,'%s,',algorithm);
        fprintf(fid_Spacing,'%s,',algorithm);
        if k>1
            fprintf(fid_Coverage,'%s vs %s,',base_alg, algorithm);
            fprintf(fid_Coverage,'%s vs %s,',algorithm, base_alg);
            fprintf(fid_Coverage_std,'%s vs %s,',base_alg, algorithm);
            fprintf(fid_Coverage_std,'%s vs %s,',algorithm, base_alg);
        end
    end
    fprintf(fid_Coverage,'\n');
    fprintf(fid_Coverage_std,'\n');
    fprintf(fid_PD,'\n');
    fprintf(fid_Spacing,'\n');
    
    %% ��������ָ��
    Problems_All = {Problems_FT Problems_YN Problems_ABZ Problems_ORB Problems_SWV Problems_LA};
    Problems_D_All = {Problems_D_FT Problems_D_YN Problems_D_ABZ Problems_D_ORB Problems_D_SWV Problems_D_LA};
    
    
        for idx = 1:size(Problems_All, 2)
            Problems = Problems_All{1,idx};
            Problems_D = Problems_D_All(1,idx);
            Problems_D = Problems_D{1,1};
            for i = 1:size(Problems, 1)
                Problem = Problems{i};
                D_num = Problems_D(1,i);
                
                % ��¼��������
                fprintf(fid_Coverage,'%s,%d,%d,',Problem,D_num);
                fprintf(fid_Coverage_std,'%s,%d,%d,',Problem,D_num);
                fprintf(fid_PD,'%s,%d,%d,',Problem,D_num);
                fprintf(fid_Spacing,'%s,%d,%d,',Problem,D_num);
                
                alg_1 = Algorithms{1};
                for k = 1:size(Algorithms, 1)
                     alg_2 = Algorithms{k};
                     if k>1
                         score_1_sum = 0;
                         score_2_sum = 0;
                         score_1 = [];
                         score_2 = [];
                         % �����ֵ
                         for run_num = 1:Run_Num    
                             % 1.����Coverageָ��
                             s1 = CalculateCoverage(alg_1, alg_2, Problem, M, D_num, run_num, N);
                             s2 = CalculateCoverage(alg_2, alg_1, Problem, M, D_num, run_num, N);
                             score_1_sum = score_1_sum + s1;
                             score_2_sum = score_2_sum + s2; 
                             score_1 = [score_1, s1];
                             score_2 = [score_2, s2];
                         end
                         Coverage_1 = score_1_sum / Run_Num;
                         Coverage_2 = score_2_sum / Run_Num;
                         % ���㷽��
                         std_1 = 0;
                         std_2 = 0;
                         for run_num = 1:Run_Num
                             std_1 = std_1 + (score_1(1,run_num) - Coverage_1) * (score_1(1,run_num) - Coverage_1);
                             std_2 = std_2 + (score_2(1,run_num) - Coverage_2) * (score_2(1,run_num) - Coverage_2);
                         end
                         std_1 = abs(sqrt(std_1 / Run_Num));
                         std_2 = abs(sqrt(std_2 / Run_Num));
                         fprintf(fid_Coverage,'%f,%f,',Coverage_1, Coverage_2);
                         %fprintf(fid_Coverage_std,'leftGG%frightGG,leftGG%frightGG,',std_1, std_2);
                     end
                end
                
                % ��¼һ��ָ���������ͬ�㷨����ͬһ����������
                fprintf(fid_Coverage,'\n');
                fprintf(fid_Coverage_std,'\n');
                fprintf(fid_PD,'\n');
                fprintf(fid_Spacing,'\n');
                
                % ��¼��������
                fprintf(fid_Coverage,'%s,%d,%d,',Problem,D_num);
                fprintf(fid_Coverage_std,'%s,%d,%d,',Problem,D_num);
                fprintf(fid_PD,'%s,%d,%d,',Problem,D_num);
                fprintf(fid_Spacing,'%s,%d,%d,',Problem,D_num);
                
                alg_1 = Algorithms{1};
                for k = 1:size(Algorithms, 1)
                     alg_2 = Algorithms{k};
                     if k>1
                         score_1_sum = 0;
                         score_2_sum = 0;
                         score_1 = [];
                         score_2 = [];
                         % �����ֵ
                         for run_num = 1:Run_Num    
                             % 1.����Coverageָ��
                             s1 = CalculateCoverage(alg_1, alg_2, Problem, M, D_num, run_num, N);
                             s2 = CalculateCoverage(alg_2, alg_1, Problem, M, D_num, run_num, N);
                             score_1_sum = score_1_sum + s1;
                             score_2_sum = score_2_sum + s2; 
                             score_1 = [score_1, s1];
                             score_2 = [score_2, s2];
                         end
                         Coverage_1 = score_1_sum / Run_Num;
                         Coverage_2 = score_2_sum / Run_Num;
                         % ���㷽��
                         std_1 = 0;
                         std_2 = 0;
                         for run_num = 1:Run_Num
                             std_1 = std_1 + (score_1(1,run_num) - Coverage_1) * (score_1(1,run_num) - Coverage_1);
                             std_2 = std_2 + (score_2(1,run_num) - Coverage_2) * (score_2(1,run_num) - Coverage_2);
                         end
                         std_1 = abs(sqrt(std_1 / Run_Num));
                         std_2 = abs(sqrt(std_2 / Run_Num));
                         %fprintf(fid_Coverage,'%f,%f,',Coverage_1, Coverage_2);
                         fprintf(fid_Coverage,'leftGG%frightGG,leftGG%frightGG,',std_1, std_2);
                     end
                end
                
                % ��¼һ��ָ���������ͬ�㷨����ͬһ����������
                fprintf(fid_Coverage,'\n');
                fprintf(fid_Coverage_std,'\n');
                fprintf(fid_PD,'\n');
                fprintf(fid_Spacing,'\n');
                
                disp(Problem);
            end
        end
    
    disp('calculate over!!')
end
    
function Score = CalculateCoverage(algorithm_1, algorithm_2, problem, M_num, D_num, runtime, N)
    % ƴ�������ļ���
    file_1 = sprintf('%s_%s_M%d_D%d_%d.mat',algorithm_1,problem,M_num,D_num,runtime);
    file_2 = sprintf('%s_%s_M%d_D%d_%d.mat',algorithm_2,problem,M_num,D_num,runtime);
    % ��ȡ�ļ�
    data_1 = load(file_1);
    data_2 = load(file_2);
    % ��������
    Population_1 = getfield (data_1, 'result');
    Population_1 = Population_1(1,2);
    Population_2 = getfield (data_2, 'result');
    Population_2 = Population_2(1,2);
    % ��ȡĿ��ֵ
    PopObj_1 = [Population_1{1,1}.obj];
    PopObj_2 = [Population_2{1,1}.obj];
    PopObj_1 = reshape(PopObj_1, M_num, N)';
    PopObj_2 = reshape(PopObj_2, M_num, N)';
    Score = GetCoverage(PopObj_1, PopObj_2);
end

%% Coverageָ�꣺C(A,B)��ʾ����B�еĸ��屻����A֧��ĸ�����Ŀռ����B���и������Ŀ�ı���
function Score = GetCoverage(A, B)
    PopObj = B;
    PF = A;

    Domi = false(1,size(PopObj,1));
    for i = 1 : size(PF,1)
        Domi(sum(repmat(PF(i,:),size(PopObj,1),1)-PopObj<=0,2)==size(PopObj,2)) = true;
    end
    Score = sum(Domi) / size(PopObj,1);    
end

%% Spacingָ��: ���ָ�꣬��spacingΪ0�����ȳ̶����
function Score = GetSpacing(PopObj)
    Distance = pdist2(PopObj,PopObj,'cityblock');
    Distance(logical(eye(size(Distance,1)))) = inf;
    Score    = std(min(Distance,[],2));
end

%% PDָ�꣺������ָ�꣬PDֵԽ�󣬶�����Խ��
function Score = GetPD(PopObj)
    N = size(PopObj,1);
    C = false(N);
    C(logical(eye(size(C)))) = true;
    D = pdist2(PopObj,PopObj,'minkowski',0.1);
    D(logical(eye(size(D)))) = inf;
    Score = 0;
    for k = 1 : N-1
        while true
            [d,J] = min(D,[],2);
            [~,i] = max(d);
            if D(J(i),i) ~= -inf
                D(J(i),i) = inf;
            end
            if D(i,J(i)) ~= -inf
                D(i,J(i)) = inf;
            end
            P = any(C(i,:),1);
            while ~P(J(i))
                newP = any(C(P,:),1);
                if P == newP
                    break;
                else
                    P = newP;
                end
            end
            if ~P(J(i))
                break;
            end
        end
        C(i,J(i)) = true;
        C(J(i),i) = true;
        D(i,:)    = -inf;
        Score     = Score + d(i);
    end   
end

