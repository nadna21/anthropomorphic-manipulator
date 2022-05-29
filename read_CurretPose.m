function q = read_CurretPose(x)
q(1) = read_posMx(x,1);
q(2) = read_posMx(x,2);
q(3) = read_posMx(x,3);
q(4) = read_posAx(x,4);
q(5) = read_posAx(x,5);
q(6) = read_posAx(x,6);
end