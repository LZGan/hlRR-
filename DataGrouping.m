function [ H, W ] = DataGrouping( Data, mPara, fusion )

% Find MRI 
iMRI = Data(:,1:93);
mPara.mDist{1,1} = dist(iMRI');
initialW = [];
[mriH initialW] = HGConstruction(mPara);
W{1} = initialW{1,1};
H1 = mriH{1,1};
aa=1;

% Find PET 
iPET = Data(:,94:186);
[m,n]=find(isnan(iPET)) ;
iPET(m,:)=[] ;
mPara.mDist{1,1} = dist(iPET');
[petH initialW] = HGConstruction(mPara);
W{2} = initialW{1,1};
H2 = petH{1,1};

% Find CSF 
iCSF = Data(:,187:end);
[m,n]=find(isnan(iCSF)) ;
iCSF(m,:)=[] ;
mPara.mDist{1,1} = dist(iCSF');
initialW=[];
[csfH initialW] = HGConstruction(mPara);
W{3} = initialW{1,1};
H3 = csfH{1,1};

%Find MRi+pet
mpdata = Data(:,1:186);
[m,n]=find(isnan(mpdata)) ;
mpdata(m,:)=[] ;
mPara.mDist{1,1} = dist(mpdata');
initialW=[];
[mpH initialW] = HGConstruction(mPara);
W{4} = initialW{1,1};
H4 = mpH{1,1};

%Find Mri+csf
mcdata = [Data(:,1:93),Data(:,187:189)]
[m,n]=find(isnan(mcdata)) ;
mcdata(m,:)=[] ;
mPara.mDist{1,1} = dist(mcdata');
initialW=[];
[mcH initialW] = HGConstruction(mPara);
W{5} = initialW{1,1};
H5 = mcH{1,1};

%Find pet+csf
pcdata = Data(:,94:189);
[m,n]=find(isnan(pcdata)) ;
pcdata(m,:)=[] ;
mPara.mDist{1,1} = dist(pcdata');
initialW=[];
[pcH initialW] = HGConstruction(mPara);
W{6} = initialW{1,1};
H6= pcH{1,1};

%Find mri+pet+csf
mcpdata = Data(:,1:189);
[m,n]=find(isnan(mcpdata)) ;
mcpdata(m,:)=[] ;
mPara.mDist{1,1} = dist(mcpdata');
initialW=[];
[dH initialW] = HGConstruction(mPara);
W{7} = initialW{1,1};
H7= dH{1,1};

if fusion==1 % use 3 combination way, MRI, PET, CSF
    H{1} = H1;
    H{2} = H2;
    H{3} = H3; %[H1 H2 H3];
    H{4} = H4;
    H{5} = H5;
    H{6} = H6;
    H{7} = H7;
end
if fusion==2  % use 6 combination way, MRI, PET, CSF, MRI+PET, MRI+CSF, MRI+PET+CSF
    H=[H4 H5 H6];
end
if fusion==3  % use 6 combination way, MRI, PET, CSF, MRI+PET, MRI+CSF, MRI+PET+CSF
    H=[H1 H2 H3 H4 H5 H6 ];
end


end

