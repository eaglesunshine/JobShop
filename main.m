function main(varargin)

    cd(fileparts(mfilename('fullpath')));
    addpath(genpath(cd));
    

%     %% ������
%     Global = GLOBAL('-algorithm',@MaOEACE2,'-problem',@ABZ6);
%     Global.Start();
%     
%     Global = GLOBAL('-algorithm',@MaOEACE,'-problem',@ABZ6);
%     Global.Start();

      
    %% ʵ���������
    N = 126;        % ��Ⱥ��С
    M = 5;          % Ŀ�����
    FT = 100;        % ��������
    Run_Num = 1;    % ���д���
    
    %% �Ա����⼯
    Problems_FT = {@FT06 @FT10 @FT20};  % 3����6x6~20x5
    Problems_YN = {@YN1 @YN2 @YN3 @YN4};   % 4����20x20~20x20
    Problems_ABZ = {@ABZ5 @ABZ6 @ABZ7 @ABZ8 @ABZ9};   % 5����10x10~20x15
    Problems_ORB = {@ORB01 @ORB02 @ORB03 @ORB04 @ORB05 @ORB06 @ORB07 @ORB08 @ORB09 @ORB10};   % 10����10x10~10x10
    Problems_SWV = {@SWV01 @SWV02 @SWV03 @SWV04 @SWV05 @SWV06 @SWV07 @SWV08 @SWV09 @SWV10 ...
                    @SWV11 @SWV12 @SWV13 @SWV14 @SWV15 @SWV16 @SWV17 @SWV18 @SWV19 @SWV20};   % 20����20x10~50x10
    Problems_LA = {@LA01 @LA02 @LA03 @LA04 @LA05 @LA06 @LA07 @LA08 @LA09 @LA10 ...
                   @LA11 @LA12 @LA13 @LA14 @LA15 @LA16 @LA17 @LA18 @LA19 @LA20 ...
                   @LA21 @LA22 @LA23 @LA24 @LA25 @LA26 @LA27 @LA28 @LA29 @LA30 ...
                   @LA31 @LA32 @LA33 @LA34 @LA35 @LA36 @LA37 @LA38 @LA39 @LA40 };   % 40����10x5~15x15
    
    %% �Ա��㷨
    Algorithms = {@MaOEACE @NSGAIII @MaOEACSS @NSGAIISDR @SRA};
    
    %% ����ʵ��
    Problems_All = {Problems_FT Problems_YN Problems_ABZ Problems_ORB Problems_SWV Problems_LA};
    
    for run_num = 1:Run_Num
        for idx = 1:size(Problems_All, 2)
            Problems = Problems_All{1,idx};
            for i = 1:size(Problems, 2)
                Problem = Problems{1,i};

                for j = 1:size(Algorithms, 2)
                    Algorithm = Algorithms{1,j};
                    Global = GLOBAL('-algorithm',Algorithm,'-problem',Problem, '-N', N, '-evaluation', N*FT, '-run', run_num);
                    Global.Start();
                end
            end
        end
    end
    
end     
