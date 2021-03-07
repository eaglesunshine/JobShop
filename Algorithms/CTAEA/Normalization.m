function PopObj = Normalization(PopObj)
    Zmin   = min(PopObj,[],1);
    Zmax   = max(PopObj,[],1);
    PopObj = (PopObj-repmat(Zmin,size(PopObj,1),1))./repmat(Zmax-Zmin,size(PopObj,1),1);
end