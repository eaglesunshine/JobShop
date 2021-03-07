function [PopObj,znad,z] = Normalization(PopObj)
    [N,~]=size(PopObj);
     znad=diag(PopObj(SelectCornerSolutions(PopObj),:))';
     z= min(PopObj,[],1);
     newznad=znad-z;
      newznad(newznad<1)=1;
     PopObj = (PopObj-repmat(z,N,1))./(repmat(newznad,N,1));
end