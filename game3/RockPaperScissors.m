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
      
 
    
# POLICY 1
%if (game == 1 || game == 2)%Rock Paper Scissors
alpha = 0.002; %discount factor
m = 30000; %iteration time
p = 1:3
[pr1,pp1,ps1] = prob_distribution2(p);
[pr2,pp2,ps2] = prob_distribution2(p);

game = 3; %variable here,1 means prisoner's dilemma, 2 means coins and 3 means rock-paper-scissors
[R1,R2] = rewardmatrix(game);
g3_p1_rock = [];   %empty list to store the output of probability
g3_p1_paper = [];
g3_p1_scissors = [];
g3_p2_rock = [];
g3_p2_paper = [];
g3_p2_scissors = [];

for i = 1:m
[pr1,pp1,ps1,pr2,pp2,ps2] = g3_policy_update(alpha,R1,R2,pr1,pp1,ps1,pr2,pp2,ps2);
g3_p1_rock = [g3_p1_rock;pr1];
g3_p1_paper = [g3_p1_paper;pp1];
g3_p1_scissors = [g3_p1_scissors;ps1]
g3_p2_rock = [g3_p2_rock;pr2];
g3_p2_paper = [g3_p2_paper;pp2];
g3_p2_scissors = [g3_p2_scissors;ps2];
end

figure(2);
time_step = 1:3000
plot(time_step,g3_p2_rock)
hold on
plot(time_step,g3_p2_paper)
hold on
plot(time_step,g3_p2_scissors)
hold off
title('player 2 - 1st policy update')
xlabel('number of action');
ylabel('probability');

function [p1,p2,p3,p1_mean,p2_mean,p3_mean] = prob_distribution2(p)
%UNTITLED2 Summary of this function goes here
%   the sum of the prob is 1
p = rand(1,length(p));
p = p./sum(p);
[p1,p1_mean] = deal(p(1));
[p2,p2_mean] = deal(p(2));
[p3,p3_mean] = deal(p(3));
end


function [action]= choose_a2(p1,p2,p3)
if (p1+p2+p3~= 1)
    temp = p1 + p2 + p3;
    p1 = p1./temp;
    p2 = p2./temp;
    p3 = p3./temp;
    action = randsrc(1,1,[1 2 3 ; p1 p2 p3]);
else
    action = randsrc(1,1,[1 2 3 ; p1 p2 p3]);


end
end


%% policy update by the 1st algorithm 
function [pr1,pp1,ps1,pr2,pp2,ps2] = g3_policy_update(alpha,R1,R2,pr1,pp1,ps1,pr2,pp2,ps2)
p1_action = choose_a2(pr1,pp1,ps1);
p2_action = choose_a2(pr2,pp2,ps2);
r1 = R1(p1_action,p2_action);
r2 = R2(p1_action,p2_action);
if (p1_action == 1)
    pr1 = pr1 + alpha * r1 * (1 - pr1);
    pp1 = pp1 - alpha * r1 * pp1;
    ps1 = ps1 - alpha * r1 * ps1;
elseif (p1_action == 2) 
    %player1 paper 
    pp1 = pp1 + alpha * r1 * (1 - pp1);
    pr1 = pr1 - alpha * r1 * pr1;
    ps1 = ps1 - alpha * r1 * ps1;
else 
    ps1 = ps1 + alpha * r1 * (1 - ps1);
    pr1 = pr1 - alpha * r1 * pr1;
    pp1 = pp1 - alpha * r1 * pp1;
end

if (p2_action == 1)
    pr2 = pr2 + alpha * r2 * (1 - pr2);
    pp2 = pp2 - alpha * r2 * pp2;
    ps2 = ps2 - alpha * r2 * ps2;
elseif (p2_action == 2) 
    %player1 paper 
    pp2 = pp2 + alpha * r2 * (1 - pp2);
    pr2 = pr2 - alpha * r2 * pr2;
    ps2 = ps2 - alpha * r2 * ps2;
else 
    ps2 = ps2 + alpha * r2 * (1 - ps2);
    pr2 = pr2 - alpha * r2 * pr2;
    pp2 = pp2 - alpha * r1 * pp2;
end

end

%for game 1: 1 means cooperate while 2 means defect
%for game 2: 1 means head while 2 means tail 


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

%Rock Paper Scissors
alpha = 0.004; %discount factor
m = 30000; %iteration time5
p = 1:3;


[pr1,pp1,ps1,pr1_mean,pp1_mean,ps1_mean] = prob_distribution2(p);
[pr2,pp2,ps2,pr2_mean,pp2_mean,ps2_mean] = prob_distribution2(p);

g3_p2_rock = [];   %empty list to store the output of probability
g3_p2_paper = [];
g3_p2_scissors = [];
g3_p1_rock_policy2 = [];
g3_p1_paper_policy2 = [];
g3_p1_scissors_policy2 = [];
 
for i = 1:m
    game = 3;
    [R1,R2] = rewardmatrix(game);
    pr1_mean = mean2(pr1_mean,alpha,pr1);
    pp1_mean = mean2(pp1_mean,alpha,pp1);
    ps1_mean = mean2(ps1_mean,alpha,ps1);
    pr2_mean = mean2(pr2_mean,alpha,pr2);
    pp2_mean = mean2(pp2_mean,alpha,pp2);
    ps2_mean = mean2(ps2_mean,alpha,ps2);

    [pr1,pp1,ps1,pr2,pp2,ps2] = g3_policy_update3(alpha,R1,R2,pr1_mean,pp1_mean,ps1_mean,pr2_mean,pp2_mean,ps2_mean,pr1,pp1,ps1,pr2,pp2,ps2)
    g3_p2_rock = [g3_p2_rock;pr2];   %empty list to store the output of probability
    g3_p2_paper = [g3_p2_paper;pp2];
    g3_p2_scissors= [g3_p2_scissors;ps2];
    %empty list to store the output of probability

end   
%else
   %[pr1,pp1,ps1,pr2,pp2,ps2,g3_p1_rock_policy2,g3_p1_paper_policy2,g3_p1_scissor_policy2] = g3_policy_update(alpha,R1,R2,pr1,pp1,ps1,pr2,pp2,ps2);
%end
    
p1 = [pr1,pp1,ps1]
p2 = [pr2,pp2,ps2]
list = list2(p1,p2)
val = value2(R1,list)
val2 = value2(R2,list)   
        
    
            
            
         
  



%% figure
figure(2);
x1 = 1:m;
y1 = [g3_p2_rock]
y2 = [g3_p2_paper]
y3 = [g3_p2_scissors];
plot(x1,y1)
hold on
plot(x1,y2)
hold on
plot(x1,y3)
hold off
ylim([0,1])
title('player 2 - 2nd policy update -game3')
xlabel('number of action');
ylabel('probability of action');


function [p1,p2,p3,p1_mean,p2_mean,p3_mean] = prob_distribution2(p)
%UNTITLED2 Summary of this function goes here
%   the sum of the prob is 1
p = rand(1,length(p));
p = p./sum(p);
[p1,p1_mean] = deal(p(1));
[p2,p2_mean] = deal(p(2));
[p3,p3_mean] = deal(p(3));
end


function [action]= choose_a2(p1,p2,p3)
if (p1+p2+p3~= 1)
    temp = p1 + p2 + p3;
    p1 = p1./temp;
    p2 = p2./temp;
    p3 = p3./temp;
    action = randsrc(1,1,[1 2 3 ; p1 p2 p3]);
else
    action = randsrc(1,1,[1 2 3 ; p1 p2 p3]);


end
end

%% calculate the expected probability of action

function p_mean = mean2(p_mean,alpha,prob)
p_mean = p_mean + alpha * (prob - p_mean);
end

%% policy update by the 1st algorithm 

function [pr1,pp1,ps1,pr2,pp2,ps2] = g3_policy_update(alpha,R1,R2,pr1,pp1,ps1,pr2,pp2,ps2)
p1_action = choose_a2(pr1,pp1,ps1);
p2_action = choose_a2(pr2,pp2,ps2);
r1 = R1(p1_action,p2_action);
r2 = R2(p1_action,p2_action);
if (p1_action == 1)
    pr1 = pr1 + alpha * r1 * (1 - pr1);
    pp1 = pp1 - alpha * r1 * pp1;
    ps1 = ps1 - alpha * r1 * ps1;
elseif (p1_action == 2) 
    %player1 paper 
    pp1 = pp1 + alpha * r1 * (1 - pp1);
    pr1 = pr1 - alpha * r1 * pr1;
    ps1 = ps1 - alpha * r1 * ps1;
else 
    ps1 = ps1 + alpha * r1 * (1 - ps1);
    pr1 = pr1 - alpha * r1 * pr1;
    pp1 = pp1 - alpha * r1 * pp1;
end

if (p2_action == 1)
    pr2 = pr2 + alpha * r2 * (1 - pr2);
    pp2 = pp2 - alpha * r2 * pp2;
    ps2 = ps2 - alpha * r2 * ps2;
elseif (p2_action == 2) 
    %player1 paper 
    pp2 = pp2 + alpha * r2 * (1 - pp2);
    pr2 = pr2 - alpha * r2 * pr2;
    ps2 = ps2 - alpha * r2 * ps2;
else 
    ps2 = ps2 + alpha * r2 * (1 - ps2);
    pr2 = pr2 - alpha * r2 * pr2;
    pp2 = pp2 - alpha * r1 * pp2;
end

end

%for game 1: 1 means cooperate while 2 means defect
%for game 2: 1 means head while 2 means tail 

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

