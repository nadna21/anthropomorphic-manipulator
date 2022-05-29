function [T4]= map4M2R(j4)

% j1,j2,j3,j4,j5,j6,j7 motor reading from currentPos function


if j4 < 208
    j4=208;
end

if j4 > 809
    j4=809;

end

motorValueAX4= [208,809];

motorIndegreeAX=[0, 300];

T4= round((interp1(motorValueAX4,motorIndegreeAX,j4)));

T4=deg2rad(T4);


end