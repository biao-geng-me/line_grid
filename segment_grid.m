function sg=segment_grid(x1,x2,n,itype,para)


sg = zeros(1,n+1); % segment grid
sg(1) = x1;
sg(n+1) = x2;
L = x2 - x1;
switch itype
    case 101 % uniform, interval size 
        dx = para(1);
        n = round(L/dx);
        dx = L/n;
        fprintf('uniform dx=%g\n',dx);

        sg = zeros(1,n+1); % segment grid
        sg(1) = x1;
        sg(n+1) = x2;
        for i=2:n
            sg(i) = sg(i-1) + dx;
        end

    case 102 % 
        
    case 201 % geometric, nint, first length
        dx = para;
        k = solve_geometric_ratio_201(L,n,dx);
        fprintf('ratio k=%g\n',k);
        for i=2:n
            sg(i) = sg(i-1) + dx;
            dx = dx*k;
        end

    case 202 % geometric, nint, last length
        dx = para;
        k = solve_geometric_ratio_201(L,n,dx);
        fprintf('ratio k=%g\n',k);
        for i=n:-1:2
            sg(i) = sg(i+1) - dx;
            dx = dx*k;
        end

    case 203 % geometric, first length, last length
        dx1=para(1);dx2=para(2);
        k = (dx2/dx1)^(1/(n-1));
        Ls = (dx1-dx2*k)/(1-k); 
        % scale length
        r = Ls/L;
        fprintf('k=%g,scale ratio %g\n',k,1/r);
        dx = dx1/r;
        for i=2:n
            sg(i) = sg(i-1) + dx;
            dx = dx*k;
        end
        if abs(r-1)>1e-3
            q=(L-dx1)/(L-dx2);
            ns = log(dx2/dx1)/log(q)+1;
            ns = ceil(ns);
            fprintf('dx1=%g,dx2=%g,n=%d,q=%g\n',dx1,dx2,n,q);
            fprintf('suggested # of intervals %d\n',ns);
        end 
    case 301 % geometric, first length, ratio, maximum length (size function)
        fprintf('using size function\n');

        sg = x1;
        dx1 = para(1); k= para(2); dx_max = para(3);
        %
        dx = dx1;
        Ls = 0;
        count = 0;
        while Ls < L
            Ls = Ls + dx;
            
            count = count + 1;
            sg(count+1) = sg(count) + dx;
            dx = dx * k;
            if dx > dx_max
                dx = dx_max;
            end
        end
        % scale length
        r = Ls/L;
        sg = (sg-x1) / r + x1;
        fprintf('dx1=%g,dx2=%g,q=%g\n',dx1/r,sg(end)-sg(end-1),k);
        
    otherwise
        fprintf('grid specification type %d not supported\n',itype);
end

fprintf('# of intervals %d\n',numel(sg)-1);
end

%%
function q=solve_geometric_ratio_201(L,n,dx)
% 
    if n<=1
        fprintf('too few intervals! n=%d\n',n);
        return
    end

    func = @(k) dx*(k^n-1)/(k-1) - L;
    q = fzero(func,1.1);

end



