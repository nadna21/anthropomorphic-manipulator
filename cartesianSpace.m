function []= cartesianSpace(p,x,pickposeXYZ,placeposeXYZ)
HomePose = [pi    pi    pi    2.618    2.618    2.618];
  
current_pose = read_CurretPose(x);
pickposeXYZ(1) = 0.067 + pickposeXYZ(1)/100;
pickposeXYZ(2) = -0.0655 + pickposeXYZ(2)/100;
pickposeXYZ(3) = 0.0823 + pickposeXYZ(3)/100;

placeposeXYZ(1) = 0.067 + placeposeXYZ(1)/100;
placeposeXYZ(2) = -0.0655 + placeposeXYZ(2)/100;
placeposeXYZ(3) = 0.0823 + placeposeXYZ(3)/100;

EE_0 = direct_kin(HomePose);

tran = zeros(4,4);
tran1 = zeros(4,4);


tran(1:3,4) = [pickposeXYZ(1) pickposeXYZ(2) pickposeXYZ(3)];
TI = trotz(EE_0(6)) * troty(EE_0(5)) * trotx(EE_0(4)) + tran;
q_pick = invers_kinematics(TI,0);  % theta's for pick pose


tran1(1:3,4) = [placeposeXYZ(1) placeposeXYZ(2) placeposeXYZ(3)];
TF = trotz(EE_0(6)) * troty(EE_0(5)) * trotx(EE_0(4)) + tran1;
q_place = invers_kinematics(TF,0); 


%% Generation
q_Home = lspb_traj(p,current_pose,HomePose);
q_InterPick = lspb_traj(p,HomePose,q_pick);

%% Going to intermidiate pose (q_pi)
% q2=lspb_traj(p,q_default,q_pi);
q = cat(2,q_Home,q_InterPick);
% q = cat(2,q1,q2);

% Above Pick Position to Actual Pick Position in Task Space
% for task space after going to pick place pick
% doing direct kinematics
EE_0 = direct_kin(q_pick); 
tran = zeros(4,4);

% taking pz changing for translation
tran(1:3,4) = [EE_0(1) EE_0(2) (EE_0(3))-0.05];
TF = trotz(EE_0(6)) * troty(EE_0(5)) * trotx(EE_0(4)) + tran;

%% pick pose poses
q_finalPick = invers_kinematics(TF,q(4,end));

q_pickPathCart = cartesian_traj(p,q_pick,q_finalPick);


%% Moving back to intermidiate pose

q_final2interPathCart = cartesian_traj(p,q_finalPick,q_pick);

%% Moving to intermidiate place pose from intermidiate pick
q_pick2place = lspb_traj(p,q_pick,q_place);


%% Finding final place pose

EE_0 = direct_kin(q_place);
tran = zeros(4,4);
tran(1:3,4) = [EE_0(1) EE_0(2) (EE_0(3))-0.045];
TF = trotz(EE_0(6)) * troty(EE_0(5)) * trotx(EE_0(4)) + tran;


q_placeFinal = invers_kinematics(TF,q(4,end));
q_inter2placeCart = cartesian_traj(p,q_place,q_placeFinal);

%% Moving back to intermidiate place pose

q_place2InterCart = cartesian_traj(p,q_placeFinal,q_place);

[q_place2Home] = lspb_traj(p,q_place,HomePose);

%% Passing thetas to manipulator
writePositon_cartesian(p,x,q_Home);
pause(0.5)


writePositon_cartesian(p,x,q_InterPick);
pause(0.5)

% Opening The Gripper
gripperOpen(x)
pause(0.05)

writePositon_cartesian(p,x,q_pickPathCart);
pause(0.5)

% Closing The Gripper
gripperClose(x);
pause(0.05)

writePositon_cartesian(p,x,q_final2interPathCart);
pause(0.5)

writePositon_cartesian(p,x,q_pick2place);
pause(1)

writePositon_cartesian(p,x,q_inter2placeCart);
pause(0.5)

% Opening The Gripper
gripperOpen(x)
pause(0.05)

writePositon_cartesian(p,x,q_place2InterCart);
pause(1)

writePositon_cartesian(p,x,q_place2Home);

end