classdef Bus
    %defining class named Bus
    properties
        %defining instance variables attached with this class
        capacity; %max no. of seats available
        seatsFilled; %seats taken
        seatsEmpty; %seats empty
        routeNo; %which route is it on
        stopNo; %stop no. if it is at firstStop; %starting stop of the bus
        busIndex; %we're numbering bus for tracking purpose,
                  %so the index has been assigned to each bus
        startStop; %starting stop no. within a route
        endStop=0; %stopping stop no. next to start stop
        firstStop; %starting stop of a route
        waitingTime=0; %total waiting time of the bus
        enrouteTime=0; %total journey time (including waiting time)
        direction = 'up'; %up or down
    end
    
    methods
        function obj = Bus(busIndex,capacity, routeNo,cas)
            obj.capacity = capacity;
            obj.busIndex = busIndex;
            obj.routeNo = routeNo;
            if routeNo==1
                obj.startStop = cas.route.route1(1);
                obj.stopNo = cas.route.route1(2);
                obj.firstStop = cas.route.route1(1);
            elseif routeNo==2
                obj.startStop = cas.route.route2(1);
                obj.stopNo = cas.route.route2(2);
                obj.firstStop = cas.route.route2(1);
            elseif routeNo==3
                obj.startStop = cas.route.route3(1);
                obj.stopNo = cas.route.route3(2);
                obj.firstStop = cas.route.route3(1);
            elseif routeNo==4
                obj.startStop = cas.route.route4(1);
                obj.stopNo = cas.route.route4(2);
                obj.firstStop = cas.route.route4(1);  
            elseif routeNo==5
                obj.startStop = cas.route.route5(1);
                obj.stopNo = cas.route.route5(2);
                obj.firstStop = cas.route.route5(1);    
            elseif routeNo==6
                obj.startStop = cas.route.route6(1);
                obj.stopNo = cas.route.route6(2);
                obj.firstStop = cas.route.route6(1);    
            end
            obj.seatsFilled = 0;
            obj.seatsEmpty = capacity - obj.seatsFilled;
        end
        %%%%%%%%%%%%%%%%%
        function output = noOfSeatsFilled(obj)
            output = obj.seatsFilled;
        end
        %%%%%%%%%%%%%%%
        function output = noOfSeatsEmpty(obj)
            output = obj.capacity - obj.seatsFilled;
        end
        %%%%%%%%%%%%%%%
        function output = isAllSeatsFilled(obj)
            if(obj.capacity==obj.seatsFilled)
                output = 1;
            else
                output = 0;
            end
        end
        %%%%%%%%%%%%%%%%%
        
        
        function output = currentStopNo(obj)
            output = obj.stopNo;
        end
        
        
    end
    
end
            