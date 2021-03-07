function MatingPool = MatingSelection(CA,DA,N)
% The mating selection of one-by-one EA
         CA_con=sum(max(0,CA.cons),2);
         temp=CA_con>0;
         CA_con(temp)=10;
         PopObj_CA=CA.objs;
         %PopObj_CA = Normalization(PopObj_CA);
         [FrontNo_CA,~] = NDSort(PopObj_CA,N);
  
        DA_con=sum(max(0,DA.cons),2);
        temp=DA_con>0;
        DA_con(temp)=10;
         PopObj_DA=DA.objs;
         %PopObj_DA = Normalization(PopObj_DA);
        [FrontNo_DA,~] = NDSort(PopObj_DA,N);
                                                                    
        HM=[CA,DA];
         PopObj_HM=HM.objs;
         %PopObj_HM = Normalization(PopObj_HM);
        [FrontNo_HM,~] = NDSort(PopObj_HM,(2*N));
        
        Pc=length(find(find(FrontNo_HM==1)<=N))/(2*N);
        Pd=length(find(find(FrontNo_HM==1)>N))/(2*N);
        P1=[];
        P2=[];
        while length([P1 P2])<N
             if Pc>Pd
                 index=TournamentSelection(2,1,CA_con,FrontNo_CA);
                 %index=TournamentSelection(2,1,FrontNo_CA,CA_con);
                 P1=[P1 CA(index)];
            else
                 index=TournamentSelection(2,1,DA_con,FrontNo_DA);
                 %index=TournamentSelection(2,1,FrontNo_DA,DA_con);
                 P1=[P1 DA(index)];
            end
            if rand()<Pc
                 index=TournamentSelection(2,1,CA_con,FrontNo_CA);
                 %index=TournamentSelection(2,1,FrontNo_CA,CA_con);
                  P2=[P2 CA(index)];
            else
                 index=TournamentSelection(2,1,DA_con,FrontNo_DA);
                 %index=TournamentSelection(2,1,FrontNo_DA,DA_con);
                 P2=[P2 DA(index)];
            end
        end
        MatingPool=[P1 P2];

end