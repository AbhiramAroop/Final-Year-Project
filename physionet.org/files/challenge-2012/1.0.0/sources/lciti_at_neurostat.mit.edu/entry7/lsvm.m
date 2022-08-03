function [model, options] = lsvm(y, X, options)

% Based on
% http://jmlr.csail.mit.edu/papers/volume9/chechik08a/chechik08a.pdf

% Kernels as functions of the inner (dot) product
kernels.LINEAR = @(xx,par) (xx);
kernels.POLY = @(xx,par) (par(1)*xx + 1).^par(2);

X_nan = isnan(X);
X_orig = X;
X(X_nan) = 0;

if isstruct(y)
    model = y;
    par = [model.G model.degree];
    k = kernels.(upper(model.kernel));
    coef = model.sv_coef;
    si = 1;
    if model.Missing
        if model.Missing == -1
            bsv = abs(coef) < max(coef);
            for i = 1:size(X, 1)
                SVs = model.SVs(:,~X_nan(i,:));
                model.rho(i,1) = mean(k(SVs(bsv,:) * SVs', par) * coef - sign(coef(bsv)));
            end
        elseif model.Missing == -2
            y = zeros(size(X, 1), 1);
            svm_opt = struct('nu', model.nu, 'G', model.G, 'degree', model.degree, 'kernel', model.kernel, 'Missing', 0, 'si', []);
            for i = 1:length(y)
                m = lsvm(model.y, model.X(:,~X_nan(i,:)), svm_opt);
                y(i) = (k(X(i,~X_nan(i,:)) * m.SVs', par) * m.sv_coef) - m.rho;
            end
            model = y;
            return
        else
            coef = coef ./ model.si;
            [w2i, w2] = inst_spec(~X_nan, kernels, model.kernel, par, model.SVs, coef);
            si = w2i / w2;
        end
    end
    y = (k(X * model.SVs', par) * coef) ./ si - model.rho;
    model = y;
    return
end


model.kernel = options.kernel;
model.G = options.G;
model.degree = options.degree;
model.nu = options.nu;
model.Missing = options.Missing;

par = [model.G model.degree];
k = kernels.(upper(model.kernel));
Q = k(X * X', par);
if options.Missing && ~isempty(options.si)
    Q = Q ./ (options.si * options.si');
end
m = libsvmtrain(y, [(1:length(Q))' Q], sprintf('-q -t 4 -c 1 -s 1 -n %e', options.nu));
%m = libsvmtrain(y, [(1:length(Q))' Q], sprintf('-q -t 4 -c %e', options.C));
model.sv_coef = m.sv_coef * m.Label(1);
model.rho = m.rho * m.Label(1);
model.iSVs = m.SVs;
model.SVs = X(model.iSVs,:);

if model.Missing == -2
    model.X = X;
    model.y = y;
end

if options.Missing && ~isempty(options.si)
    model.si = options.si(model.iSVs);
end

if options.Missing > 1
    [b, n, n] = unique(~X_nan, 'rows'); %#ok<*ASGLU>
    [w2i, w2] = inst_spec(b, kernels, model.kernel, par, model.SVs, model.sv_coef);
    options.si = max(min(sqrt(w2i(n) / w2), 1), eps);
    options2 = setfield(options, 'Missing', options.Missing-1); %#ok<SFLD>
    model = lsvm(y, X_orig, options2);
    return
end

end % main function


function [w2i, w2] = inst_spec(b, kernels, kernel, par, sv, coef)
switch upper(kernel)
    case 'LINEAR'
        w = coef' * sv;
        w2 = w * w';
        w2i = b * (w'.^2);
    otherwise
        if 1 && strcmpi(kernel, 'POLY') && par(2) == 2 % quadratic
            sv = flatten(sv, kernel, par);
            b = flatten(b, kernel, par);
            [w2i, w2] = inst_spec(b, kernels, 'LINEAR', par, sv, coef);
            return
        end
        k = kernels.(upper(kernel));
        for i = size(b, 1):-1:1
            Is{i,1} = bsxfun(@times, b(i,:), sv);
        end
        fn = @(x) (coef' * k(x * sv', par) * coef);
        w2i = cellfun(fn, Is, 'UniformOutput', true);
        w2 = coef' * k(sv * sv', par) * coef;
end
end


function x = flatten(x, kernel, par)
% only flattens poly2 for now
if islogical(x)
    x = [x true(size(x,1),1)];
    x = bsxfun(@and, x, permute(x, [1 3 2]));
else
    x = [sqrt(par(1))*x ones(size(x,1),1)];
    x = bsxfun(@times, x, permute(x, [1 3 2]));
end
x = x(:,:);
end
