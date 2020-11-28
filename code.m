Pathway = 5;
Sspeed = 1550;
cdepth = 100;

ipath{1} = phased.IsoSpeedUnderwaterPaths('ChannelDepth', cdepth, 'NumPathsSource', 'Property', 'NumPaths', Pathway, 'PropagationSpeed', Sspeed, 'BottomLoss', 0.5, 'TwoWayPropagation', true);
ipath{2} = phased.IsoSpeedUnderwaterPaths('ChannelDepth', cdepth, 'NumPathsSource', 'Property', 'NumPaths', Pathway, 'PropagationSpeed', Sspeed, 'BottomLoss', 0.5, 'TwoWayPropagation', true);
      
%%
fac = 20e3;   %  freq

cha{1} = phased.MultipathChannel('OperatingFrequency', fac);
cha{2} = phased.MultipathChannel('OperatingFrequency', fac);
                
obeject{1} = phased.BackscatterSonarTarget('TSPattern', -5*ones(181, 361));
obeject{2} = phased.BackscatterSonarTarget('TSPattern', -15*ones(181,361));
    
objplat{1} = phased.Platform('InitialPosition', [500; 500; -70], 'Velocity', [1; 3; 0]); 
objplat{2} = phased.Platform('InitialPosition', [500; 20; -40], 'Velocity', [2; 0; 0]);

figure(1) 
helperPlotPaths([0;0;-60],[500 500; 1000 0; -70 -40], cdepth,Pathway)

%%

RangeM = 5000;                         
ranRes = 10;                           
prof = Sspeed/(2*RangeM);            
pul_wid = 2*ranRes/Sspeed;      
pul_bw = 1/pul_wid;                
fs = 2*pul_bw;                         

wav = phased.RectangularWaveform('PulseWidth', pul_wid, 'PRF', prof, 'SampleRate', fs);

cha{1}.SampleRate = fs;
cha{2}.SampleRate = fs;

plato = phased.Platform('InitialPosition', [0; 0; -60], 'Velocity', [0; 0; 0]);
    
prooj = phased.IsotropicProjector('FrequencyRange', [0 30e3], 'VoltageResponse', 80, 'BackBaffled', true);
    
[ElPos,ElNor] = helperSphericalProjector(8,fac,Sspeed);

prArray = phased.ConformalArray('ElementPosition', ElPos, 'ElementNormal', ElNor, 'Element', prooj);

figure(2)

viewArray(prArray,'ShowNormals',true);

pattern(prArray, fac, -180:180, 0, 'CoordinateSystem', 'polar', 'PropagationSpeed', Sspeed);
        
hydrophobe = phased.IsotropicHydrophone( 'FrequencyRange', [0 30e3], 'VoltageSensitivity', -140);
   
rx = phased.ReceiverPreamp('Gain', 20, 'NoiseFigure', 10, 'SampleRate', fs, 'SeedSource', 'Property', 'Seed', 2007);

radi = phased.Radiator('Sensor', prArray, 'OperatingFrequency', fac, 'PropagationSpeed', Sspeed);
 
colr = phased.Collector('Sensor', hydrophobe, 'OperatingFrequency', fac, 'PropagationSpeed', Sspeed);
  
x = wav();    % Generate pulse
xmits = 10;
rx_pulses = zeros(size(x, 1), xmits);
t = (0:size(x, 1)-1)/fs;

for j = 1:xmits
%%\

%target 1
   ttd=0.5;
   filter1 = trackingUKF(@constvel,@cvmeas,[0;0;0;0;0;0],'Alpha',1e-2);
   meas = [500;1000;-70];
   
   for k=1:20
        ps(k,:)=predict(filter1,ttd);
        cs(k,:) = correct(filter1,meas);
   end
   
   figure(3)
   plot(ps(:,1), ps(:,3), '+', cs(:,1),cs(:,3), 'o')
   xlabel('Velocity')
   ylabel ('Position')
   title('Target 1 Movement')
   
   
   %target2
   ttd2=0.5;
   filter2 = trackingUKF(@constvel,@cvmeas,[0;0;0;0;0;0],'Alpha',1e-2);
   meas2 = [500;0;-40];
   
   for k2=1:20
        ps2(k2,:)=predict(filter2,ttd2);
        cs2(k2,:) = correct(filter2,meas2);      
   end
   
   figure(4)
   plot(ps2(:,1), ps2(:,3), '+', cs2(:,1),cs2(:,3), 'o')
   xlabel('Velocity')
   ylabel ('Position')
   title('Target 2 Movement')
   
    %  target and sonar position
    [so_pos,so_vel] = plato(1/prof);

    for i = 1:2 %Loop  
       [obj_pos,obj_vel] = objplat{i}(1/prof);

      % Compute transmission paths updated to CoherenceTime.
      [paaths,daop,aaloss,obAng,sAng] = ipath{i}(so_pos,obj_pos,so_vel,obj_vel,1/prof);
            

      % radiated signals.
      osig = radi(x,sAng);

      % Propagate radiated signals
      osig = cha{i}(osig,paaths,daop,aaloss);

      % Target
      osig = obeject{i}(osig,obAng);

      % Collector
      rsig = colr(osig,sAng);
      rx_pulses(:,j) = rx_pulses(:,j) + rx(rsig);
               
    end
end

figure
rx_pulses = pulsint(rx_pulses,'noncoherent');
figure(5)
plot(t,abs(rx_pulses))
grid on
xlabel('Tim')
ylabel('Amp')
title('Final Pulses')

