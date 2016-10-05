clear

%data creation
load('data.mat');
cumulativeDistance = 0;
schedule = [0,0,0] ; % [time , Bus no, route no]
num = 0 ;
x=0 ;
y=0;

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

num_buses = size(cas.bus,1);
num_links = size(cas.route.link,1);
  
for t = 1:t_max
    
    %i.e. for each timestep
    %% for each bus stop
        %add students: students are pre added in data. Access from
        %cas.stop.stop(<1=timeaxis,2=generated students>,timestamp,stop number)
     %% for each bus
        for i=1:num_buses
            if cas.bus(i,9) == 1%On road bus. bus(i,9) checks status, 1 is on road
                cas.bus(i,8) = cas.bus(i,8) - 1; %reduce time remaining to next stop by 1
                if cas.bus(i,8) <= 0% which means bus has reached next stop
                    %update bus status
                        cas.bus(i,9) = 2;%onstop
                        cas.bus(i,6) = cas.bus(i,7);%current pos = next stop
                        %Find the distance to add in the cumulative
                    %distance from the link thing:Add to cumDist
                        for tmp = 1:num_links
                            if cas.bus(i,5) == cas.route.link(tmp,2) && cas.bus(i,7) == cas.route.link(tmp,3)
                                cumulativeDistance = cumulativeDistance + cas.route.link(tmp,4);
                                break
                            end
                        end 
                    %if acad area bus, calculate total students boarding
                    %off
                        if cas.bus(i,6) == 09 
                            cas.bus(i,10) = round(0.05*cas.bus(i,3));
                        elseif cas.bus(i,6) ==10
                            cas.bus(i,10) = round(0.65*cas.bus(i,3));
                        elseif cas.bus(i,6) ==11
                            cas.bus(i,10) = cas.bus(i,3);
                        end
                end
            elseif cas.bus(i,9) == 2 && cas.bus(i,6) ~= 09 && cas.bus(i,6) ~= 10 && cas.bus(i,6) ~= 11 %At stop bus. bus(i,9) checks status, 2 is at stop
                y= cas.bus(i,6);
                
                %Remove/Add students
               % if cas.bus(i,8)>= 1200
                %    x= cas.stop.gen(y,2)*[ cas.stop.gen(y,3)*t*t+cas.stop.gen(y,4)*t+cas.stop.gen(y,5)];
                %elseif cas.bus(i,8)<1200
                 %    x= cas.stop.gen(y,2)*[ cas.stop.gen(y,6)*t*t+cas.stop.gen(y,7)*t+cas.stop.gen(y,8)];
                 x =0 ;
                for g = 1:t 
                     
                    if ( (cas.bus(i,2)-cas.bus(i,3) > 0 && cas.stop.stop(2,g,y) <=cas.bus(i,2)-cas.bus(i,3) )
                      x = x + cas.stop.stop(2,g,y) ; 
                      cas.stop.stop(2,g,y) = 0; 
                      cas.bus(i,3) = cas.bus(i,3) +  cas.stop.stop(2,g,y) ;
                     
                    
                     elseif ( (cas.bus(i,2)-cas.bus(i,3) > 0 && cas.stop.stop(2,g,y) > cas.bus(i,2)-cas.bus(i,3) )
                      x = x + cas.bus(i,2)-cas.bus(i,3) ; 
                      cas.stop.stop(2,g,y) = cas.stop.stop(2,g,y) - cas.bus(i,2)+cas.bus(i,3); 
                      cas.bus(i,3) = cas.bus(i,2)   ;
                      break; 
                    end 
                 end   
                    
                     
                    % if (x-cas.bus(i,10))< (cas.bus(i,2)-cas.bus(i,3))
                        
                        % cas.bus(i,3)=cas.bus(i,3)+x-cas.bus(i,10);
                         cas.bus(i,5)=cas.bus(i,6);
                         %to find next stop
                        nxt_tmp = 0;
                        routelength_tmp = length(route{cas.bus(i,4)});
                        for tmp = 1:(routelength_tmp -1)
                            if route{cas.bus(i,4)}(tmp) == cas.bus(i,6) 
                                nxt_tmp = tmp + 1;
                                break
                            end
                        end
                        cas.bus(i,7) = route{cas.bus(i,4)}(nxt_temp) ; 
                        cas.bus(i,9) == 1 ; 
                        
                   %  elseif (x-cas.bus(i,10))>(cas.bus(i,2)-cas.bus(i,3))
                       
                   %  elseif x==0
              elseif cas.bus(i,9) == 2 &&( cas.bus(i,6) == 09 || cas.bus(i,6) == 10 ) %Bus stop where students get down          
                  
                  
                  cas.bus(i,3) = cas.bus(i,3) - cas.bus(i,10) ;
                  cas.bus(i,5) = cas.bus(i,6);
                  nxt_tmp = 0;
                        routelength_tmp = length(route{cas.bus(i,4)});
                        for tmp = 1:(routelength_tmp -1)
                            if route{cas.bus(i,4)}(tmp) == cas.bus(i,6) 
                                nxt_tmp = tmp + 1;
                                break
                            end
                        end
                        cas.bus(i,7) = route{cas.bus(i,4)}(nxt_temp) ; 
                        cas.bus(i,9) == 1 ; 
                        
                elseif cas.bus(i,9) == 2 &&( cas.bus(i,6) == 11 )        
                  cas.bus(i,3) = 0 ;
                  
                  
                        cas.bus(i,9) == 0 ; 
                        q.add(i) ; 
                    %Remove if acad area
                        %if no students to be removed further, run the
                        %required code
                    %Add if hostels
                        %if no students to be removed further, run the
                        %required code
                        
                      
                            
                    %If students further transporting = 0 (Read flag)
                    %change prev stop and next stop
                    %change status: either to moving or inactive(if last
                    %stop)
                        %changed to moving:
                        %calculate remaining time
                        %changed to inactive
                        %add to que of inactive buses
            end
        end
        
    %% SCHEDULE NEW BUSES
    
    
    
    %% f starts here 
         if q.isEmpty()== 0    
           f = [-430.600 -611.800 -406.400 -432.900 -366.900 -431.300] ;
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
                      %cas.stop.stop(2,j,route{i}(idx)) = cas.stop.stop(2,j,route{i}(idx)) - fill ;
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
             cas.bus(alloc,9) = 1 ;
             num = num + 1 ;
             schedule(num) = [10 + floor(t/60) ,alloc, max_i ] ; % first value is time given by minutes after 8 
             f(max_i) = -500 ; 

             else 
                 break ;
             end    
          end  
          

         end

     %% f value calculation ends here 
    
    
    
    
    
end

for m=1:num
    schedule(m)       % output    
end
clear t
