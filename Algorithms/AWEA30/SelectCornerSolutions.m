function Rc=SelectCornerSolutions(PopObj)  
    [~,M]=size(PopObj);
    W = zeros(M) + 1e-6;
    W(logical(eye(M))) = 1;
     normP  = sqrt(sum(PopObj.^2,2));
    Cosine = 1 - pdist2(PopObj,W,'cosine');
    d2     = repmat(normP,1,size(W,1)).*sqrt(1-Cosine.^2);
    [~,Rc] = min(d2);
    [rows,~]=size(d2);
    if rows==1
        Rc=ones(1,M);
    end
end

