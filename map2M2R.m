function [T2]= map2M2R(j2)

% j1,j2,j3,j4,j5,j6,j7 motor reading from currentPos function
j2=j2-4;
 
if j2 < 1192 
    j2=1192;
end
if j2 > 2895 
    j2=2895;

end
motorValueMX2= [1192,2895];
motorIndegree=[0,360];

T2= round((interp1(motorValueMX2,motorIndegree,j2)));

T2=deg2rad(T2)


end
