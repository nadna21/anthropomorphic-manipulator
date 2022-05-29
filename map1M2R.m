function [T1]= map1M2R(j1)


if j1 < 578 
    j1=578;
end
if j1 > 3524 
    j1=3524;
end



motorValueMX1= [578,3524];
motorIndegree=[0,360];

T1= round((interp1(motorValueMX1,motorIndegree,j1)));
T1=deg2rad(T1);


end
