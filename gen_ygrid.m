
clear;clc;close all
dx = 1.25;

xm =    500+[ 0 50 100 150 500];
nint =  [   32 50  14  29];
itype = [ 203 101 301 201];

dX1 = 2;

param{1} = [dX1 dx*1.07];
param{2} = [dx];
param{3} = [dx*1.07,1.07,dX1];
param{4} = [dX1*1.07];



xg = line_grid(xm,nint,itype,param);

% mirror
xg_m = xm(end) - flip(xg);
xg = [xg_m xg(2:end)];


fprintf('total # of intervals %d\n',numel(xg)-1)

% plot
xc = (xg(1:end-1)+xg(2:end))/2;
dx = diff(xg);
figure;plot(xc,dx,'-o');


%% output
outdir = 'y256-1.0-2o';
mk_dir(outdir);
fid = fopen(fullfile(outdir,'ygrid.dat'),'w');
fprintf(fid,'%4d %24.15f\n',[1:numel(xg);xg]);

fclose(fid);