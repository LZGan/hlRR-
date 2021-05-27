function [ACC,Sen,Spe,BAC,PPV,NPV,Fmeasure,Recall,precision,MCC,Gmeasure]=lmx_SenSpeAcc(prevLabel,trueLabel)
% function [ACC,Sen,Spe]=lmx_SenSpeAcc(prevLabel,trueLabel)
target=trueLabel;
prel=prevLabel;
pospos=find(target==0);  % number of real positive sample in data = TP+FN
posneg=find(target==1); % number of real negative sample in data = TN+FP
num_pos=length(pospos);  % = TP+FN
num_neg=length(posneg);  % = TN+FP

TP=sum(prel(pospos)==0);
FN=num_pos-TP;
TN=sum(prel(posneg)==1);
FP=num_neg-TN;

Sen=100*TP/(TP+FN);
Spe=100*TN/(TN+FP);
BAC=(Sen+Spe)/2;  % Balanced Accuracy, BAC
PPV=100*TP/(TP+FP);  % Positive Predictive Value, PPV
NPV=100*TN/(TN+FN);  % Negative Predictive Value, NPV
%ACC=100*sum(prevLabel==trueLabel)/(num_pos+num_neg);
ACC=(TP+TN)/(TP+TN+FP+FN);
Recall=TP/(TP+FN);
precision=TP/(TP+FP);
Gmeasure=(2*Sen*(1-Spe))/(Sen+(1-Spe));
MCC = ( TP*TN-FP*FN ) / sqrt( (TP+FP)*(TP+FN)*(TN+FP)*(TN+FN) ); %Matthews Correlation Coefficient (MCC): 
Fmeasure=(2*Sen*PPV)/(Sen+PPV);

