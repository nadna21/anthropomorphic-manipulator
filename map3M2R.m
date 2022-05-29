function [T3]= map3M2R(j3)

% j3=j3+55;
if j3<1044
    j3=1044;
end

if j3 >3049
    j3=3049;
end

motorValueMX3= [1044,3049];
motorIndegree=[0,360];


T3= round((interp1(motorValueMX3,motorIndegree,j3)));

T3=deg2rad(T3);


end
