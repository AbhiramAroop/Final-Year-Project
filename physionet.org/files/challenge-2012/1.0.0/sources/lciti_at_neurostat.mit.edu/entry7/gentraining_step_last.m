
neg2pos = 6; % negative to positive ratio


fn_create_features = str2func(fn_create_features_name);
if 1 %~exist('feat', 'var')
    if ~exist('set_name_condit', 'var')
        load([data_root filesep set_name '_SubjC.mat']); % SubjectsC and Condit
    else
        load([data_root filesep set_name_condit '_SubjC.mat']); % SubjectsC and Condit
        load([data_root filesep set_name '_Subj.mat']); % Subjects
        [SubjectsC, Condit] = condit_subject(Subjects, Condit);
    end

    for s = length(SubjectsC):-1:1
        feat(s,:) = fn_create_features(SubjectsC(s));
        target(s,1) = -1 + 2 * (SubjectsC(s).IHD > 0);
        d = SubjectsC(s).Desc;
        ICUType(s,:) = [d.ICUType1 d.ICUType2 d.ICUType3 d.ICUType4] > 0;
    end
end
target01 = target > 0;

LM = struct();
LM.Condit = Condit;
LM.use_probit = use_probit;
LM.lm_name = lm_name;
LM.fn_create_features_name = fn_create_features_name;

if exist('re_mean', 'var') && re_mean
    feat_nan = isnan(feat);
    feat(feat_nan) = 0;
    LM.re_mean = bsxfun(@rdivide, sum(feat, 1), sum(~feat_nan, 1));
    feat = bsxfun(@minus, feat, LM.re_mean);
    feat(feat_nan) = NaN;
end

if exist('re_condit', 'var') && ~isempty(re_condit)
    LM.re_condit.fn = re_condit;
    condit_fn = str2func(re_condit);
    for i = 1:size(feat, 2)
        LM.re_condit.Condit(i) = condit_fn(feat(:,i));
        feat(:,i) = condit_fn(feat(:,i), LM.re_condit.Condit(i)); %#ok<SAGROW>
    end
end

if ~exist('kernel', 'var')
    degree = 2;
    kernel = 'poly';
end
nu = nu .* ones(1,neg2pos);
G = G .* ones(1,neg2pos);

% find positive and negative examples
neg = find(~target01);
pos = find(target01);

for cls = 1:neg2pos

    ok = sort([pos; neg(cls:neg2pos:end)]);
    target_cv = target(ok);
    feat_cv = feat(ok,:);

    svm_opt = struct('nu', nu(cls), 'G', G(cls), 'degree', degree, 'kernel', kernel, 'Missing', missing, 'si', []);
    LM.m{cls} = lsvm(target_cv, feat_cv, svm_opt);

end

out_cls = zeros(length(target), neg2pos);
for b = 1:2
    test = [pos(b:2:end); neg(b:2:end)];
    train_pos = pos(3-b:2:end);
    train_neg = neg(3-b:2:end);
    clear m
    for cls = 1:neg2pos
        train = [train_pos; train_neg(cls:neg2pos:end)];
        svm_opt = struct('nu', nu(cls), 'G', G(cls), 'degree', degree, 'kernel', kernel, 'Missing', missing, 'si', []);
        m = lsvm(target(train), feat(train,:), svm_opt);
        out_cls(test,cls) = lsvm(m, feat(test,:));
    end
end

if isnumeric(use_probit)
    for cls = neg2pos:-1:1
        c = condit10(out_cls(:,cls));
        LM.beta0(cls,:) = c.beta;
    end
    if exist('gaussianize_avg', 'var') && gaussianize_avg
        LM.beta0 = repmat(mean(LM.beta0, 1), neg2pos, 1);
    end
    for cls = neg2pos:-1:1
        c.beta = LM.beta0(cls,:)';
        out_cls(:,cls) = condit10(out_cls(:,cls), c);
    end
end

if exist('out_cls_sat', 'var')
    out_cls = min(max(out_cls, -out_cls_sat), out_cls_sat);
    ML.out_cls_sat = out_cls_sat;
end

if ~exist('out_cls_unsrt', 'var') || ~out_cls_unsrt
    out_cls = sort(out_cls, 2);
    out_cls_unsrt = false;
end
LM.out_cls_unsrt = out_cls_unsrt;

if exist('BiasICUType', 'var') && BiasICUType
    feat = [ICUType out_cls];
    LM.BiasICUType = true;
else
    feat = [ones(size(out_cls,1),1) out_cls];
    LM.BiasICUType = false;
end

if use_probit
    LM.beta = glmfit(feat, target01, 'binomial', 'link', 'probit', 'constant', 'off');

    prob = normcdf(feat * LM.beta);
    disp('probit')
else
    LM.beta = glmfit(feat, target01, 'binomial', 'link', 'logit', 'constant', 'off');
    prob = 1 ./ (1 + exp(-feat * LM.beta));
    disp('logit')
end
%prob = .005 + .99 * prob;
prob = max(.001, min(.999, prob));

for i = 1:4
ii = true | find(ICUType) == i;
srt = sortrows([prob(ii) target01(ii)], -1);
m1 = cumsum(srt(:,2)) ./ max(1:length(srt), sum(target01(ii)))';
M1 = max(m1);
ix = round(mean(find(m1 == M1)));
LM.prob_th(i) = srt(ix,1);
end

save(lm_name, '-struct', 'LM', '-v7')
