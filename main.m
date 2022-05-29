function []=main(x,p)


HomePose=[2060, 2013, 2111, 520, 489, 800];
Pickpose=[1919, 2665, 1761, 519,406, 464 ];
Placepose=[2371, 2684, 1722, 520, 400, 464];
pick_intermediate = [1923 ,2536 ,1737,513 ,430 ,464];
place_intermediate = [2427,2690 ,1525 ,506 ,448,464];



[jointAngle,~]=currentPos(x);
j1=jointAngle(1);
j2=jointAngle(2);
j3=jointAngle(3);
j4=jointAngle(4);
j5=jointAngle(5);
j6=jointAngle(6);

currentPose1=[j1,j2,j3,j4,j5,j6];
pause(0.1);

if currentPose1(1) || currentPose1(2) || currentPose1(3) || currentPose1(4) || currentPose1(5) || currentPose1(6) ==0
    [jointAngle,~]=currentPos(x);
    j1=jointAngle(1);
    j2=jointAngle(2);
    j3=jointAngle(3);
    j4=jointAngle(4);
    j5=jointAngle(5);
    j6=jointAngle(6);
    currentPose1=[j1,j2,j3,j4,j5,j6];
end



if isequal(currentPose1,HomePose)
    disp('Home Position')
    gripperOpen(x);
end
pause(1);
if ~isequal(currentPose1,HomePose)
    writePosition1(currentPose1,HomePose,x,p)
    pause(2);
    gripperOpen(x);
    pause(1);
end

  
    writePosition_Joint(q1,q2,q3,q4,q5,q6,x,p)
    pause(1);
    writePosition1(pick_intermediate,Pickpose,x,p);
    pause(1);
    gripperClose(x);
    pause(1);
    writePosition1(Pickpose,pick_intermediate,x,p);
    pause(1);
    writePosition1(pick_intermediate,place_intermediate,x,p);
    pause(1);
    writePosition1(place_intermediate,Placepose,x,p);
    pause(1);
    gripperOpen(x);
    pause(1)
    writePosition1(Placepose,place_intermediate,x,p);
    pause(1);
    writePosition1(place_intermediate,HomePose,x,p);
    


end

