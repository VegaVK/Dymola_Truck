% For loading 3 loop data from Jun6  into Dymola

load('VelRef_009.mat');
RawData=rec1_009;
 Range1=[1:length(RawData.X(1).Data)];

TimeForSeries=RawData.X(1).Data(Range1);
TimeForSeries=TimeForSeries-TimeForSeries(1,1);
%%
% SteeringInTRW =[TimeForSeries',(((double(RawData.Y(293).Data(Range1)))/1)+0)']; % TRW Counter
% SteeringInSTR =[TimeForSeries',(double(RawData.Y(170).Data(Range1))+0)'];% Steering wheel
% This already takes care of offset
CurrentVelocity = [TimeForSeries',(double(RawData.Y(14).Data(Range1)))'];
CurrentAccel = [TimeForSeries',(double(RawData.Y(78).Data(Range1)))'];
TargetVelocity = [TimeForSeries',(double(RawData.Y(2).Data(Range1)))'];
ThrottleIn = [TimeForSeries',(double(RawData.Y(76).Data(Range1))/100)'];
% GearIn=[TimeForSeries',double((RawData.Y(107).Data(Range1)))']; % Selected gear, not current gear
EngRPM_Coll=[TimeForSeries',RawData.Y(87).Data(Range1)'];
% Coll_Yaw=[TimeForSeries',RawData.Y(301).Data(Range1)'];
Vel_Data_m_s=[TimeForSeries',(RawData.Y(14).Data(Range1))'];
% ActualTrq=[double(TimeForSeries)',double(RawData.Y(1350).Data(Range1).*(2304/100))'];
% ClutchSwitch=[double(TimeForSeries)',double(RawData.Y(667).Data(Range1).*(2304/100))'];
% for brake data
Urgency =[TimeForSeries',double(RawData.Y(66).Data(Range1))'];
DecelDes=[TimeForSeries',(double(RawData.Y(95).Data(Range1)).*double(RawData.Y(94).Data(Range1)))'];
%% For VelRefControlSim
CommandedVel=[TimeForSeries',double((RawData.Y(2).Data(Range1)))']; % Selected gear, not current gear
GearIn=[TimeForSeries',double((RawData.Y(107).Data(Range1)))']; % Selected gear, not current gear
% Attempt to adjust for clutch
GearIn(1:end-50,2)=GearIn(51:end,2);
%% Plot Commanded Vs Actual
figure; hold on; grid on;
plot(CommandedVel(:,1),CommandedVel(:,2));
plot(Vel_Data_m_s(:,1),Vel_Data_m_s(:,2));
legend('Target','Experimental');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
%% Compare All three
figure; hold on; grid on;
plot(CommandedVel(:,1),CommandedVel(:,2));
plot(Vel_Data_m_s(:,1),Vel_Data_m_s(:,2));
plot(Sim_Vel.Time,Sim_Vel.Data);
legend('Target','Experimental','Simulation');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
%% Plot throttle
figure; hold on; grid on;
plot(ThrottleIn(:,1),100.*ThrottleIn(:,2));

% legend('Target','Experimental','Simulation');
xlabel('Time (s)');
ylabel('Throttle (%)');
%% Plot long Accel
figure; hold on; grid on;
plot(TimeForSeries,RawData.Y(78).Data(Range1));
plot(Accel1.Time, Accel1.Data);
% plot(Accel2.Time, Accel2.Data);
legend('Experimental','Target','Calculated Target');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
%% Compare All three ERRORS
figure; hold on; grid on;
% plot(CommandedVel(:,1),CommandedVel(:,2));
plot(Vel_Data_m_s(:,1),Vel_Data_m_s(:,2)-CommandedVel(:,2));
plot(Sim_Vel.Time,Sim_Vel.Data-Sim_TargetVel.Data);
legend('Error in Experiment','Error in Simulation');
xlabel('Time (s)');
ylabel('Errors in Velocity(m/s)');
%% Comparing desired decel from sim
figure; hold on; grid on;
plot(Sim_DesiredDecel.Time,Sim_DesiredDecel.Data);
%% compare simulated and Actual gear numbers
figure; hold on; grid on;
plot(Sim_CurrentGear.Time,Sim_CurrentGear.Data);
plot(GearIn(:,1),GearIn(:,2));
legend('Simulated','Experimental');
xlabel('Time (s)');
ylabel('Gear Number Currently Engaged');