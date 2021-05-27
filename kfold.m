function [ACC,Sen,Spe,BAC,PPV,NPV,Fmeasure,Recall,precision,MCC,Gmeasure] = kfold(data1,data2,data3,data4,data5,data6,data7,label,K)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
data1=data1;
label=label;
k=K;
[m,n]=size(data1);
indices =crossvalind('Kfold',m,k);
for i=1:10 
  test=(indices==i); 
  train=~test; 
  data_train1=data1(train,:); 
  label_train1=label(train,:); 
  data_test1=data1(test,:); 
  label_test1=label(test,:); 
  
  test=(indices==i); 
  train=~test; 
  data_train2=data2(train,:); 
  label_train2=label(train,:); 
  data_test2=data2(test,:); 
  label_test2=label(test,:);
  
  test=(indices==i); 
  train=~test; 
  data_train3=data3(train,:); 
  label_train3=label(train,:); 
  data_test3=data3(test,:); 
  label_test3=label(test,:);
  
  test=(indices==i); 
  train=~test; 
  data_train4=data4(train,:); 
  label_train4=label(train,:); 
  data_test4=data4(test,:); 
  label_test4=label(test,:);
  
  test=(indices==i); 
  train=~test; 
  data_train5=data5(train,:); 
  label_train5=label(train,:); 
  data_test5=data5(test,:); 
  label_test5=label(test,:);
  
  test=(indices==i); 
  train=~test; 
  data_train6=data6(train,:); 
  label_train6=label(train,:); 
  data_test6=data6(test,:); 
  label_test6=label(test,:);
  
  test=(indices==i); 
  train=~test; 
  data_train7=data7(train,:); 
  label_train7=label(train,:); 
  data_test7=data7(test,:); 
  label_test7=label(test,:);
 
end
model1 = svmtrain(label_train1,data_train1,'-c 1 -t 2 ');
model2= svmtrain(label_train2,data_train2,'-c 1 -t 0  ');
model3 = svmtrain(label_train3,data_train3,'-c 1 -t 2 ');
model4 = svmtrain(label_train4,data_train4,'-c 1  -t 2');
model5 = svmtrain(label_train5,data_train5,'-c 1  -t 2');
model6 = svmtrain(label_train6,data_train6,'-c 1  -t 2');
model7 = svmtrain(label_train7,data_train7,'-c 1  -t 2');
[predict_label1, accuracy1, dec_values1] = svmpredict(label_test1,data_test1,model1);
[predict_label2, accuracy2, dec_values2] = svmpredict(label_test2,data_test2,model2);
[predict_label3, accuracy3, dec_values3] = svmpredict(label_test3,data_test3,model3);
[predict_label4, accuracy4, dec_values4] = svmpredict(label_test4,data_test4,model4);
[predict_label5, accuracy5, dec_values5] = svmpredict(label_test5,data_test5,model5);
[predict_label6, accuracy6, dec_values6] = svmpredict(label_test6,data_test6,model6);
[predict_label7, accuracy7, dec_values7] = svmpredict(label_test7,data_test7,model7);
p_label1=predict_label1;
p_label2=predict_label2;
p_label3=predict_label3;
p_label4=predict_label4;
p_label5=predict_label5;
p_label6=predict_label6;
p_label7=predict_label7;
sum=p_label1+p_label2+p_label3+p_label4+p_label5+p_label6+p_label7;
[m1,n1]=size(sum);
for i=1:m1
    if sum(i)>=4
        sum(i)=1;
    else
        sum(i)=0;
    end
end
[ACC,Sen,Spe,BAC,PPV,NPV,Fmeasure,Recall,precision,MCC,Gmeasure]=lmx_SenSpeAcc(sum,label_test1)
end

