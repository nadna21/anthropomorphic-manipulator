function [T6]= map6M2R(j6)


if j6 < 210
    j6=210;
end

if j6 > 808
   j6 =808;
end



motorValueAX6= [210,808];
motorIndegreeAX=[0,300];

T6= (interp1(motorValueAX6,motorIndegreeAX,j6));

T6=deg2rad(T6);


end
