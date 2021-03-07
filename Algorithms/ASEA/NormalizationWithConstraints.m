function [PopObj,z,znad] = NormalizationWithConstraints(PopObj,fes,z,znad)
% Normalize the population and update the ideal point and the nadir point
% using feasible solutions

PopObjFes = PopObj(fes,:);
[NAll,~] = size(PopObj);
[Nfes,M] = size(PopObjFes);

%% Update the ideal point
if Nfes<M
    z = min(PopObj,[],1);
else
    z = min(z,min(PopObjFes,[],1));
end

%% Update the nadir point
% Identify the extreme points
W = zeros(M) + 1e-6;
W(logical(eye(M))) = 1;
ASF = zeros(Nfes,M);
for i = 1 : M
    ASF(:,i) = max(abs((PopObjFes-repmat(z,Nfes,1))./(repmat(znad-z,Nfes,1)))./repmat(W(i,:),Nfes,1),[],2);
end
[~,extreme] = min(ASF,[],1);
% Calculate the intercepts
%
if Nfes<M
    znad = max(PopObj,[],1);
else
    Hyperplane = (PopObjFes(extreme,:)-repmat(z,M,1))\ones(M,1);
    a = (1./Hyperplane)' + z;
    if any(isnan(a)) || any(a<=z)
        a = max(PopObjFes,[],1);
    end
    znad = a;
end
%

%% Normalize the population
if Nfes<M
    PopObj = (PopObj-repmat(z,NAll,1))./(repmat(znad-z,NAll,1));
else
    PopObj = (PopObj-repmat(z,NAll,1))./(repmat(znad-z,NAll,1));
end