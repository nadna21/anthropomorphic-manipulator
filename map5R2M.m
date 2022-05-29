function [T5]= map5R2M(j5)

if j5 <0
    j5=j5+2*pi;
end
J5=rad2deg(j5);


if J5>150
   J5 =150;
end
motorValueAX5= [0,509];
motorIndegreeAX5=[0,150];


T5= (interp1(motorIndegreeAX5,motorValueAX5,J5));



end
