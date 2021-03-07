function [PopObj] = Normalization(PopObj)
    [N,~]=size(PopObj);
     Znad=diag(PopObj(SelectCornerSolutions(PopObj),:))';
     Zmin= min(PopObj,[],1);
     newznad=Znad-Zmin;
     newznad(newznad<1)=1;
     PopObj = (PopObj-repmat(Zmin,N,1))./(repmat(newznad,N,1));


%     Zmin   = min(PopObj,[],1);
%     Zmax   = max(PopObj,[],1);
%     PopObj = (PopObj-repmat(Zmin,size(PopObj,1),1))./repmat(Zmax-Zmin,size(PopObj,1),1);
end