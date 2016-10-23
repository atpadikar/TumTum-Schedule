clear
load('data.mat');

X = 10 ;

   %% Static calculation starts here 
   
f = [ 0 0 0 0 0] ;   

           for e = 1:5 % calculation of f 
                %fill = 40 ;

            for l = 1:numel(route{e})


               for g = 1:1200

                   temp = temp + (1200-g)*cas.stop.stop(2,g,route{e}(l));
                   
               end
               
               f(e) = f(e) +  temp ;
               temp = 0; 

            end    

           end
           
DecAlloc = [0 0 0 0 0] ; % Allocation of buses in decimal format e.g. 1.2 which has to be changed into integers 
IntAlloc = [0 0 0 0 0 ] ; % Allocation of buses in Integers 
Sumf = f(1) + f(2) + f(3) + f(4) + f(5) ;

for e = 1:5
    DecAlloc(e) = (f(e)/Sumf)*X ;
end   


for e = 1:5
    IntAlloc(e) =  floor(DecAlloc(e)); % first part in changing decimal allocation to integer by finding closest integer
    DecAlloc(e) = DecAlloc(e) - IntAlloc(e) ; % now only decimal part remains   
end   

Y = X - (IntAlloc(1) +  IntAlloc(2)+ IntAlloc(3)+ IntAlloc(4)+  IntAlloc(5) ) ;
 
           
for x = 1:Y
    max = 0 ; max_e = 0 ;
    
              for e = 1:5              % second part in changing decimal allocation to integer by finding closest integer
                  
                if DecAlloc(e) > max 
                    max = DecAlloc(e) ; 
                    max_e = e ;  
                end
              end
                     
             if max_e ~= 0 
                  IntAlloc(max_e) = IntAlloc(max_e) + 1 ;
                  DecAlloc(max_e) = 0 ;
             end  
             
end              

Y = IntAlloc(1) +  IntAlloc(2)+ IntAlloc(3)+ IntAlloc(4)+  IntAlloc(5) ;

for e=1:5
    if IntAlloc(e) > 0
     for m = 1:IntAlloc(e)
         scheduleS = [scheduleS ;[10 + 5*(m-1) , Y , e ]]; % First value gives minutes after 8 when it starts for first time. Then repeats the route every 15 mins.    
         Y = Y -1 ;                                    % For a particular route multiple buses run after 5 mins of each other
         Total(e) = Total(e) + 1 ;
     end
    end 
end
     %% Static calculation ends here 
    
    
    
    
  


 for p = X+1:num_buses 
      q.add(p);
 end
    
    
  
for t = 1:t_max
    
    %i.e. for each timestep
    %% for each bus stop
        %add students: students are pre added in data. Access from
        %cas.stop.stop(<1=timeaxis,2=generated students>,timestamp,stop number)
     %% for each bus
        for i = X+1:num_buses
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
                     
                    if  (cas.bus(i,2)-cas.bus(i,3)) > 0 && cas.stop.stop(2,g,y) <= (cas.bus(i,2)-cas.bus(i,3)) 
                     % x = x + cas.stop.stop(2,g,y) ; 
                      cas.bus(i,3) = cas.bus(i,3) +  cas.stop.stop(2,g,y) ;
                      cas.stop.stop(2,g,y) = 0; 
                     
                    
                     elseif ( cas.bus(i,2)-cas.bus(i,3) ) > 0 && cas.stop.stop(2,g,y) > (cas.bus(i,2)-cas.bus(i,3))
                    %  x = x + cas.bus(i,2)-cas.bus(i,3) ; 
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
                        cas.bus(i,7) = route{cas.bus(i,4)}(nxt_tmp) ;
                        %Set time remaining to reach the destination
                        for lnk_idx = 1:num_links
                            if cas.bus(i,5) == cas.route.link(lnk_idx,2) && cas.bus(i,7) ==cas.route.link(lnk_idx,3)
                                cas.bus(i,8) = round(cas.route.link(lnk_idx,4)/speed_of_bus);
                                break
                            end
                        end
                        
                        cas.bus(i,9) = 1 ; 
                        
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
                        cas.bus(i,7) = route{cas.bus(i,4)}(nxt_tmp) ; 
                        %Set time remaining to reach the destination
                        for lnk_idx = 1:num_links
                            if cas.bus(i,5) == cas.route.link(lnk_idx,2) && cas.bus(i,7) ==cas.route.link(lnk_idx,3)
                                cas.bus(i,8) = round(cas.route.link(lnk_idx,4)/speed_of_bus);
                                break
                            end
                        end
                        
                        cas.bus(i,9) = 1 ; 
                        
                elseif cas.bus(i,9) == 2 &&( cas.bus(i,6) == 11 )        
                  cas.bus(i,3) = 0 ;
                  
                  
                        cas.bus(i,9) = 0 ; 
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
           %f = [-430.600 -611.800 -406.400 -432.900 -366.900 ] ; %-431.300 for 6 
           f = [ 0 0 0 0 0] ;
           for i = 1:5 % calculation of f 
                %fill = 40 ;

            for idx = 1:numel(route{i})


               for j = 1:t

                   temp = temp + (t-j)*cas.stop.stop(2,j,route{i}(idx)); 
               end    
               
               f(i) = f(i) +  temp ;
               temp = 0; 


            end    

           end  
           
           for o = 1:5
                  if busy(o) > 0
                      busy(o) = busy(o) -1 ;
                  end
           end   

           
           

          for m=1:5
              max = -1 ; max_i = 0;
              
             if q.isEmpty() == 0;  
              for k = 1:5 
                if f(k) > max && busy(k) <= 0
                    max = f(k) ; 
                    max_i = k ;  
                                  
                end
              end
                
             
              
               
              
             if max_i ~= 0
                  
             alloc = q.remove() ;
             cas.bus(alloc,4) = max_i ;
             busy(max_i) = 180  ;
             f(max_i) = 0 ;
             cas.bus(alloc,5) = cas.bus(alloc,6);
             cas.bus(alloc,7) = route{cas.bus(alloc,4)}(1) ; 
              
             %Set time remaining to reach the destination
                        for lnk_idx = 1:num_links
                            if cas.bus(i,5) == cas.route.link(lnk_idx,2) && cas.bus(i,7) ==cas.route.link(lnk_idx,3)
                                cas.bus(i,8) = round(cas.route.link(lnk_idx,4)/speed_of_bus);
                                break
                            end
                        end
                        
             cas.bus(alloc,9) = 1 ;
             cas.bus(alloc,8) = 200 ;
             num = num + 1 ;
             schedule = [schedule;[10 + floor(t/60) ,alloc, max_i ]]; % first value is time given by minutes after 8 
             Total(max_i) = Total(max_i) + 1 ;
             end
             else 
                 break ;
              end 
             
          end  
          

         end

     %% f value calculation ends here 
    
    
    
    
    
end

%for m=1:num
 %   schedule(m)       % output    
%end
for z=1:5
    TotalDistance = TotalDistance + Total(z)*Distance(z) ; 
end    

TotalDistance
clear t
