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

 

