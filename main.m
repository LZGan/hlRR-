%%
clear all;
clc;
tic
%% Randomly generated data AD/NC
Data=1+9*rand(412,189);
label1=zeros(179,1);
label2=ones(233,1);
label=[label1;label2];
%% Data grouping and hypergraph construction
mPara.GraphType = 2;
mPara.IS_ProH=1;
mPara.mStarExp=1;
mPara.mRatio=0.1;
mPara.mProb=1;
numModal = 3; % MRI, PET, and CSF
fusion = 1;
mir=Data(:,1:93);
[H, W ] = DataGrouping( Data, mPara, fusion );
h1=H{1,1};
[Z1, E]=sparse_graph_LRR_release(mir',h1,0.1,0.1,0.1);
mir=mir'*Z1;
mir=mir';

%% pet
iPET = Data(:,94:186);
h2=H{1,2};
[Z2, E]=sparse_graph_LRR_release(iPET',h2,0.1,0.1,0.1);
iPET=iPET'*Z2;
iPET=iPET';

%%
%iCSF
iCSF = Data(:,187:189);
h3=H{1,3};
[Z3, E]=sparse_graph_LRR_release(iCSF',h3,0.1,0.1,0.1);
iCSF=iCSF'*Z3;
iCSF=iCSF';

%% mir+pet
mpdata = Data(:,1:186);
h4=H{1,4};
[Z4, E]=sparse_graph_LRR_release(mpdata',h4,0.1,0.1,0.1);
mpdata=mpdata'*Z4;
mpdata=mpdata';

%%  mir+csf

mcdata = [Data(:,1:93),Data(:,187:189)]
h5=H{1,5};
[Z5, E]=sparse_graph_LRR_release(mcdata',h5,0.1,0.1,0.1);
mcdata=mcdata'*Z5;
mcdata=mcdata';

%%  PET+CSF
pcdata = Data(:,94:189);
h6=H{1,6};
[Z6, ~]=sparse_graph_LRR_release(pcdata',h6,0.1,0.1,0.1);
pcdata=pcdata'*Z6;
pcdata=pcdata';

%% mir+pet+csf      
mcpdata = Data(:,1:189);
h7=H{1,7};
[Z7, E]=sparse_graph_LRR_release(mcpdata',h7,0.1,0.1,0.1);
mcpdata=mcpdata'*Z7;
mcpdata=mcpdata';
[Acc] = kfold(mir,iPET,iCSF,mpdata,mcdata,pcdata,mcpdata,label,10);