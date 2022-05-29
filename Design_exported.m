classdef Design_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        GridLayout                     matlab.ui.container.GridLayout
        LeftPanel                      matlab.ui.container.Panel
        CenterPanel                    matlab.ui.container.Panel
        Panel                          matlab.ui.container.Panel
        cmLabel_3                      matlab.ui.control.Label
        cmLabel_2                      matlab.ui.control.Label
        cmLabel                        matlab.ui.control.Label
        StartButton_2                  matlab.ui.control.StateButton
        DefaultExecutionLabel          matlab.ui.control.Label
        GetPositionButton              matlab.ui.control.Button
        HomeButton                     matlab.ui.control.Button
        PzEditField                    matlab.ui.control.NumericEditField
        PzEditFieldLabel               matlab.ui.control.Label
        PyEditField                    matlab.ui.control.NumericEditField
        PyEditFieldLabel               matlab.ui.control.Label
        PxEditField                    matlab.ui.control.NumericEditField
        PxEditFieldLabel               matlab.ui.control.Label
        StartButton                    matlab.ui.control.Button
        Theta6EditField                matlab.ui.control.NumericEditField
        Theta6EditFieldLabel           matlab.ui.control.Label
        Theta5EditField                matlab.ui.control.NumericEditField
        Theta5EditFieldLabel           matlab.ui.control.Label
        Theta4EditField                matlab.ui.control.NumericEditField
        Theta4EditFieldLabel           matlab.ui.control.Label
        Theta3EditField                matlab.ui.control.NumericEditField
        Theta3EditFieldLabel           matlab.ui.control.Label
        Theta2EditField                matlab.ui.control.NumericEditField
        Theta2EditFieldLabel           matlab.ui.control.Label
        Theta1EditField                matlab.ui.control.NumericEditField
        Theta1EditFieldLabel           matlab.ui.control.Label
        EndEffectorPositionLabel       matlab.ui.control.Label
        JointanglesLabel               matlab.ui.control.Label
        UIAxes                         matlab.ui.control.UIAxes
        RightPanel                     matlab.ui.container.Panel
        TimeofExecutionEditField       matlab.ui.control.NumericEditField
        TimeofExecutionEditFieldLabel  matlab.ui.control.Label
        COMPORTEditField               matlab.ui.control.EditField
        COMPORTEditFieldLabel          matlab.ui.control.Label
        ExcuteButton                   matlab.ui.control.Button
        InterPlaceButton               matlab.ui.control.Button
        InterPickButton                matlab.ui.control.Button
        PlacePoseButton                matlab.ui.control.Button
        PickPoseButton                 matlab.ui.control.Button
        TeachButton                    matlab.ui.control.Button
        Joint6EditField                matlab.ui.control.NumericEditField
        Joint6EditFieldLabel           matlab.ui.control.Label
        Joint5EditField                matlab.ui.control.NumericEditField
        Joint5EditFieldLabel           matlab.ui.control.Label
        Joint4EditField                matlab.ui.control.NumericEditField
        Joint4EditFieldLabel           matlab.ui.control.Label
        Joint3EditField                matlab.ui.control.NumericEditField
        Joint3EditFieldLabel           matlab.ui.control.Label
        Joint2EditField                matlab.ui.control.NumericEditField
        Joint2EditFieldLabel           matlab.ui.control.Label
        Joint1EditField                matlab.ui.control.NumericEditField
        Joint1EditFieldLabel           matlab.ui.control.Label
        CurrentpositiondisplayLabel    matlab.ui.control.Label
    end

    % Properties that correspond to apps with auto-reflow
    properties (Access = private)
        onePanelWidth = 576;
        twoPanelWidth = 768;
    end

    
    properties (Access = private)
        theta1 % Description
        theta2
        theta3
        theta4
        theta5
        theta6
        theta7
        theta11 % Description
        theta21
        theta31
        theta41
        theta51
        theta61
        theta71
        a2=0.15018;
        a3=0.0715;
        d4=0.1312;
        d6=0.026;
        px=[];
        py=[];
        pz=[];
        
        J1;
        J2;
        J3;
        J4;
        J5;
        J6;
        J7;
        pickPose=[];
        plcePose=[];
        InterPicPose=[];
        InterPlaPose=[];
        time;
        port;
        q;
        D;
        
      
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: StartButton
        function StartButtonPushed(app, event)
%             
  % joint limit 
  T1=[0.8820,5.4104];
  T2=[1.8224,4.4470];
  T3=[1.4312,4.6817];
  T4=[1.0441,4.1714];
  T5=[0     , 2.6154];
  T6=[1.0492, 4.1867];

  

 DH = [
    -pi 0 0 3*pi/2
    -3*pi/2 0 app.a2 0;
    -pi 0 app.a3 3*pi/2;
    -2.618 app.d4 0 pi/2;
    -1.0472 0 0 3*pi/2;
    -2.618 app.d6 0 0;
     ];
            
             

            if app.Theta1EditField.Value<0
                app.Theta1EditField.Value=0;
            end
            if app.Theta2EditField.Value<0
                app.Theta2EditField.Value=0;
            end
            if app.Theta3EditField.Value<0
                app.Theta3EditField.Value=0;
            end
            if app.Theta4EditField.Value<0
                app.Theta4EditField.Value=0;
            end
            if app.Theta5EditField.Value<0
                app.Theta5EditField.Value=0;
            end
            if app.Theta6EditField.Value<0
                app.Theta6EditField.Value=0;
            end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
             if app.Theta1EditField.Value>360
                app.Theta1EditField.Value=360;
            end
            if app.Theta2EditField.Value>360
                app.Theta2EditField.Value=360;
            end
            if app.Theta3EditField.Value>360
                app.Theta3EditField.Value=360;
            end
            if app.Theta4EditField.Value>300
                app.Theta4EditField.Value=300;
            end
            if app.Theta5EditField.Value>150
                app.Theta5EditField.Value=150;
            end
            if app.Theta6EditField.Value>300
                app.Theta6EditField.Value=300;
            end
            

            
            app.theta1=(app.Theta1EditField.Value)*pi/180;
            app.theta2=(app.Theta2EditField.Value)*pi/180;
            app.theta3=(app.Theta3EditField.Value)*pi/180;        
            app.theta4=(app.Theta4EditField.Value)*pi/180;
            app.theta5=(app.Theta5EditField.Value)*pi/180;
            app.theta6=(app.Theta6EditField.Value)*pi/180;
          app.q= [app.theta1,app.theta2,app.theta3,app.theta4,app.theta5,app.theta6];
         
          
         app.D=direct_kin(app.q);
         zero = 1e-4;
         if app.D(2)*100<zero
             app.D(2)=0;
         end
         
          app.PxEditField.Value= (app.D(1))*100;
          app.PyEditField.Value= ( app.D(2))*100;
          app.PzEditField.Value= ( app.D(3))*100;
              
           Rob =SerialLink(DH,'name','Rob'); 
           angle_offset = [-pi -3*pi/2  -pi -2.618 -1.0472 -2.618];           
try
theta_initial=evalin('base','theta_initial');
catch
theta_initial=angle_offset;
end

t=0:.08:1;
[Th_path{1},QD{1},QDD{1}]=mtraj(@lspb, theta_initial(1),app.theta1,t)

[Th_path{2},QD{2},QDD{2}]=mtraj(@lspb, theta_initial(2),app.theta2,t);
[Th_path{3},QD{3},QDD{3}]=mtraj(@lspb, theta_initial(3),app.theta3,t);
[Th_path{4},QD{4},QDD{4}]=mtraj(@lspb, theta_initial(4),app.theta4,t);
[Th_path{5},QD{5},QDD{5}]=mtraj(@lspb, theta_initial(5),app.theta5,t);
[Th_path{6},QD{6},QDD{6}]=mtraj(@lspb, theta_initial(6),app.theta6,t);


for i=1:1:length(t)
app.q=[Th_path{1}(i), Th_path{2}(i), Th_path{3}(i), Th_path{4}(i), Th_path{5}(i),Th_path{6}(i)];
 app.D= direct_kin(app.q);
 
    
 app.px=[app.px [app.D(1)]];
 app.py=[app.py [app.D(2)]];
 app.pz=[app.pz [app.D(3)]];
end

w1=[];
w2=[];
w3=[];
w4=[];
w5=[];
w6=[];
A1=[];
A2=[];
A3=[];
A4=[];
A5=[];
A6=[];
for i=1:length(t)

w1=[w1 [QD{1}(i)]];  
w2=[w2 [QD{2}(i)]];
w3=[w3 [QD{3}(i)]];
w4=[w4 [QD{4}(i)]];
w5=[w5 [QD{5}(i)]];
w6=[w6 [QD{6}(i)]];

A1=[A1 [QDD{1}(i)]];  
A2=[A2 [QDD{2}(i)]];
A3=[A3 [QDD{3}(i)]];
A4=[A4 [QDD{4}(i)]];
A5=[A5 [QDD{5}(i)]];
A6=[A6 [QDD{6}(i)]];
end

plot(t,w1,'Parent',app.UIAxes)
hold (app.UIAxes)
plot(t,w2,'Parent',app.UIAxes)
plot(t,w3,'Parent',app.UIAxes)
plot(t,w4,'Parent',app.UIAxes)
plot(t,w5,'Parent',app.UIAxes)
plot(t,w6,'Parent',app.UIAxes)

plot(t,A1,'Parent',app.UIAxes)
plot(t,A2,'Parent',app.UIAxes)
plot(t,A3,'Parent',app.UIAxes)
plot(t,A4,'Parent',app.UIAxes)
plot(t,A5,'Parent',app.UIAxes)
plot(t,A6,'Parent',app.UIAxes)
legend(app.UIAxes,'w1','w2','w3','w4','w5','w6','acc1','acc2','acc3','acc4','acc5','acc6')

 plot3(app.px(1,:),app.py(1,:),app.pz(1,:),'Color',[0 0 1],'LineWidth',3)

    hold on;
xlim([-0.5 0.5])
ylim([-0.5 0.5])
zlim([-0.5 0.5])
for i=1:length(t)
Rob.plot([Th_path{1}(i) Th_path{2}(i) Th_path{3}(i) Th_path{4}(i) Th_path{5}(i) Th_path{6}(i)],'scale',0.5,'perspective','jointdiam',3,'jaxes','shadow');


end

 % given thetas to go 
         q1=[map1R2M(app.theta1), map2R2M(app.theta2), map3R2M(app.theta3), map4R2M(app.theta4), map5R2M(app.theta5), map6R2M(app.theta6)];  
          

    gotoGivenpoint(q1,app.COMPORTEditField.Value,app.TimeofExecutionEditField.Value) ;     
        end

        % Button pushed function: HomeButton
        function HomeButtonPushed(app, event)
            app.theta1=180;
            app.theta2=180;
            app.theta3=180;
            app.theta4=150;
            app.theta5=150;
            app.theta6=150;
            app.Theta1EditField.Value=app.theta1;
            app.Theta2EditField.Value=app.theta2;
            app.Theta3EditField.Value=app.theta3;
            app.Theta4EditField.Value=app.theta4;
            app.Theta5EditField.Value=app.theta5;
            app.Theta6EditField.Value=app.theta6;  
            
           app.J1= deg2rad(app.theta1);
           app.J2=deg2rad(app.theta2);
           app.J3=deg2rad(app.theta3);
           app.J4=deg2rad(app.theta4);
           app.J5=deg2rad(app.theta5);
           app.J6=deg2rad(app.theta6);
           [jointAngle,~]=currentPos(app.COMPORTEditField.Value);
            j1=jointAngle(1);
            j2=jointAngle(2);
            j3=jointAngle(3);
            j4=jointAngle(4);
            j5=jointAngle(5);
            j6=jointAngle(6);
        currentPosition=[j1,j2,j3,j4,j5,j6];
          %% Mapping to radian to motor reading 
           app.J1=map1R2M(Join_Reading(1));
           app.J2=map2R2M(Join_Reading(2));
           app.J3=map3R2M(Join_Reading(3));
           app.J4=map4R2M(Join_Reading(4));
           app.J5=map5R2M(Join_Reading(5));
           app.J6=map6R2M(Join_Reading(6));
          home=[app.J1,app.J2,app.J3,app.J4,app.J5,app.J6];
       gotoHome(currentPosition, home,app.COMPORTEditField.Value,app.TimeofExecutionEditField.Value);   
            
        end

        % Button down function: UIAxes
        function UIAxesButtonDown(app, event)
           
          



        end

        % Callback function
        function TrajectoryButtonGroupSelectionChanged(app, event)
            selectedButton = app.TrajectoryButtonGroup.SelectedObject;
%             app.ApproximatewithsplineButton.Enable = 'on';
%             app.ApproximatewithsplineButton.Enable = 'off';
        end

        % Button pushed function: GetPositionButton
        function GetPositionButtonPushed(app, event)
           
           [Join_Reading,~] = currentPos(app.COMPORTEditField.Value);
           % reading joint angles from manipulator 
           app.J1=map1M2R(Join_Reading(1));
           app.J2=map2M2R(Join_Reading(2));
           app.J3=map3M2R(Join_Reading(3));
           app.J4=map4M2R(Join_Reading(4));
           app.J5=map5M2R(Join_Reading(5));
           app.J6=map6M2R(Join_Reading(6));
           
           app.q=[app.J1,app.J2,app.J3,app.J4,app.J5,app.J6];
          
          
                  
            % Writing on the edit fields of Thetas 
            app.Theta1EditField.Value=rad2deg(app.J1);
            app.Theta2EditField.Value=rad2deg(app.J2);
            app.Theta3EditField.Value=rad2deg(app.J3);
            app.Theta4EditField.Value=rad2deg(app.J4);
            app.Theta5EditField.Value=rad2deg(app.J5);
            app.Theta6EditField.Value=rad2deg(app.J6);
            
         
    
      % Printing on 
      app.D=direct_kin(app.q);
      
           app.PxEditField.Value= (0.06+ app.D(1))*100;
           app.PyEditField.Value= (-0.065 + app.D(2))*100;
           app.PzEditField.Value= (0.08 + app.D(3))*100;
                            
           
        end

        % Button pushed function: TeachButton
        function TeachButtonPushed(app, event)
            teach(app.COMPORTEditField.Value);

        end

        % Button pushed function: PickPoseButton
        function PickPoseButtonPushed(app, event)
          [Join_Reading,~] =pickpose(app.COMPORTEditField.Value);
                       
           app.J1=map1M2R(Join_Reading(1));
           app.J2=map2M2R(Join_Reading(2));
           app.J3=map3M2R(Join_Reading(3));
           app.J4=map4M2R(Join_Reading(4));
           app.J5=map5M2R(Join_Reading(5));
           app.J6=map6M2R(Join_Reading(6));            

            app.q=[app.J1,app.J2,app.J3,app.J4,app.J5,app.J6];
            
            app.Joint1EditField.Value=rad2deg(app.J1);
            app.Joint2EditField.Value=rad2deg(app.J2);
            app.Joint3EditField.Value=rad2deg(app.J3);
            app.Joint4EditField.Value=rad2deg(app.J4);
            app.Joint5EditField.Value=rad2deg(app.J5);
            app.Joint6EditField.Value=rad2deg(app.J6);
            
            % Converting to radians
            
    
      % Printing on 
      app.D=direct_kin(app.q);
      
           app.PxEditField.Value= (0.06+ app.D(1))*100;
           app.PyEditField.Value= (-0.065 + app.D(2))*100;
           app.PzEditField.Value= (0.08 + app.D(3))*100;          


        end

        % Button pushed function: PlacePoseButton
        function PlacePoseButtonPushed(app, event)
            
               [Join_Reading,~] =placePose(app.COMPORTEditField.Value);
                   
           app.J1=map1M2R(Join_Reading(1));
           app.J2=map2M2R(Join_Reading(2));
           app.J3=map3M2R(Join_Reading(3));
           app.J4=map4M2R(Join_Reading(4));
           app.J5=map5M2R(Join_Reading(5));
           app.J6=map6M2R(Join_Reading(6));            

            app.q=[app.J1,app.J2,app.J3,app.J4,app.J5,app.J6];
            
            app.Joint1EditField.Value=rad2deg(app.J1);
            app.Joint2EditField.Value=rad2deg(app.J2);
            app.Joint3EditField.Value=rad2deg(app.J3);
            app.Joint4EditField.Value=rad2deg(app.J4);
            app.Joint5EditField.Value=rad2deg(app.J5);
            app.Joint6EditField.Value=rad2deg(app.J6);
            
            % Converting to radians
            
    
      % Printing on 
      app.D=direct_kin(app.q);
      
           app.PxEditField.Value= (0.06+ app.D(1))*100;
           app.PyEditField.Value= (-0.065 + app.D(2))*100;
           app.PzEditField.Value= (0.08 + app.D(3))*100;           

        end

        % Button pushed function: InterPickButton
        function InterPickButtonPushed(app, event)
                 [Join_Reading,~] =interPickPose(app.COMPORTEditField.Value);
           
                 
           app.J1=map1M2R(Join_Reading(1));
           app.J2=map2M2R(Join_Reading(2));
           app.J3=map3M2R(Join_Reading(3));
           app.J4=map4M2R(Join_Reading(4));
           app.J5=map5M2R(Join_Reading(5));
           app.J6=map6M2R(Join_Reading(6));            

            app.q=[app.J1,app.J2,app.J3,app.J4,app.J5,app.J6];
            
            app.Joint1EditField.Value=rad2deg(app.J1);
            app.Joint2EditField.Value=rad2deg(app.J2);
            app.Joint3EditField.Value=rad2deg(app.J3);
            app.Joint4EditField.Value=rad2deg(app.J4);
            app.Joint5EditField.Value=rad2deg(app.J5);
            app.Joint6EditField.Value=rad2deg(app.J6);
            
            % Converting to radians
            
    
      % Printing on 
      app.D=direct_kin(app.q);
      
           app.PxEditField.Value= (0.06+ app.D(1))*100;
           app.PyEditField.Value= (-0.065 + app.D(2))*100;
           app.PzEditField.Value= (0.08 + app.D(3))*100;          
        end

        % Button pushed function: InterPlaceButton
        function InterPlaceButtonPushed(app, event)
             [Join_Reading,~] =interPlacePose(app.COMPORTEditField.Value);
         
           
             
           app.J1=map1M2R(Join_Reading(1));
           app.J2=map2M2R(Join_Reading(2));
           app.J3=map3M2R(Join_Reading(3));
           app.J4=map4M2R(Join_Reading(4));
           app.J5=map5M2R(Join_Reading(5));
           app.J6=map6M2R(Join_Reading(6));            

            app.q=[app.J1,app.J2,app.J3,app.J4,app.J5,app.J6];
            
            app.Joint1EditField.Value=rad2deg(app.J1);
            app.Joint2EditField.Value=rad2deg(app.J2);
            app.Joint3EditField.Value=rad2deg(app.J3);
            app.Joint4EditField.Value=rad2deg(app.J4);
            app.Joint5EditField.Value=rad2deg(app.J5);
            app.Joint6EditField.Value=rad2deg(app.J6);
            
            % Converting to radians
            
    
      % Printing on 
            app.D=direct_kin(app.q);
      
           app.PxEditField.Value= (0.06+ app.D(1))*100;
           app.PyEditField.Value= (-0.065 + app.D(2))*100;
           app.PzEditField.Value= (0.08 + app.D(3))*100;
        end

        % Button pushed function: ExcuteButton
        function ExcuteButtonPushed(app, event)
            if app.TimeofExecutionEditField.Value > 30
                app.TimeofExecutionEditField.Value=30;
            end
            excute(app.pickPose,app.plcePose,app.InterPicPose,app.InterPlaPose,app.COMPORTEditField.Value,app.TimeofExecutionEditField.Value);
           
        end

        % Value changed function: Joint1EditField
        function Joint1EditFieldValueChanged(app, event)
            value = app.Joint1EditField.Value;
          
        end

        % Value changed function: Joint2EditField
        function Joint2EditFieldValueChanged(app, event)
            value = app.Joint2EditField.Value;
          
        end

        % Value changed function: Joint3EditField
        function Joint3EditFieldValueChanged(app, event)
            value = app.Joint3EditField.Value;
     
        end

        % Value changed function: Joint4EditField
        function Joint4EditFieldValueChanged(app, event)
            value = app.Joint4EditField.Value;
          
        end

        % Value changed function: Joint5EditField
        function Joint5EditFieldValueChanged(app, event)
            value = app.Joint5EditField.Value;
           
        end

        % Value changed function: Joint6EditField
        function Joint6EditFieldValueChanged(app, event)
            value = app.Joint6EditField.Value;
          
        end

        % Value changed function: COMPORTEditField
        function COMPORTEditFieldValueChanged(app, event)
            value = app.COMPORTEditField.Value;
       
            
        end

        % Value changed function: TimeofExecutionEditField
        function TimeofExecutionEditFieldValueChanged(app, event)
            value = app.TimeofExecutionEditField.Value;
             if value > 60
                app.TimeofExecutionEditField.Value=60;
               
            end
            
        end

        % Value changed function: StartButton_2
        function StartButton_2ValueChanged(app, event)
            value = app.StartButton_2.Value;
               if app.TimeofExecutionEditField.Value > 30
                app.TimeofExecutionEditField.Value=30;
               
               end
            
            main(app.COMPORTEditField.Value,app.TimeofExecutionEditField.Value);
        end

        % Callback function
        function ExcuteButton_2Pushed(app, event)
           
                
            
            
            
            
        end

        % Changes arrangement of the app based on UIFigure width
        function updateAppLayout(app, event)
            currentFigureWidth = app.UIFigure.Position(3);
            if(currentFigureWidth <= app.onePanelWidth)
                % Change to a 3x1 grid
                app.GridLayout.RowHeight = {482, 482, 482};
                app.GridLayout.ColumnWidth = {'1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 1;
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 3;
                app.RightPanel.Layout.Column = 1;
            elseif (currentFigureWidth > app.onePanelWidth && currentFigureWidth <= app.twoPanelWidth)
                % Change to a 2x2 grid
                app.GridLayout.RowHeight = {482, 482};
                app.GridLayout.ColumnWidth = {'1x', '1x'};
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = [1,2];
                app.LeftPanel.Layout.Row = 2;
                app.LeftPanel.Layout.Column = 1;
                app.RightPanel.Layout.Row = 2;
                app.RightPanel.Layout.Column = 2;
            else
                % Change to a 1x3 grid
                app.GridLayout.RowHeight = {'1x'};
                app.GridLayout.ColumnWidth = {12, '1x', 323};
                app.LeftPanel.Layout.Row = 1;
                app.LeftPanel.Layout.Column = 1;
                app.CenterPanel.Layout.Row = 1;
                app.CenterPanel.Layout.Column = 2;
                app.RightPanel.Layout.Row = 1;
                app.RightPanel.Layout.Column = 3;
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 705 482];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.SizeChangedFcn = createCallbackFcn(app, @updateAppLayout, true);

            % Create GridLayout
            app.GridLayout = uigridlayout(app.UIFigure);
            app.GridLayout.ColumnWidth = {12, '1x', 323};
            app.GridLayout.RowHeight = {'1x'};
            app.GridLayout.ColumnSpacing = 0;
            app.GridLayout.RowSpacing = 0;
            app.GridLayout.Padding = [0 0 0 0];
            app.GridLayout.Scrollable = 'on';

            % Create LeftPanel
            app.LeftPanel = uipanel(app.GridLayout);
            app.LeftPanel.Layout.Row = 1;
            app.LeftPanel.Layout.Column = 1;

            % Create CenterPanel
            app.CenterPanel = uipanel(app.GridLayout);
            app.CenterPanel.Layout.Row = 1;
            app.CenterPanel.Layout.Column = 2;

            % Create UIAxes
            app.UIAxes = uiaxes(app.CenterPanel);
            title(app.UIAxes, 'Robot ')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.ButtonDownFcn = createCallbackFcn(app, @UIAxesButtonDown, true);
            app.UIAxes.Position = [6 25 339 227];

            % Create Panel
            app.Panel = uipanel(app.CenterPanel);
            app.Panel.Title = 'Panel';
            app.Panel.Position = [6 251 359 215];

            % Create JointanglesLabel
            app.JointanglesLabel = uilabel(app.Panel);
            app.JointanglesLabel.FontSize = 10;
            app.JointanglesLabel.FontWeight = 'bold';
            app.JointanglesLabel.Position = [26 178 87 19];
            app.JointanglesLabel.Text = 'Joint angles';

            % Create EndEffectorPositionLabel
            app.EndEffectorPositionLabel = uilabel(app.Panel);
            app.EndEffectorPositionLabel.FontSize = 10;
            app.EndEffectorPositionLabel.FontWeight = 'bold';
            app.EndEffectorPositionLabel.Position = [126 171 107 22];
            app.EndEffectorPositionLabel.Text = 'End Effector Position';

            % Create Theta1EditFieldLabel
            app.Theta1EditFieldLabel = uilabel(app.Panel);
            app.Theta1EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta1EditFieldLabel.Position = [1 156 55 22];
            app.Theta1EditFieldLabel.Text = 'Theta1';

            % Create Theta1EditField
            app.Theta1EditField = uieditfield(app.Panel, 'numeric');
            app.Theta1EditField.Position = [70 156 39 19];

            % Create Theta2EditFieldLabel
            app.Theta2EditFieldLabel = uilabel(app.Panel);
            app.Theta2EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta2EditFieldLabel.Position = [1 132 55 22];
            app.Theta2EditFieldLabel.Text = 'Theta2';

            % Create Theta2EditField
            app.Theta2EditField = uieditfield(app.Panel, 'numeric');
            app.Theta2EditField.Position = [70 132 39 19];

            % Create Theta3EditFieldLabel
            app.Theta3EditFieldLabel = uilabel(app.Panel);
            app.Theta3EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta3EditFieldLabel.Position = [1 109 55 22];
            app.Theta3EditFieldLabel.Text = 'Theta3';

            % Create Theta3EditField
            app.Theta3EditField = uieditfield(app.Panel, 'numeric');
            app.Theta3EditField.Position = [70 109 39 19];

            % Create Theta4EditFieldLabel
            app.Theta4EditFieldLabel = uilabel(app.Panel);
            app.Theta4EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta4EditFieldLabel.Position = [1 87 55 22];
            app.Theta4EditFieldLabel.Text = 'Theta4';

            % Create Theta4EditField
            app.Theta4EditField = uieditfield(app.Panel, 'numeric');
            app.Theta4EditField.Position = [70 87 39 19];

            % Create Theta5EditFieldLabel
            app.Theta5EditFieldLabel = uilabel(app.Panel);
            app.Theta5EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta5EditFieldLabel.Position = [1 65 55 22];
            app.Theta5EditFieldLabel.Text = 'Theta5';

            % Create Theta5EditField
            app.Theta5EditField = uieditfield(app.Panel, 'numeric');
            app.Theta5EditField.Position = [70 65 39 19];

            % Create Theta6EditFieldLabel
            app.Theta6EditFieldLabel = uilabel(app.Panel);
            app.Theta6EditFieldLabel.HorizontalAlignment = 'right';
            app.Theta6EditFieldLabel.Position = [1 41 55 22];
            app.Theta6EditFieldLabel.Text = 'Theta6';

            % Create Theta6EditField
            app.Theta6EditField = uieditfield(app.Panel, 'numeric');
            app.Theta6EditField.Position = [70 41 39 19];

            % Create StartButton
            app.StartButton = uibutton(app.Panel, 'push');
            app.StartButton.ButtonPushedFcn = createCallbackFcn(app, @StartButtonPushed, true);
            app.StartButton.Position = [119 41 100 22];
            app.StartButton.Text = 'Start';

            % Create PxEditFieldLabel
            app.PxEditFieldLabel = uilabel(app.Panel);
            app.PxEditFieldLabel.HorizontalAlignment = 'right';
            app.PxEditFieldLabel.Position = [92 151 55 22];
            app.PxEditFieldLabel.Text = 'Px';

            % Create PxEditField
            app.PxEditField = uieditfield(app.Panel, 'numeric');
            app.PxEditField.Position = [158 151 39 19];

            % Create PyEditFieldLabel
            app.PyEditFieldLabel = uilabel(app.Panel);
            app.PyEditFieldLabel.HorizontalAlignment = 'right';
            app.PyEditFieldLabel.Position = [92 129 55 22];
            app.PyEditFieldLabel.Text = 'Py';

            % Create PyEditField
            app.PyEditField = uieditfield(app.Panel, 'numeric');
            app.PyEditField.Position = [158 129 39 19];

            % Create PzEditFieldLabel
            app.PzEditFieldLabel = uilabel(app.Panel);
            app.PzEditFieldLabel.HorizontalAlignment = 'right';
            app.PzEditFieldLabel.Position = [92 107 55 22];
            app.PzEditFieldLabel.Text = 'Pz';

            % Create PzEditField
            app.PzEditField = uieditfield(app.Panel, 'numeric');
            app.PzEditField.Position = [158 107 39 19];

            % Create HomeButton
            app.HomeButton = uibutton(app.Panel, 'push');
            app.HomeButton.ButtonPushedFcn = createCallbackFcn(app, @HomeButtonPushed, true);
            app.HomeButton.Position = [51 12 63 23];
            app.HomeButton.Text = 'Home';

            % Create GetPositionButton
            app.GetPositionButton = uibutton(app.Panel, 'push');
            app.GetPositionButton.ButtonPushedFcn = createCallbackFcn(app, @GetPositionButtonPushed, true);
            app.GetPositionButton.Position = [113 72 100 22];
            app.GetPositionButton.Text = 'Get Position';

            % Create DefaultExecutionLabel
            app.DefaultExecutionLabel = uilabel(app.Panel);
            app.DefaultExecutionLabel.FontSize = 10;
            app.DefaultExecutionLabel.FontWeight = 'bold';
            app.DefaultExecutionLabel.Position = [260 167 90 22];
            app.DefaultExecutionLabel.Text = 'Default Execution';

            % Create StartButton_2
            app.StartButton_2 = uibutton(app.Panel, 'state');
            app.StartButton_2.ValueChangedFcn = createCallbackFcn(app, @StartButton_2ValueChanged, true);
            app.StartButton_2.Text = 'Start';
            app.StartButton_2.Position = [253 135 100 22];

            % Create cmLabel
            app.cmLabel = uilabel(app.Panel);
            app.cmLabel.FontSize = 10;
            app.cmLabel.FontWeight = 'bold';
            app.cmLabel.Position = [204 148 19 22];
            app.cmLabel.Text = 'cm';

            % Create cmLabel_2
            app.cmLabel_2 = uilabel(app.Panel);
            app.cmLabel_2.FontSize = 10;
            app.cmLabel_2.FontWeight = 'bold';
            app.cmLabel_2.Position = [204 129 19 22];
            app.cmLabel_2.Text = 'cm';

            % Create cmLabel_3
            app.cmLabel_3 = uilabel(app.Panel);
            app.cmLabel_3.FontSize = 10;
            app.cmLabel_3.FontWeight = 'bold';
            app.cmLabel_3.Position = [204 107 19 22];
            app.cmLabel_3.Text = 'cm';

            % Create RightPanel
            app.RightPanel = uipanel(app.GridLayout);
            app.RightPanel.Layout.Row = 1;
            app.RightPanel.Layout.Column = 3;

            % Create CurrentpositiondisplayLabel
            app.CurrentpositiondisplayLabel = uilabel(app.RightPanel);
            app.CurrentpositiondisplayLabel.FontSize = 10;
            app.CurrentpositiondisplayLabel.FontWeight = 'bold';
            app.CurrentpositiondisplayLabel.Position = [6 374 154 26];
            app.CurrentpositiondisplayLabel.Text = '       Current position display';

            % Create Joint1EditFieldLabel
            app.Joint1EditFieldLabel = uilabel(app.RightPanel);
            app.Joint1EditFieldLabel.HorizontalAlignment = 'right';
            app.Joint1EditFieldLabel.Position = [16 350 55 22];
            app.Joint1EditFieldLabel.Text = 'Joint 1';

            % Create Joint1EditField
            app.Joint1EditField = uieditfield(app.RightPanel, 'numeric');
            app.Joint1EditField.ValueChangedFcn = createCallbackFcn(app, @Joint1EditFieldValueChanged, true);
            app.Joint1EditField.Position = [84 350 53 22];

            % Create Joint2EditFieldLabel
            app.Joint2EditFieldLabel = uilabel(app.RightPanel);
            app.Joint2EditFieldLabel.HorizontalAlignment = 'right';
            app.Joint2EditFieldLabel.Position = [17 323 55 22];
            app.Joint2EditFieldLabel.Text = 'Joint 2';

            % Create Joint2EditField
            app.Joint2EditField = uieditfield(app.RightPanel, 'numeric');
            app.Joint2EditField.ValueChangedFcn = createCallbackFcn(app, @Joint2EditFieldValueChanged, true);
            app.Joint2EditField.Position = [85 323 53 22];

            % Create Joint3EditFieldLabel
            app.Joint3EditFieldLabel = uilabel(app.RightPanel);
            app.Joint3EditFieldLabel.HorizontalAlignment = 'right';
            app.Joint3EditFieldLabel.Position = [18 297 55 22];
            app.Joint3EditFieldLabel.Text = 'Joint 3';

            % Create Joint3EditField
            app.Joint3EditField = uieditfield(app.RightPanel, 'numeric');
            app.Joint3EditField.ValueChangedFcn = createCallbackFcn(app, @Joint3EditFieldValueChanged, true);
            app.Joint3EditField.Position = [85 297 53 22];

            % Create Joint4EditFieldLabel
            app.Joint4EditFieldLabel = uilabel(app.RightPanel);
            app.Joint4EditFieldLabel.HorizontalAlignment = 'right';
            app.Joint4EditFieldLabel.Position = [19 271 55 22];
            app.Joint4EditFieldLabel.Text = 'Joint 4';

            % Create Joint4EditField
            app.Joint4EditField = uieditfield(app.RightPanel, 'numeric');
            app.Joint4EditField.ValueChangedFcn = createCallbackFcn(app, @Joint4EditFieldValueChanged, true);
            app.Joint4EditField.Position = [86 271 53 22];

            % Create Joint5EditFieldLabel
            app.Joint5EditFieldLabel = uilabel(app.RightPanel);
            app.Joint5EditFieldLabel.HorizontalAlignment = 'right';
            app.Joint5EditFieldLabel.Position = [19 246 55 22];
            app.Joint5EditFieldLabel.Text = 'Joint 5';

            % Create Joint5EditField
            app.Joint5EditField = uieditfield(app.RightPanel, 'numeric');
            app.Joint5EditField.ValueChangedFcn = createCallbackFcn(app, @Joint5EditFieldValueChanged, true);
            app.Joint5EditField.Position = [86 246 53 22];

            % Create Joint6EditFieldLabel
            app.Joint6EditFieldLabel = uilabel(app.RightPanel);
            app.Joint6EditFieldLabel.HorizontalAlignment = 'right';
            app.Joint6EditFieldLabel.Position = [19 221 55 22];
            app.Joint6EditFieldLabel.Text = 'Joint 6';

            % Create Joint6EditField
            app.Joint6EditField = uieditfield(app.RightPanel, 'numeric');
            app.Joint6EditField.ValueChangedFcn = createCallbackFcn(app, @Joint6EditFieldValueChanged, true);
            app.Joint6EditField.Position = [86 221 53 22];

            % Create TeachButton
            app.TeachButton = uibutton(app.RightPanel, 'push');
            app.TeachButton.ButtonPushedFcn = createCallbackFcn(app, @TeachButtonPushed, true);
            app.TeachButton.Position = [62 189 100 22];
            app.TeachButton.Text = 'Teach';

            % Create PickPoseButton
            app.PickPoseButton = uibutton(app.RightPanel, 'push');
            app.PickPoseButton.ButtonPushedFcn = createCallbackFcn(app, @PickPoseButtonPushed, true);
            app.PickPoseButton.Position = [29 149 66 23];
            app.PickPoseButton.Text = 'PickPose';

            % Create PlacePoseButton
            app.PlacePoseButton = uibutton(app.RightPanel, 'push');
            app.PlacePoseButton.ButtonPushedFcn = createCallbackFcn(app, @PlacePoseButtonPushed, true);
            app.PlacePoseButton.Position = [29 117 73 23];
            app.PlacePoseButton.Text = 'PlacePose';

            % Create InterPickButton
            app.InterPickButton = uibutton(app.RightPanel, 'push');
            app.InterPickButton.ButtonPushedFcn = createCallbackFcn(app, @InterPickButtonPushed, true);
            app.InterPickButton.Position = [29 83 66 23];
            app.InterPickButton.Text = 'Inter Pick';

            % Create InterPlaceButton
            app.InterPlaceButton = uibutton(app.RightPanel, 'push');
            app.InterPlaceButton.ButtonPushedFcn = createCallbackFcn(app, @InterPlaceButtonPushed, true);
            app.InterPlaceButton.Position = [30 46 73 23];
            app.InterPlaceButton.Text = 'Inter Place';

            % Create ExcuteButton
            app.ExcuteButton = uibutton(app.RightPanel, 'push');
            app.ExcuteButton.ButtonPushedFcn = createCallbackFcn(app, @ExcuteButtonPushed, true);
            app.ExcuteButton.Position = [70 14 100 22];
            app.ExcuteButton.Text = 'Excute';

            % Create COMPORTEditFieldLabel
            app.COMPORTEditFieldLabel = uilabel(app.RightPanel);
            app.COMPORTEditFieldLabel.HorizontalAlignment = 'right';
            app.COMPORTEditFieldLabel.Position = [101 452 66 22];
            app.COMPORTEditFieldLabel.Text = 'COMPORT';

            % Create COMPORTEditField
            app.COMPORTEditField = uieditfield(app.RightPanel, 'text');
            app.COMPORTEditField.ValueChangedFcn = createCallbackFcn(app, @COMPORTEditFieldValueChanged, true);
            app.COMPORTEditField.Position = [110 431 50 22];

            % Create TimeofExecutionEditFieldLabel
            app.TimeofExecutionEditFieldLabel = uilabel(app.RightPanel);
            app.TimeofExecutionEditFieldLabel.HorizontalAlignment = 'right';
            app.TimeofExecutionEditFieldLabel.Position = [11 399 101 22];
            app.TimeofExecutionEditFieldLabel.Text = 'Time of Execution';

            % Create TimeofExecutionEditField
            app.TimeofExecutionEditField = uieditfield(app.RightPanel, 'numeric');
            app.TimeofExecutionEditField.ValueChangedFcn = createCallbackFcn(app, @TimeofExecutionEditFieldValueChanged, true);
            app.TimeofExecutionEditField.Position = [120 399 33 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Design_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end