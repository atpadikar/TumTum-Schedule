%bus data
%bus_no capacity filled_cap current_route current_pos
cas.bus = [ 01,  40, 0,  0,  0;
            02,  40, 0,  0,  0;
            03,  40, 0,  0,  0;
            04,  40, 0,  0,  0;
            05,  40, 0,  0,  0;
            06,  40, 0,  0,  0;
            07,  40, 0,  0,  0;
            08,  40, 0,  0,  0;
            09,  40, 0,  0,  0;
            10,  40, 0,  0,  0;
            11,  40, 0,  0,  0;
            12,  40, 0,  0,  0;
            13,  40, 0,  0,  0;
            14,  40, 0,  0,  0;
            15,  40, 0,  0,  0; ];
        
%Stop Data
%Stop_Number Stop_Name
% cas.stop = [01, 'H1';
%             02, 'H32';
%             03, 'H4';
%             04, 'H5';
%             05, 'H121314';
%             06, 'H679';
%             07, 'H11';
%             08, 'H1516';
%             09, 'Lib';
%             10, 'SOM';
%             11, 'KreSIT'; ];

%probability function (pdf) = at^2 + bt + c till t = 0 to 15
%                           = dt^2 + et + f till t=15 to 35
%                             and both are equal to p at t =15.
%t is measured with respect to 8:10.
%So peak at 8:25 i.e. t=15, peak/2 at 8:15 (t=5) and 8:30 (t=20)
%StopNumber students a b c d e f p
cas.stop.gen = [ %general info about stops
    01, 350, -0.0312558139534885,1.09395348837209,0,0.0312558139534883,-2.03162790697674,32.8186046511628,9.37674418604651;
    02, 700, -0.0625116279069771,2.18790697674419,0,0.0625116279069767,-4.06325581395349,65.6372093023255,18.7534883720930;
    03, 600, -0.0535813953488375,1.87534883720930,0,0.0535813953488371,-3.48279069767442,56.2604651162790,16.0744186046512;
    04, 350, -0.0312558139534885,1.09395348837209,0,0.0312558139534883,-2.03162790697674,32.8186046511628,9.37674418604651;
    05, 1000, -0.0893023255813958,3.12558139534884,0,0.0893023255813952,-5.80465116279070,93.7674418604650,26.7906976744186;
    06, 1000, -0.0893023255813958,3.12558139534884,0,0.0893023255813952,-5.80465116279070,93.7674418604650,26.7906976744186;
    07, 350, -0.0312558139534885,1.09395348837209,0,0.0312558139534883,-2.03162790697674,32.8186046511628,9.37674418604651;
    08, 2000, -0.178604651162792,6.25116279069768,0,0.178604651162790,-11.6093023255814,187.534883720930,53.5813953488372;
    09, 0, 0, 0, 0, 0, 0, 0, 0 ;
    10, 0, 0, 0, 0, 0, 0, 0, 0 ;
    11, 0, 0, 0, 0, 0, 0, 0, 0 ;
    ];

cas.stop.stop = zeros(2,2100,11);%contains the student generation matrix in
%here, with row 1 as the timestamp and row 2 as the students generated at
%that time. Second dimention (2100) is the time stamps. Third dimention is
%the bus stop number.
for i=1:11
    for t=1:15*60
        cas.stop.stop(2,t,i) = (cas.stop.gen(i,3)*(t/60)^2 + cas.stop.gen(i,4)*(t/60))/60;
        if cas.stop.stop(2,t,i)<0
            cas.stop.stop(2,t,i)=0;
        end
        cas.stop.stop(1,t,i) = t;
    end
    for t=15*60+1:35*60
        cas.stop.stop(2,t,i) = (cas.stop.gen(i,6)*(t/60)^2 + cas.stop.gen(i,7)*(t/60) + cas.stop.gen(i,8))/60;
        if cas.stop.stop(2,t,i)<0
            cas.stop.stop(2,t,i)=0;
        end
        cas.stop.stop(1,t,i) = t;
    end
end


 %Link 
%LinkNumber Stop1   Stop2  Distance

%     01, 
%Signifies a list of stop numbers for each route.          
cas.route.route1 = [05 06 07 10 11];
cas.route.route2 = [05 06 04 03 02 01 09 10 11];
cas.route.route3 = [08 09 10 11];

%LinkNumber (From)Stop1   (To)Stop2  Distance(metres)
cas.route.link = [
                        01, 04, 03, 240;%h5->h4
                        02, 03, 02, 120;%h3->h2-3
                        03, 02, 01, 200;%h2-3->h1
                        04, 01, 09, 110;%h1->lib
                        05, 08, 09, 200;%h15->lib
                        06, 05, 06, 220;%h12->h7
                        07, 06, 04, 270;%h7->h5
                        08, 04, 07, 230,%h5->h11
                        09, 09, 10, 600;%lib-som
                        10, 07, 10, 500;%h11-som
                        11, 10, 11, 080;%som-kresit
                        
                        ];
                        
                        
