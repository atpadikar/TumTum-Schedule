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
cas.stop = [01, 'H1';
            02, 'H32';
            03, 'H4';
            04, 'H5';
            05, 'H121314';
            06, 'H679';
            07, 'H11';
            08, 'H1516';
            09, 'Lib';
            10, 'SOM';
            11, 'KreSIT'; ];
            
        
 %Link 
%LinkNumber Stop1   Stop2  Distance
% cas.link = [
%     01, 
%          