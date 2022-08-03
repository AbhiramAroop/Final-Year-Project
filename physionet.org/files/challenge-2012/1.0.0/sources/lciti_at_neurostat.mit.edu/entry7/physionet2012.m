function [prob,died]=physionet2012(tm,category,val)

LM = load('lm_feat_mis0');

Subject = import_subject(tm,category,val);

SubjectC = condit_subject(Subject, LM.Condit);
d = SubjectC.Desc;
ICUType = [d.ICUType1 d.ICUType2 d.ICUType3 d.ICUType4] > 0;

fn_create_features = str2func(LM.fn_create_features_name);
feat = fn_create_features(SubjectC);

if isfield(LM, 're_mean')
    feat = feat - LM.re_mean;
end

if isfield(LM, 're_condit')
    condit_fn = str2func(LM.re_condit.fn);
    for i = 1:size(feat, 2)
        feat(:,i) = condit_fn(feat(:,i), LM.re_condit.Condit(i)); %#ok<SAGROW>
    end
end


for cls = length(LM.m):-1:1
    out_cls(1,cls) = lsvm(LM.m{cls}, feat);
end

if isnumeric(LM.use_probit)
    for cls = length(LM.m):-1:1
        c.beta = LM.beta0(cls,:)';
        out_cls(:,cls) = condit10(out_cls(:,cls), c);
    end
end

if isfield(LM, 'out_cls_sat')
    out_cls = min(max(out_cls, -LM.out_cls_sat), LM.out_cls_sat);
end

if ~isfield(LM, 'out_cls_unsrt') || ~LM.out_cls_unsrt
    out_cls = sort(out_cls, 2);
end

if isfield(LM, 'BiasICUType') && LM.BiasICUType
    feat = [ICUType out_cls];
else
    feat = [1 out_cls];
end

%
p = feat * LM.beta;
if LM.use_probit
    prob = normcdf(p);
else
    prob = 1 ./ (1 + exp(-p));
end
%prob = .005 + .99 * prob;
prob = max(.001, min(.999, prob));

died = prob > LM.prob_th(ICUType);
