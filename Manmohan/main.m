clear

%data creation
load('data.mat');

%buses object creation

%stop timemats

%simulation will run from 8:10:00 (not included) to 8:45 (included)
%at 8:10, t=0 del_t = 1 s
%Hence 8:45 = 35 min * 60 s = 2100;
%t_max generated in data.mat

import java.util.LinkedList
q = LinkedList();

f = [-430.600 -611.800 -406.400 -432.900 -366.900 -431.300] ; % precalcualted values using -c*d^p for all stops
fill = 0 ;
c = .001 ;
p= 2 ;
temp = 0;
  
for t = 1:t_max
    
    %i.e. for each timestep
    %for each bus stop
        %add students: students are pre added in data. Access from
        %cas.stop.stop(<1=timeaxis,2=generated students>,timestamp,stop number)
    %for each bus
        %WRITE CODE HERE
    %SCHEDULE NEW BUSES
    
 if q.isEmpty()== 0    
   for i = 1:6 % calculation of f 
        fill = 40 ;
        
    for idx = 1:numel(route{i})% should be routei 
        
   
       for j = 1:t
           
          if fill > 0 &&  fill - cas.stop.stop(2,j,route{i}(idx)) >= 0
           temp = temp + (t-j)*cas.stop.stop(2,j,route{i}(idx));
           %cas.stop.stop(2,j,cas.route.route1(idx)) = 0 ;
           fill = fill - cas.stop.stop(2,j,route{i}(idx));
           
          elseif fill > 0 &&  fill - cas.stop.stop(2,j,route{i}(idx)) < 0
              temp = temp + (t-j)*fill ;
              cas.stop.stop(2,j,route{i}(idx)) = cas.stop.stop(2,j,route{i}(idx)) - fill ;
              fill = 0;
              break ;
          end 
       end    
       f(i) = f(i) +  temp ;
       temp = 0; 
       
        
    end    
    
   end  
    
   max = -500 ; max_i = 0;
   
   for m=1:6
     if q.isEmpty() == 0;  
         
      for k = 1:6
        if f(i) > max
            max = f(i) ; 
            max_i = i ;         
        end
      end
     alloc = q.remove() ;
     cas.bus(alloc,4) = max_i ; 
     cas.bus(alloc,6) = 1 ; 
     f(max_i) = -500 ; 
     
     else 
         break ;
     end    
  end  
   % f value calculation ends here 
    
 end
   
    
    
    
    
    
    
end
clear t
        
