function [q] = cartesian_traj(p,initial_Theats,final_Thetas)
t=0:0.08:p;


    D0 = direct_kin(initial_Theats); % Intermidiate thetas
    D1 = direct_kin(final_Thetas); % Pick or Place pose thetas

  
  [p_x,~,~]=mtraj(@lspb,D0(1), D1(1), t);
  [p_y,~,~]=mtraj(@lspb,D0(2), D1(2), t);
  [p_z,~,~]=mtraj(@lspb,D0(3), D1(3), t);
  [p_g,~,~]=mtraj(@lspb,D0(4), D1(4), t);
  [p_b,~,~]=mtraj(@lspb,D0(5), D1(5), t);
  [p_a,~,~]=mtraj(@lspb,D0(6), D1(6), t);

    tran = zeros(4,4);
    q = zeros(6,length(p_x));
    T = zeros(4,4,length(t));
    for i=1:length(p_x)
        tran(1:3,4) = [p_x(i) p_y(i) p_z(i)];
        T(:,:,i) = trotz(p_a(i)) * troty(p_b(i)) * trotx(p_g(i)) + tran;
        if i>1
            q(:,i) = invers_kinematics(T(:,:,i),q(4,i-1));
            
        else
            q(:,i) = invers_kinematics(T(:,:,i),q(4,1));
        end
    end
    
end