function [q]= lspb_traj(p,initial_Thetas,final_Thetas)
t=0:0.08:p;
   
    
  [q_1,~,~]=mtraj(@lspb,initial_Thetas(1),final_Thetas(1),t);
  [q_2,~,~]=mtraj(@lspb,initial_Thetas(2),final_Thetas(2),t);
  [q_3,~,~]=mtraj(@lspb,initial_Thetas(3),final_Thetas(3),t);
  [q_4,~,~]=mtraj(@lspb,initial_Thetas(4),final_Thetas(4),t);
  [q_5,~,~]=mtraj(@lspb,initial_Thetas(5),final_Thetas(5),t);
  [q_6,~,~]=mtraj(@lspb,initial_Thetas(6),final_Thetas(6),t);
  

     q = cat(1,q_1',q_2',q_3',q_4',q_5',q_6');
    
    
    


end