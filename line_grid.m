function xg=line_grid(xm,nint,itype,param)

% line grid generator

% xm - coordinate marker for segments
% nint - number grid intervals for each segment
% itype - grid type for each segment
% param - parameters for each segment

% clear;clc;
% 
% xm = [0 13.5 14 16 17 40 60];
% nint = [ 15 9 50 18 139 25];
% itype = [202 101 101 101 203 201];
% param{1} = 0.06;
% param{2} = [];
% param{3} = [];
% param{4} = [];
% param{5} = [0.08 0.3];
% param{6} = 0.3;


nseg = numel(xm) - 1;

if numel(nint)~=nseg
    fprintf('number of intervals and coordiate markers mismatch\n');
    return;
end

if numel(itype)~=nseg
    fprintf('number of grid types and segments mismatch\n');
    return;
end

% net = sum(nint);     % total number of grid intervals/elements
% npt = net + 1; % total number of grid points

% ib= zeros(nseg,1); % segment beginning index
% ie= zeros(nseg,1); % segment end index
% ib(1) = 1;
% for i=2:nseg
%     ib(i) = ib(i-1)+nint(i-1);
%     ie(i-1) = ib(i);
% end 
% ie(nseg) = npt;

xg = xm(1); 


for i=1:nseg
    fprintf("segment %d\n",i);
    sg = segment_grid(xm(i),xm(i+1),nint(i),itype(i),param{i});
    xg = [xg sg(2:end)];
    fprintf('\n');
end


% plot
xc = (xg(1:end-1)+xg(2:end))/2;
dx = diff(xg);
figure;plot(xc,dx,'-o');

