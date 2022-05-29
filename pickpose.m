function [current_reading1,DEVICENAME]=pickpose(x)
clc;


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
    [notfound, warnings] = loadlibrary(lib_name, 'dynamixel_sdk.h', 'addheader', 'port_handler.h', 'addheader', 'packet_handler.h');
end

% Control table address
ADDR_MX_TORQUE_ENABLE       = 24;           
ADDR_MX_PRESENT_POSITION    = 36;
PROTOCOL_VERSION            = 1.0;         
BAUDRATE                    = 1000000;
DEVICENAME                  = x;                                               
TORQUE_ENABLE               = 1;            
COMM_SUCCESS                = 0;           
% Initialize PortHandler Structs
% Set the port path
port_num = portHandler(DEVICENAME);

% Initialize PacketHandler Structs
packetHandler();
current_reading=[];

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
% while 1
for DXL_ID=1:6

    % Enable Dynamixel Torque
    write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
    dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
    dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
    if dxl_comm_result ~= COMM_SUCCESS
        fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
    elseif dxl_error ~= 0
        fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
    else
        fprintf('Dynamixel has been successfully connected \n');
    end
    
     
%         while 1
            % Read present position
            dxl_present_position = read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_PRESENT_POSITION);
            dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
            dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
            if dxl_comm_result ~= COMM_SUCCESS
                fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
                
            elseif dxl_error ~= 0
                fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
            end
      
  
    


 current_reading= [current_reading [dxl_present_position]];
 fprintf('%d ', current_reading);

end
current_reading1=current_reading;
% Close port
closePort(port_num);

% Unload Library
unloadlibrary(lib_name);

close all;
% clear all;

end