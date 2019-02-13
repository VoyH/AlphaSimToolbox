function [cbfimg]=aslsimpsub(asltype, perfdat,M0img,Labeltime, Delaytime, Slicetime, labeff, brain_ind)
if Labeltime<10, Labeltime=Labeltime*1000;end
if Delaytime<10, Delaytime=Delaytime*1000;end;
if length(M0img)==1, UM0=1; else UM0=0; end
BloodT1=1490;
BloodT1=1650;
if asltype  % 1 for casl
    TI1=0;
else        % 0 for pasl
    TI1=700; 
end
r1a=1/BloodT1;
lambda=0.9*100*60;
qTI=0.8;
cbfimg=zeros(size(perfdat));
slicetimearray=ones(size(perfdat,1)*size(perfdat,2),size(perfdat,3));
for sss=1:size(perfdat,3)
    slicetimearray(:,sss)=slicetimearray(:,sss).*(sss-1)*Slicetime;    
end
slicetimearray=reshape(slicetimearray,size(perfdat,1),size(perfdat,2),size(perfdat,3));
slicetimearray=slicetimearray(brain_ind);
omega=TI1+Delaytime+slicetimearray;
tcbf=zeros(length(find(brain_ind)),1);
tperf=perfdat(brain_ind);
if UM0==0,  
    M0=M0img(brain_ind); 
    effidx=find(abs(M0)>1e-3*mean(M0(:)));
    omega=omega(effidx);
    effM0=M0(effidx);
    efftperf=tperf(effidx);
    efftcbf=efftperf./effM0;
else
    efftcbf=tperf./M0img;
end
if asltype   % casl or pcasl
     efftcbf=1000*lambda*efftcbf*r1a./(2*labeff* (exp(-omega*r1a)-exp( -(Labeltime+omega)*r1a) ) );  
else
    efftcbf=lambda*efftcbf*1000./(2.*exp(-omega/BloodT1)*TI1*labeff*qTI); 
end
if UM0==0
    tcbf(effidx)=efftcbf;
 else
     tcbf=efftcbf;
 end
 cbfimg(brain_ind)=tcbf;
return;