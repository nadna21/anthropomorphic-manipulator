function [T6]= map6R2M(j6)

if j6 < 0
    j6=j6+2*pi;
end

J6=rad2deg(j6);

% j1,j2,j3,j4,j5,j6,j7 motor reading from currentPos function

if J6 > 300
    J6=300;
end

motorValueAX6= [210,808];
motorIndegreeAX=[0,300];

T6= round((interp1(motorIndegreeAX,motorValueAX6,J6)));



end
