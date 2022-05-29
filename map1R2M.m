function [T1]= map1R2M(j1)

if j1<0
   j1=j1+2*pi; 
end
   

J1=rad2deg(j1);
motorValueMX1= [578,3524];
motorIndegree=[0,360];


T1= (interp1(motorIndegree,motorValueMX1,J1))-3;
if T1 < 578
    T1= 578;
end


end
