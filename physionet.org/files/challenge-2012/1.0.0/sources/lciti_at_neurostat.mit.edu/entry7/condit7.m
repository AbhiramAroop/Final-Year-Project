function [out] = condit(s, par)

pt_l = .01;
pt_u = .99;

if nargin == 1
    s = sort(s(isfinite(s)));
    s = s(round(length(s)*pt_l) : round(length(s)*pt_u));
    out.range = s([1 end]);
    ls = length(s);
    y = norminv(linspace(pt_l, pt_u, ls)');
    r = [ones(ls,1) s log(s+1)];
    if length(find(diff(s))) < 2 % less than 3 distinct values
        out.beta = [-mean(s); 1; 0] / (out.range(2) - out.range(1));
        return
    end
    out.beta = ((r' * r) \ (r' * y)) / 3;
else
    s = min(max(s, par.range(1)), par.range(2));
    beta = par.beta;
    r = [ones(length(s),1) s log(s+1)];
    out = r * beta;
end
