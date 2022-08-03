clearvars

data_root = '/_space_/Temp/CinC/';
set_name='set-a'

lm_name = 'lm_feat_mis0'

fn_create_features_name = 'create_features';

nu = .56;
G = 10^-1.3;
kernel = 'poly';
degree = 2;

nu =    [ .56  .56  .56  .52  .52  .52];
G = 10.^[-1.7 -1.3  -.9 -1.7 -1.3  -.9];

use_probit = true;

missing = 0;

%BiasICUType = true;

%re_mean = true;

%re_condit = 'condit10';

%out_cls_sat  = 3;

%gaussianize_avg = true

%set_name_condit = 'set-b'

gentraining_step_last

