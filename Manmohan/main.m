clear

%data creation
load('data.mat');

%buses object creation

%stop timemats

%simulation will run from 8:10:00 (not included) to 8:45 (included)
%at 8:10, t=0 del_t = 1 s
%Hence 8:45 = 35 min * 60 s = 2100;
%t_max generated in data.mat
for t = 1:t_max
    %i.e. for each timestep
    %for each bus stop
        %add students: students are pre added in data. Access from
        %cas.stop.stop(<1=timeaxis,2=generated students>,timestamp,stop number)
    %for each bus
        %WRITE CODE HERE
    %SCHEDULE NEW BUSES
    
    
    
    
end
clear t
        
