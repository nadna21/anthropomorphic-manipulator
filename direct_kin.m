function D = direct_kin(q)


DH = [-pi     0 0  3*pi/2
      -3*pi/2 0  0.15018 0;
       -pi    0  0.0715 3*pi/2;
       -2.618 0.1312 0 pi/2;
       -1.0472  0 0 3*pi/2;
        -2.618 0.026 0 0;
                        ];

q_offset = DH(:,1)';
 q = q + q_offset;
d1 = DH(1, 2);
a2 = DH(2, 3);
a3 = DH(3, 3);
d4 = DH(4, 2);
d6 = DH(6, 2);

c1 = cos(q(1)); s1 = sin(q(1));
c2 = cos(q(2)); s2 = sin(q(2));
c3 = cos(q(3)); s3 = sin(q(3));
c23 = cos(q(2) + q(:,3)); s23 = sin(q(2) + q(3));
c4 = cos(q(4)); s4 = sin(q(4));
c5 = cos(q(5)); s5 = sin(q(5));
c6 = cos(q(6)); s6 = sin(q(6));
r11 = s1 .* (c5 .* c6 .* s4 + c4 .* s6)+ c1 .* (c23 .* (c4 .* c5 .* c6 - s4 .* s6) - c6 .* s5 .* s23);
r21 = c6 .* (c5 .* (c2 .* c3 .* c4 .* s1 - c4 .* s2 .* s3 .* s1 - c1 .* s4) - s1 .* s5 .* s23) - s6 .* (s1 .* s4 .* c23 + c1 .* c4);
r31 = s4 .* s6 .* s23 - c6 .* (c3 .* (c4 .* c5 .* s2 + c2 .* s5)+ s3 .* (c2 .* c4 .* c5 - s2 .* s5));
r32 = c3 .* (c6 .* s2 .* s4 + s6 .* (c4 .* c5 .* s2 + c2 .* s5))+ s3 .* (c2 .* (c6 .* s4 + c4 .* c5 .* s6) - s2 .* s5 .* s6);
r33 = s2 .* (c5 .* s3 + c3 .* c4 .* s5)+ c2 .* (c4 .* s3 .* s5 - c3 .* c5);
x = c1 .* (c23 .* (a3 - c4 .* d6 .* s5) ...
    - s23 .* (c5 .* d6 + d4) + a2 .* c2) - d6 .* s1 .* s4 .* s5;
y = c2 .* s1 .* (c3 .* (a3 - c4 .* d6 .* s5) + a2 ...
    - s3 .* (c5 .* d6 + d4)) - a3 .* s1 .* s3 .* s2 ...
    - c3 .* s1 .* s2 .* (c5 .* d6 + d4) ...
    + c4 .* d6 .* s1 .* s3 .* s5 .* s2 + c1 .* d6 .* s4 .* s5;
z = s2 .* (c3 .* (c4 .* d6 .* s5 - a3) - a2 ...
    + s3 .* (c5 .* d6 + d4)) - c2 .* (s3 .* (a3 - c4 .* d6 .* s5) ...
    + c3 .* (c5 .* d6 + d4)) + d1;

yaw = atan2(r32, r33);
pitch = atan2(-r31, sqrt(r32.^2 + r33.^2));
roll = atan2(r21, r11);

D = [x y z yaw pitch roll];

end