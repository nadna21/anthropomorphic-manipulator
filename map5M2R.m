function [T5]= map5M2R(j5)


if j5>509
   j5 =509;
end
motorValueAX5= [0,509];
motorIndegreeAX5=[0,150];


T5= (interp1(motorValueAX5,motorIndegreeAX5,j5));

T5=deg2rad(T5);


end
