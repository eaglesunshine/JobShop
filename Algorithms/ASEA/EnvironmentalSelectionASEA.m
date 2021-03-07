function [Population,z,znad] = EnvironmentalSelectionASEA(Population,W,N,z,znad,theta)
% Environmental selection of ASEA (without line 17 and 18)
% Environmental selection of ASEA+ (with line 17 and 18)

%% Constraint violation measurement
CV = sum(max(0,Population.cons),2);
fes = find(CV == 0); % indexes of fesible solutions

%% Normalization
[PopObj,z,znad] = NormalizationWithConstraints(Population.objs,fes,z,znad); % update z and znad using feasible solutions

%% Convergence and diversity measurement, subpopulation partition
[d1,d2,class] = measurement(PopObj,W);

%% Selection
selected = adaptiveSort(PopObj,CV,W,d1,d2,class,N,theta);
% selectedPro = adaptiveProSort(PopObj,CV,class,selected,d1,W,N,theta); % selection for irregular MaOPs
% selected = [selected; selectedPro]; % for irregular MaOPs
Population = Population(selected);
    
end

function [d1,d2,class] = measurement(PopObj,W)

d1 = sqrt(sum(PopObj.^2,2)); % the convergence of solutions, 2N*1
Cosine = 1 - pdist2(PopObj,W,'cosine'); % cosine values between each solution and each reference vector, 2N*W
[~,class] = max(Cosine,[],2); % indexes of the associted reference weights of solutions, 2N*1
d2 = zeros(size(PopObj,1),1);
for i = 1 : size(W,1)
    C = find(class==i);
    d2(C) = d1(C).*sqrt(1 - Cosine(C,i).^2); % the diversity of solutions, 2N*1
%     d2(C) = Cosine(C,i); % the diversity of solutions, angle method, 2N*1
end
end

function selected = adaptiveSort(PopObj,CV,W,d1,d2,class,N,theta)

asso1 = class; % class need to be changed 
selected = []; % indexes of selected solutions

while numel(selected)<N
    primSelected = []; % indexes of selected solutions in the following loop
    for k = 1:size(W,1) % traverse reference vectors
        current1 = find(asso1 == k & CV == 0); % indexes of fesible solutions
        current2 = find(asso1 == k & CV ~= 0); % indexes of infesible solutions        
        
        if ~isempty(current1) % have fesible solutions
            p = numel(current1);
            [~,ind] = sort(d1(current1)); % convergence-based sorting
            current1 = current1(ind); 
            
            r = min(ceil((exp(1-1./theta)+0.0001)*p),p); % equation 9
%             r = 1; % equation 11
%             r = p; % equation 12
%             r = min(ceil((1./theta)*p),p); % equation 13 
%             r = min(ceil(log((theta^0.5).*(exp(1)-1)+1)*p),p); % equation 14
            
            current1=current1(1:r); % indexes of extracted solutions
            % optional Pareto dominant selection in prior  
            if numel(current1) > 1
                NDcurrent1 = P_sort(PopObj(current1,:),'first')==1;
                [~,ind] = find(NDcurrent1==1);
                current1 = current1(ind);
            end
            
            [~,pos]=min(d2(current1));
            if numel(pos)>1 % randomly select a solution among these tied for the first level
                randIndex = randi(numel(pos));
            else
                randIndex = 1;
            end        
            primSelected = [primSelected; current1(pos(randIndex))]; 
        
        elseif ~isempty(current2) % do not have fesible solutions
            ind = find(CV(current2) == min(CV(current2))); % constraint violation-based sorting 
            if numel(ind)>1
                randIndex = randi(numel(ind));
            else
                randIndex = 1;
            end
            primSelected = [primSelected; current2(ind(randIndex))];
        end   
    end % for k=1:NW
    
    % similar with "randomly select a number of solutions from the last included level"
    if numel(primSelected) > N - numel(selected) 
        randSeed = randperm(numel(primSelected));
        primSelected = primSelected(randSeed(1:N - numel(selected)));
    end
    selected = [selected; primSelected];
    asso1(primSelected) = 0; % delete selected solutions from class
end
end

function selectedPro = adaptiveProSort(PopObj,CV,class,selected,d1,W,N,theta)
NDSelected = P_sort(PopObj(selected,:),'first')==1;
[~,ind] = find(NDSelected==1);
proVec = unique(class(selected(ind'))); % indexes of promising reference vectors
asso2 = class; % class need to be changed
minAngleCos = 1 - pdist2(W(1,:),W(2,:),'cosine'); % angle cosine between nearset reference vectors

selectedPro = [];
for i = 1:numel(proVec)
    selectedProVec = find(class(selected) == proVec(i));
    selectedPro = [selectedPro; selectedProVec]; % indexes of selected solutions in promising subpopulation
end
CURRENT = [];
for i = 1:numel(proVec) 
    asso2(selectedPro) = 0;
    current = find(asso2==proVec(i));
    CURRENT = [CURRENT; current]; % indexes of solutions in promising subpopulations that can be selecte
end

k = numel(selectedPro); % number of selected solutions in promising subpopulation
NN = N - numel(proVec); % number of solutions need to be selected

if numel(CURRENT) > NN
    while (numel(selectedPro) - k) < NN % while the following selected solutions are less than NN
        primSelected = []; % indexes of selected solutions in the following loop
        for i = 1:numel(proVec) % traverse promising subpopulations
            asso2(selectedPro) = 0;
            current1 = find(asso2==proVec(i) & CV==0); % indexes of fesible solutions
            current2 = find(asso2==proVec(i) & CV~=0); % indexes of infesible solutions
            
            if ~isempty(current1) % have fesible solutions
                [~,ind] = sort(d1(current1));  % convergence-based sorting
                current1 = current1(ind); % indexes of solutions sorting according to convergence
                p = numel(current1);
               
                r = min(ceil((exp(1-1./theta)+0.0001)*p),p); % equation 9
%                 r = 1; % equation 11
%                 r = p; % equation 12
%                 r = min(ceil((1./theta)*p),p); % equation 13
%                 r = min(ceil(log((theta^0.5).*(exp(1)-1)+1)*p),p); % equation 14
                
                current1 = current1(1:r); % indexes of extracted solutions
                
                % angle cosines between proVec i and other promising reference vectors
                cosTheta = 1 - pdist2(W(proVec(i),:),W(proVec,:),'cosine');
                ind = find(cosTheta==minAngleCos); % find the neighborhood of proVec i
                
                if ~isempty(ind) % if have neighbor promising reference vectors
                    neighborVec = [proVec(i); proVec(ind')]; % indexes of reference vectors in neighborhood, include itself
                    POS=[];
                    for j = 1:numel(neighborVec)
                        pos = find(class(selectedPro) == neighborVec(j));
                        POS = [POS; selectedPro(pos)]; % indexs of selected solutions in neighborhood
                    end
                    
                else % if do not have neighbor promising reference vectors
                    POS = find(class(selectedPro) == proVec(i));
                end
                
                % angle cosines between solutions in subpopulation i and selected solutions in neighborhood or proVec i
                cosTheta = 1 - pdist2(PopObj(current1,:),PopObj(POS,:),'cosine');
                d2 = max(cosTheta'); % diversity measurement*
                [~,ind] = max(d2); % diversity-based sorting
                primSelected = [primSelected; current1(ind)];
                
            elseif ~isempty(current2) % do not have fesible solutions
                ind = find(CV(current2)==min(CV(current2))); % constraint violation-based sorting
                if numel(ind)>1
                    randIndex = randi(numel(ind));
                else
                    randIndex = 1;
                end
                primSelected = [primSelected; current2(ind(randIndex))];
            end
        end
        
        if (numel(selectedPro) + numel(primSelected)) > (k + NN)
            randSeed = randperm(numel(primSelected));
            primSelected = primSelected(randSeed(1:(k + NN - numel(selectedPro))));
        end        
        selectedPro = [selectedPro; primSelected];
    end
else
    selectedPro = [selectedPro; CURRENT];
end
selectedPro(1:k) = []; % delete the indexes of non-dominate solutions from selectedPro
end