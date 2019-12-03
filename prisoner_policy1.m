%prisoner's dilemma
alpha = 0.002; %learning factor
m = 3000; %iteration time
%[pc1,pc2,p1_mean,p3_mean] = deal(rand(1,1));
%[pd1,pd2,p2_mean,p4_mean] = deal(1-pc1); %only use once
%policy initialization (manually decide the prob
% p =0.5;
[pc1,pc2,pd1,pd2] = deal(0.5);
% or pc1 = rand(1,1);
game = 1; %variable here,1 means prisoner's dilemma, 2 means coins and 3 means rock-paper-scissors
[R1,R2] = rewardmatrix(game);
x1 = [];   %empty list to store the output of probability
x2 = [];
y1 = [];
y2 = [];
for i = 1:m
[pc1,pd1,pc2,pd2] = policy_update(alpha,R1,R2,pc1,pd1,pc2,pd2);
x1 = [x1;pc1];
x2 = [x2;pd1];
y1 = [y1;pc2];
y2 = [y2;pd2];
end

%% Plot
figure(1);
a = 1:3000
plot(a,x)
hold on
plot(a,y)
hold off
title('policy update')
xlabel('number of action');
ylabel('prob of defect for player');

%need to solve the problem that matla round small number into zero
%list = [pc1*pc2,pc1*pd2;pd1*pc2,pd1*pd2]
p1 = [pc1,pd1]
p2 = [pc2,pd2]
list = list2(p1,p2)
val = value2(R1,list)
val2 = value2(R2,list)

function [pc1,pd1,pc2,pd2] = policy_update(alpha,R1,R2,pc1,pd1,pc2,pd2)
p1_a = choose_a(pc1,pd1)
p2_a = choose_a(pc2,pd2)
r1 = R1(p1_a,p2_a);
r2 = R2(p1_a,p2_a);
if (p1_a == 1)
    pc1 = pc1 + alpha * r1 * (1 - pc1);
    pd1 = pd1 - alpha * r1 * pd1;
else 
    %player1 defect 
    pd1 = pd1 + alpha * r1 * (1 - pd1);
    pc1 = pc1 - alpha * r1 * pc1;
end
if (p2_a == 1)
  %player2 cooperate 
   pc2 = pc2 + alpha * r2 * (1 - pc2);
   pd2 = pd2 - alpha * r2 * pd2;  
else
    %player2 defect
   pc2 = pc2 - alpha * r2 * pc2;
   pd2 = pd2 + alpha * r2 * (1 - pd2);
end
end

function [R1, R2]= rewardmatrix(game)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if game == 1;
    R1 = [5,0;10,1];
    R2 =R1.';
elseif game == 2;
    R1 =[1,-1;-1,1];
    R2 = -R1;
else 
    R1 =[0,-1,1;1,0,-1;-1,1,0]
    R2 = -R1;
end
end

function action = choose_a(p1,p2)
    if ((p1 + p2)~= 1)
        p = p1 + p2;
        p1 = p1./p;
        p2 =p2./p
        action = randsrc(1,1,[1 2 ; p1 p2])
    else 
        action = randsrc(1,1,[1 2 ; p1 p2])
    end
       

end



%list = [pc1*pc2,pc1*pd2;pc2*pd1,pd1*pd2]



%value1 = R1(1,1) * pc1 * pc2 + R1(1,2) * pc1 * pd2 + R1(2,1) * pd1 * pc2 + R1(2,2) * pd1 * pd2
%value2 = R2(1,1) * pc1 * pc2 + R2(1,2) * pc1 * pd2 + R2(2,1) * pd1 * pc2 + R2(2,2) * pd1 * pd2






    


   
 
















       
   






