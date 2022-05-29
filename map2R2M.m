function [T2]= map2R2M(j2)

if j2<0
    j2=j2+2*pi;
end

J2=rad2deg(j2);
motorValueMX2= [1192,2895];
motorIndegree=[0,360];


T2= round((interp1(motorIndegree,motorValueMX2,J2))+4);

if T2 > 2895
    T2=2895;
end
    

end
