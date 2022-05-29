function [T4]= map4R2M(j4)

if j4 <0
    j4=j4+2*pi;
end





J4=rad2deg(j4)

if J4 > 300
    J4=300;
end

motorValueAX4= [208,809];

motorIndegreeAX=[0, 300];

T4= round((interp1(motorIndegreeAX,motorValueAX4,J4)));

if T4 < 208
    T4=208;
end

if T4 > 809
    T4=809;
end


end
