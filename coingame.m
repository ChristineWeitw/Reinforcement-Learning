# FUNCTION
function [list] = list2(player1,player2)
%LIST Summary of this function goes here
%   this is to generate the prob matrix
list = player1.' * player2

end

function [val] = value2(R,list)
%VALUE Summary of this function goes here
%list1 = [pc1*pc2,pc1*pd2;pd1*pc2,pd1*pd2]
%list2 = [pr1*pr2,pr1*pp2,pr1*ps2,pp1*pr2,pp1*pp2,pp1*ps2,ps1*pr2,ps1*pp2,ps1*ps2]
% make a loop for generate the list
val = 0;
for i = 1:length(R)
   for j = 1: length(R)
       val = val + R(i,j) * list(i,j)
   end
end 
end
      
 
    

%if (game == 1 || game == 2)



# POLICY 1

alpha = 0.001;
m = 10000;
[pc1,pc2] = deal(rand(1,1));
[pd1,pd2] = deal(1-pc1);
game = 2;
[R1,R2] = rewardmatrix(game);
x1 = [];
x2 = [];



for i = 1:m
[pc1,pd1,pc2,pd2] = policy_update(alpha,R1,R2,pc1,pd1,pc2,pd2);
x1 = [x1;pc1];
x2 = [x2;pd1];
end
x = [x1,x2]
figure(2);
a = 1:m;
plot(a,x)
title('player1 -1st policy update')
xlabel('number of action');
ylabel('probability of action');
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
%for game 1: 1 means cooperate while 2 means defect
%for game 2: 1 means head while 2 means tail 
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



# POLICY 2


alpha = 0.002;
m = 30000;
%[pc1,pd1,pc2,pd2,p1_mean,p2_mean,p3_mean,p4_mean]=deal(0.5); 
%only use once
[pc1,pc2,p1_mean,p3_mean] = deal(rand(1));
[pd1,pd2,p2_mean,p4_mean] = deal(1 - pc1);
game = 2;
[R1,R2] = rewardmatrix(game);
x1_2 = [];
x2_2 = [];
x3_2 = [];
x4_2 = [];

for i = 1:m
p1_mean = mean2(p1_mean,alpha,pc1);
p2_mean = mean2(p2_mean,alpha,pd1);
p3_mean = mean2(p3_mean,alpha,pc2);
p4_mean = mean2(p4_mean,alpha,pd2);
[pc1,pd1,pc2,pd2] = policy_update2(alpha,R1,R2,p1_mean,p2_mean,p3_mean,p4_mean,pc1,pd1,pc2,pd2);
x1_2 = [x1_2;pc1];
x2_2 = [x2_2;pd1];
x3_2 = [x3_2;pc2];
x4_2 = [x4_2;pd2];
end

   
p1 = [pc1,pd1]
p2 = [pc2,pd2]
list = list2(p1,p2)
val = value2(R1,list)
val2 = value2(R2,list)

xplayer1 = [x1_2,x2_2]
figure(1);
steps1 = 1:m;
plot(steps1,xplayer1)
title('policy 2 for player 1')
xlabel('the number of action');
ylabel('probability change');

xplayer2 = [x3_2,x4_2]
figure(2);
steps2 = 1:m;
plot(steps2,xplayer2)
title('policy 2 for player 2')
xlabel('the number of action');
ylabel('probability change');

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

function p_mean = mean2(p_mean,alpha,prob)
p_mean = p_mean + (alpha)* (prob - p_mean)
end

function [pc1,pd1,pc2,pd2] = policy_update2(alpha,R1,R2,p1_mean,p2_mean,p3_mean,p4_mean,pc1,pd1,pc2,pd2)
p1_a = choose_a(pc1,pd1);
p2_a = choose_a(pc2,pd2);
r1 = R1(p1_a,p2_a);
r2 = R2(p1_a,p2_a);
%p1_mean = mean2(p1_mean,alpha,pc1);
%p2_mean = mean2(p2_mean,alpha,pd1);
%p3_mean = mean2(p3_mean,alpha,pc2);
%p4_mean = mean2(p4_mean,alpha,pd2);
if (p1_a == 1)
  %player2 cooperate
    pc1 = pc1 + alpha * r1 * (1 - pc1) + alpha * (p1_mean - pc1);
    pd1 = pd1 - alpha * r1 * pd1 + alpha * (p2_mean- pd1);
else
    %player2 defect
    pd1 = pd1 + alpha * r1 * (1 - pd1) + alpha * (p2_mean - pd1);
    pc1 = pc1 - alpha * r1 * pc1 + alpha * (p1_mean - pc1);
end
if (p2_a == 1)
  %player2 cooperat
    pc2 = pc2 + alpha * r2 * (1 - pc2) + alpha * (p3_mean - pc2);
    pd2 = pd2 - alpha * r2 * pd2 + alpha * (p4_mean- pd2);
else
    %player2 defect
    pd2 = pd2 + alpha * r2 * (1 - pd2) + alpha * (p4_mean - pd2);
    pc2 = pc2 - alpha * r2 * pc2 + alpha * (p3_mean - pc2);
end
end

