
clear;clc;close all
dx = 1;

xm =    [ 0   470   535  921 4000];
nint =  [ 26   56   101 84];
itype = [ 202   101  301 301];

param{1} = dx;
param{2} = dx;
param{3} = [dx*1.05 1.05 4];
param{4} = [4.0*1.05,1.08,160];


xg = line_grid(xm,nint,itype,param);

fprintf('total # of intervals %d\n',numel(xg)-1)

%% output
outdir = 'x256-1.0';
mk_dir(outdir);
fid = fopen(fullfile(outdir,'xgrid.dat'),'w');
fprintf(fid,'%4d %24.15f\n',[1:numel(xg);xg]);

fclose(fid);






