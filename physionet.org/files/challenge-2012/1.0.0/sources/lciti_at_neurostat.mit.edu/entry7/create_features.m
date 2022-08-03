function [feat] = create_features(subjc)

epochs = [0 24*3600; 24*3600 48*3600+1];

feat = struct2array(subjc.Desc);

ts = subjc.TSeries;
f2 = fieldnames(ts);
for i2 = 1:length(f2)
    vals_ep = [];
    v = ts.(f2{i2});
    for i = 1:size(epochs,1)
        t = v(:,1);
        vals = [v(epochs(i,1) <= t & t < epochs(i,2), 2); NaN]; % add nan to account for missing values in min and max
        vals_ep(i,:) = [min(vals) mean(vals(~isnan(vals))) max(vals)]; %#ok<AGROW>
    end
    missing = isnan(vals_ep(:,1));
    vals_ep(missing,:) = repmat(mean(vals_ep(~missing,:), 1), sum(missing), 1); %#ok<AGROW>
    vals_ep = vals_ep';
    feat = [feat vals_ep(:)']; %#ok<AGROW>
%     for i = 1:size(epochs,1)
%         t = v(:,1);
%         vals = [v(epochs(i,1) <= t & t < epochs(i,2), 2); NaN]; % add nan to account for missing values in min and max
%         feat = [feat min(vals) mean(vals(~isnan(vals))) max(vals)]; %#ok<AGROW>
%     end
end
