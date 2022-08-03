function features = create_CCF( category, val )

    load('CCF.mat','MeanFeat');

    AllVars = {{'Age'},{'Height', 'Weight'},{'HR'}, {'Bilirubin'},{'BUN'},{'pH'},...
                {'Urine'},{'WBC'},{'Platelets'},{'HCT'},{'Creatinine'},{'Na'},{'K'},{'HCO3'},...
                {'RespRate','MechVent'},{'Temp'},{'GCS'},{'FiO2'},{'PaO2'},...
                {'DiasABP'},{'MAP'},{'NIDiasABP'},{'NIMAP'},{'NISysABP'},{'SysABP'}};		

    features = zeros(1,length(AllVars));

    for s=1:length(AllVars)	
        %Get data for the selected category only (If more than one name exist for the variables, merge data)
        saps_var=AllVars{s};
        sig_ind= val.*0;
        for i=1:length(saps_var)
            sig_ind=sig_ind | strcmp(saps_var(i),category);
        end
        tmp_data=val(sig_ind);

        if(strcmp(saps_var{1},'RespRate'))
            tmp_category=category(sig_ind);
            mech_vent_ind=find(strcmp(saps_var(2),tmp_category)==1);
            if(~isempty(mech_vent_ind) && any(mech_vent_ind))
                tmp_data=49;
            end
        end

        if(strcmp(saps_var{1},'Height'))
            if (tmp_data(2) == -1 || tmp_data(1) == -1)
                tmp_data = NaN;
            else
                tmp_data = tmp_data(2) / (tmp_data(1)/100)^2;
            end
        end
        features(s) = mean(tmp_data);

        if (isnan(features(s))) 
            features(s) = MeanFeat(s);
        end
    end

end

