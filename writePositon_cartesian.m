function [DEVICENAME]=  writePositon_cartesian(p,x,q)
lib_name = '';

if strcmp(computer, 'PCWIN')
  lib_name = 'dxl_x86_c';
elseif strcmp(computer, 'PCWIN64')
  lib_name = 'dxl_x64_c';
elseif strcmp(computer, 'GLNX86')
  lib_name = 'libdxl_x86_c';
elseif strcmp(computer, 'GLNXA64')
  lib_name = 'libdxl_x64_c';
elseif strcmp(computer, 'MACI64')
  lib_name = 'libdxl_mac_c';
end

% Load Libraries
if ~libisloaded(lib_name)
    [notfound, warnings] = loadlibrary(lib_name, 'dynamixel_sdk.h', 'addheader', 'port_handler.h', 'addheader', 'packet_handler.h', 'addheader', 'group_sync_write.h');
end

% Control table address
ADDR_PRO_TORQUE_ENABLE       = 24;         % Control table address is different in Dynamixel model
ADDR_PRO_GOAL_POSITION       = 30;
ADDR_MX_PRESENT_POSITION    = 36;



% Data Byte Length
LEN_MX_GOAL_POSITION        = 2;
LEN_PRO_GOAL_POSITION           = 2;



% Protocol version
PROTOCOL_VERSION            = 1.0;          % See which protocol version is used in the Dynamixel

% Default setting
BAUDRATE                    = 1000000;

DEVICENAME                  = x;       % Check which port is being used on your controller
                                            % ex) Windows: 'COM1'   Linux: '/dev/ttyUSB0' Mac: '/dev/tty.usbserial-*'
DXL1_ID                     = 1;            % Dynamixel#1 ID: 1
DXL2_ID                     = 2;            % Dynamixel#2 ID: 2
DXL3_ID                     = 3;            % Dynamixel#1 ID: 1
DXL4_ID                     = 4;            % Dynamixel#2 ID: 2
DXL5_ID                     = 5;            % Dynamixel#1 ID: 1
DXL6_ID                     = 6;            % Dynamixel#2 ID: 2
                                            
TORQUE_ENABLE               = 1;            % Value for enabling the torque

DXL_MOVING_STATUS_THRESHOLD = 40;          % Dynamixel moving status threshold

COMM_SUCCESS                = 0;            % Communication Success result value

u1=[];
u2=[];
u3=[];
u4=[];
u5=[];
u6=[];

% Initialize PortHandler Structs
% Set the port path
% Get methods and members of PortHandlerLinux or PortHandlerWindows
port_num = portHandler(DEVICENAME);
t=0:0.08:p;
% Initialize PacketHandler Structs
packetHandler();

% Initialize Groupsyncwrite instance
group_num = groupSyncWrite(port_num, PROTOCOL_VERSION, ADDR_PRO_GOAL_POSITION, LEN_PRO_GOAL_POSITION);






% Open port
if (openPort(port_num))
    fprintf('Succeeded to open the port!\n');
else
    unloadlibrary(lib_name);
    fprintf('Failed to open the port!\n');
    input('Press any key to terminate...\n');
    return;
end


% Set port baudrate
if (setBaudRate(port_num, BAUDRATE))
    fprintf('Succeeded to change the baudrate!\n');
else
    unloadlibrary(lib_name);
    fprintf('Failed to change the baudrate!\n');
    input('Press any key to terminate...\n');
    return;
end
for i=1:6
% Enable Dynamixel Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, i, ADDR_PRO_TORQUE_ENABLE, TORQUE_ENABLE);
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel has been successfully connected \n');
end
end 

for i=1:length(q(1,:))
    u1=[u1 map1R2M(q(1,i))];
    u2=[u2 map2R2M(q(2,i))];
    u3=[u3 map3R2M(q(3,i))];
    u4=[u4 map4R2M(q(4,i))];
    u5=[u5 map5R2M(q(5,i))];
    u6=[u6 map6R2M(q(6,i))];
 end




%% Goal Position

dxl_goal_position1 = u1;
dxl_goal_position2 = u2;
dxl_goal_position3 = u3;
dxl_goal_position4 = u4;
dxl_goal_position5 = u5;
dxl_goal_position6 = u6;

%% Writing 

i=1;

while 1

   %% Syncwrite storage
    % Add Dynamixel#1 goal position value to the Syncwrite storage
    dxl_addparam_result = groupSyncWriteAddParam(group_num, DXL1_ID, dxl_goal_position1(i), LEN_MX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL1_ID);
        return;
    end

    % Add Dynamixel#2 goal position value to the Syncwrite parameter storage
    dxl_addparam_result = groupSyncWriteAddParam(group_num, DXL2_ID, dxl_goal_position2(i), LEN_MX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL2_ID);
        return;
    end
  % Add Dynamixel#3 goal position value to the Syncwrite storage
    dxl_addparam_result = groupSyncWriteAddParam(group_num, DXL3_ID, dxl_goal_position3(i), LEN_MX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL3_ID);
        return;
    end

    % Add Dynamixel#4 goal position value to the Syncwrite parameter storage
    dxl_addparam_result = groupSyncWriteAddParam(group_num, DXL4_ID, dxl_goal_position4(i), LEN_MX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL4_ID);
        return;
    end
    
      % Add Dynamixel#5 goal position value to the Syncwrite storage
    dxl_addparam_result = groupSyncWriteAddParam(group_num, DXL5_ID, dxl_goal_position5(i), LEN_MX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL5_ID);
        return;
    end

    % Add Dynamixel#6 goal position value to the Syncwrite parameter storage
    dxl_addparam_result = groupSyncWriteAddParam(group_num, DXL6_ID, dxl_goal_position6(i), LEN_MX_GOAL_POSITION);
    if dxl_addparam_result ~= true
        fprintf('[ID:%03d] groupSyncWrite addparam failed', DXL6_ID);
        return;
    end
    
    
    
   %%    Syncwrite goal position
    groupSyncWriteTxPacket(group_num);
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    end

    % Clear syncwrite parameter storage
    groupSyncWriteClearParam(group_num);
  %%
    while 1
        % Read Dynamixel#1 present position
        dxl1_present_position = read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL1_ID, ADDR_MX_PRESENT_POSITION);
        dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
        dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
        if dxl_comm_result ~= COMM_SUCCESS
            fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
        elseif dxl_error ~= 0
            fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
        end

        % Read Dynamixel#2 present position
        dxl2_present_position = read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL2_ID, ADDR_MX_PRESENT_POSITION);
        dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
        dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
        if dxl_comm_result ~= COMM_SUCCESS
            fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
        elseif dxl_error ~= 0
            fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
        end

%         fprintf('[ID:%03d] GoalPos:%03d  PresPos:%03d\t[ID:%03d] GoalPos:%03d  PresPos:%03d\n', DXL1_ID, DXL_MAXIMUM_POSITION_VALUE_i(1), dxl1_present_position, DXL2_ID, DXL_MAXIMUM_POSITION_VALUE_i(2), dxl2_present_position);

        if ~((abs(dxl_goal_position1(i) - dxl1_present_position) > DXL_MOVING_STATUS_THRESHOLD) || (abs(dxl_goal_position2(i) - dxl2_present_position) > DXL_MOVING_STATUS_THRESHOLD))
            break;
        end
    end


i=i+1;
if i > length(t)
    break
end

end

% Close port
closePort(port_num);

% Unload Library
unloadlibrary(lib_name);
end