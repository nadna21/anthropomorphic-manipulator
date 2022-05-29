function []=excute(PickposeT,PlaceposeT,pick_intermediateT,place_intermediateT,x,p)

HomePose=[2048, 2048, 2048, 509, 509, 509];

Pickpose=[PickposeT(1), PickposeT(2), PickposeT(3), PickposeT(4),PickposeT(5), PickposeT(6)];
Placepose=[PlaceposeT(1), PlaceposeT(2), PlaceposeT(3), PlaceposeT(4), PlaceposeT(5), PlaceposeT(6)];
pick_intermediate = [pick_intermediateT(1) ,pick_intermediateT(2) ,pick_intermediateT(3),pick_intermediateT(4) ,pick_intermediateT(5) ,pick_intermediateT(6)];
place_intermediate = [place_intermediateT(1),place_intermediateT(2) ,place_intermediateT(3) ,place_intermediateT(4) ,place_intermediateT(5),place_intermediateT(6)];


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
    gripperOpen(x);
end
pause(1);
if ~isequal(currentPose,HomePose)
    writePosition1(currentPose,HomePose,x,p)
    pause(2);
    gripperOpen(x);
    pause(1);
end

    writePosition1(HomePose,pick_intermediate,x,p);
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
