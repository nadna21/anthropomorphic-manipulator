function []=gotoGivenpoint(givenPose,x,p)

HomePose=[2048, 2048, 2048, 509, 509, 509];

[jointAngle,~]=currentPos(x);
j1=jointAngle(1);
j2=jointAngle(2);
j3=jointAngle(3);
j4=jointAngle(4);
j5=jointAngle(5);
j6=jointAngle(6);

currentPose=[j1,j2,j3,j4,j5,j6];
pause(0.1);

if currentPose(1) || currentPose(2) || currentPose(3) || currentPose(4) || currentPose(5) || currentPose(6) ==0
    [jointAngle,~]=currentPos(x);
    j1=jointAngle(1);
    j2=jointAngle(2);
    j3=jointAngle(3);
    j4=jointAngle(4);
    j5=jointAngle(5);
    j6=jointAngle(6);
    currentPose=[j1,j2,j3,j4,j5,j6];
end



if isequal(currentPose,HomePose)
    disp('Home Position')
    
end
pause(1);
if ~isequal(currentPose,HomePose)
    writePosition1(currentPose,HomePose,x,p)
    pause(1);
    
end


writePosition1(HomePose,givenPose,x,p);
pause(1);




  

end
