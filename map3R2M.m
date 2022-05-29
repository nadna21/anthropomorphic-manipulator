function [T3]= map3R2M(j3)


if j3 < 0
    j3=j3+2*pi;
end

J3=rad2deg(j3);

motorValueMX3= [936,3049];
motorIndegree=[0,360];

T3= round((interp1(motorIndegree,motorValueMX3,J3)))+55;

if T3 > 3049
    T3= 3049;
end



end
