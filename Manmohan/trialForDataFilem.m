data;
a = cas.route.route1;
bus1 = Bus(1,50,1,cas);
stop = zeros(2,2100,11);
toatlStrength=zeros(1,11);
for i=1:11
    for t=1:15*60
        stop(2,t,i) = (cas.stop(i,3)*(t/60)^2 + cas.stop(i,4)*(t/60))/60;
        if stop(2,t,i)<0
            stop(2,t,i)=0;
        end
        toatlStrength(i) = toatlStrength(i) + stop(2,t,i);
        stop(1,t,i) = t;
    end
    for t=15*60+1:35*60
        stop(2,t,i) = (cas.stop(i,6)*(t/60)^2 + cas.stop(i,7)*(t/60) + cas.stop(i,8))/60;
        if stop(2,t,i)<0
            stop(2,t,i)=0;
        end
        toatlStrength(i) = toatlStrength(i) + stop(2,t,i);
        stop(1,t,i) = t;
    end
end