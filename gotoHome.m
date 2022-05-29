function []=gotoHome(currentPose,HomePose,x,p)



current=[currentPose(1), currentPose(2), currentPose(3), currentPose(4),currentPose(5), currentPose(6)];
home=[HomePose(1), HomePose(2), HomePose(3), HomePose(4), HomePose(5), HomePose(6)];







if current(1) || current(2) || current(3) || current(4) || current(5) || current(6) ==0
    [jointAngle,~]=currentPos(x);
    j1=jointAngle(1);
    j2=jointAngle(2);
    j3=jointAngle(3);
    j4=jointAngle(4);
    j5=jointAngle(5);
    j6=jointAngle(6);
    current=[j1,j2,j3,j4,j5,j6];
end



if isequal(current,home)
    disp('Home Position')
    gripperOpen(x);
end
pause(1);
if ~isequal(current,home)
    writePosition1(current,home,x,p)
    pause(2);
    gripperOpen(x);
    pause(1);
end

  

end
