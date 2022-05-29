function thetas = invers_kinematics(T,previous)
Roundzero = 1e-4;
    DH = [-pi         0         0           3*pi/2
          -3*pi/2     0         0.15018     0;
          -pi         0         0.0715      3*pi/2;
          -2.618      0.1312    0           pi/2;
          -1.0472     0         0           3*pi/2;
          -2.618      0.026     0           0;
          ];

q_offset = DH(:,1)';
d1 = DH(1, 2);
a2 = DH(2, 3);
a3 = DH(3, 3);
d4 = DH(4, 2);
d6 = DH(6, 2);

r11 = T(1,1); r21 = T(2,1); r31 = T(3,1);      
r12 = T(1,2); r22 = T(2,2); r32 = T(3,2); 
r13 = T(1,3); r23 = T(2,3); r33 = T(3,3); 
px  = T(1,4); py  = T(2,4); pz  = T(3,4); 
% q1
if abs(py-d6*r23) < Roundzero && abs(px-d6*r13) < Roundzero
    error('Singularity at Joint 1')
else
    theta1 = atan2(py-d6*r23,px-d6*r13);
end

% q2
C = px*cos(theta1) - d6*(r13*cos(theta1) + r23*sin(theta1)) + py*sin(theta1);
B = -pz + d1 + d6*r33;
C2 = C.^2;
B2 = B.^2;
r = sqrt(C2 + B2);
E = (- a3^2 - d4^2 + C2 + B2 + a2^2)/(2*a2);

if r < Roundzero
    error('Singularity at Joint 2')
else
    f = atan2(B, C);
    f_2 = acos(E ./ r);
    
    if ~isreal(f_2)
        error('Outof Bound');
    end

    theta2 = wrapToPi(f - f_2);
end


% q3
theta3 = wrapToPi(atan2(a3,d4) - atan2((sin(theta2)*B + cos(theta2)*C - a2),(cos(theta2)*B - sin(theta2)*C)));

% q5
G = r13*cos(theta1) + r23*sin(theta1);
theta5 = atan2(sqrt(1 - (-sin(theta2+theta3)*G - r33*cos(theta2+theta3))^2),(-sin(theta2+theta3)*G - r33*cos(theta2+theta3)));

if (abs(sin(theta5))<Roundzero)
    warning('Sin(alpha5) = 0! Singularity at Joints 4 and 6')
    % q4
    theta4 = previous;
    % q6
    theta6 = atan2(r22*cos(theta1) - r12*sin(theta1),r21*cos(theta1) - r11*sin(theta1));
else
    % alpha 4
    theta4 = atan2((r23*cos(theta1)- r13*sin(theta1)),(r33*sin(theta2+theta3) - cos(theta2+theta3)*G));
    % alpha 6
    c_1 = cos(theta1); s_1 = sin(theta1);
    c_2 = cos(theta2); s_2 = sin(theta2);
    c_3 = cos(theta3); s_3 = sin(theta3);
    c_4 = cos(theta4); s_4 = sin(theta4);
    c_5 = cos(theta5); s_5 = sin(theta5);

    num = r12.*(c_5.*s_1.*s_4+c_1.*(c_2.*(c_3.*c_4.*c_5-s_3.*s_5)-s_2.*(c_4.*c_5.*s_3+c_3.*s_5)))-r22.*(c_4.*c_5.*s_1.*s_2.*s_3+c_1.*c_5.*s_4+c_3.*s_1.*s_2.*s_5+c_2.*s_1.*(s_3.*s_5-c_3.*c_4.*c_5))+r32.*(s_3.*(s_2.*s_5-c_2.*c_4.*c_5)-c_3.*(c_4.*c_5.*s_2+c_2.*s_5));
    num = -num;
    den = r11.*(c_5.*s_1.*s_4+c_1.*(c_2.*(c_3.*c_4.*c_5-s_3.*s_5)-s_2.*(c_4.*c_5.*s_3+c_3.*s_5)))-r21.*(c_4.*c_5.*s_1.*s_2.*s_3+c_1.*c_5.*s_4+c_3.*s_1.*s_2.*s_5+c_2.*s_1.*(s_3.*s_5-c_3.*c_4.*c_5))+r31.*(s_3.*(s_2.*s_5-c_2.*c_4.*c_5)-c_3.*(c_4.*c_5.*s_2+c_2.*s_5));
    
    theta6 = atan2(num, den);
end

thetas = [theta1, theta2, theta3, theta4, theta5, theta6];
thetas = real(thetas) - q_offset;
end