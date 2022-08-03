function mhat = kernel_regress(X_new, X, Y, h)
% get estimates for Y_new for the points in X_new (rows) using kernel
% regression. only valid for 1-dimensional data

    if size(X_new,1) < size(X_new,2)
        X_new = X_new';
    end
    if size(X,1) < size(X,2)
        X = X';
    end
    if size(Y,1) < size(Y,2)
        Y = Y';
    end

    mhat = zeros(length(X_new),1);
    for a=1:length(X_new)
        total = (1/sqrt(2*pi))*exp(-0.5*(((X-X_new(a))/h).^2));
        mhat(a) = (total'*Y)/sum(total);
    end
end

function k = gaussian_kernel(u, v)
    k = (1/sqrt(2*pi))*exp(-0.5*(norm(u-v)^2));
end