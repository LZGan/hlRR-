function [H W] = HGConstruction(mPara)
%% To construct multiple hypergraph using different distance matrices
%% with each distance matrices corresponding to each modality

%% parameter setting
mDist = mPara.mDist;
IS_ProH = mPara.IS_ProH;
mStarExp = mPara.mStarExp; % The number of star expansion
mRatio = mPara.mRatio;
mProb = mPara.mProb;
nMod = 1; % The number of modalities or distance matrices
nObject = size(mDist{1,1},1); % The number of objects in the learning process
% nEdge = nObject*nMod; % The number of hyperedges
nEdge = nObject; % The number of hyperedges
% nEdge = nObject*nMod; % The number of hyperedges
% It is noted that the number of edges nEdge is determined by the way of hyperedge generation.
%%%%%%%%%%%%%%%%%

for iMod = 1:nMod
   iH=[]; iW=[];   
% H{iMod} = zeros(nObject,nEdge); % the incidence matrices for all modalities
% W{iMod} = ones(nEdge,1);
iEdge = 0;

    distM = mDist{iMod,1}; % the distance marix in current modality
    aveDist =mean(mean(distM));% the mean distancein current modaltiy
    
    for iObject = 1:nObject
                iEdge = iEdge + 1;
                vDist = distM(:,iObject)';
                [values orders] = sort(vDist,'ascend');
                if mPara.GraphType == 1  % star expansion
                        orders2 = orders(1:mStarExp);
                        if isempty(find(orders2==iObject))
                            values(mStarExp)=0;
                            orders(mStarExp)=iObject;
                        end
                        for iNeighbor = 1:mStarExp
                                if IS_ProH == 0 % if it is not pro H
%                                     H{iMod}(orders(iNeighbor),iEdge) = 1;
                                    iH(orders(iNeighbor),iEdge) = 1;
                                else
%                                     H{iMod}(orders(iNeighbor),iEdge)  = exp(-values(iNeighbor)^2/(mProb*aveDist)^2);
                                    iH(orders(iNeighbor),iEdge) = exp(-values(iNeighbor)^2/(mProb*aveDist)^2);
                                end
                        end
                elseif mPara.GraphType == 2% distance-based
                        threshold = mRatio*aveDist; % the threshold for distance-based hyperedge construction
                        for iNeighbor = 1:nObject
                                if vDist(iNeighbor) < threshold
                                       if IS_ProH == 0 % if it is not pro H
%                                                 H{iMod}(iNeighbor,iEdge) = 1;
                                                iH(iNeighbor,iEdge) = 1;
                                       else
%                                                 H{iMod}(iNeighbor,iEdge)  = exp(-vDist(iNeighbor)^2/(mProb*aveDist)^2);
                                                iH(iNeighbor,iEdge)  = exp(-vDist(iNeighbor)^2/(mProb*aveDist)^2);
                                       end
                                end
                        end
                end
    end
    
    H{iMod} = iH;
    W{iMod} = ones(size(iH,2),1);
    
end