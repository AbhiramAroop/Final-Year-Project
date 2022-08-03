function m = count_motifs_newdata( Matrix, motif_length, num_bins, all_bin_cuts, motifs )

    % discretize each feature (equiprobable bins across all patients'
    % values), special value for missing data
    Matrix = discretize_matrix( Matrix, num_bins, all_bin_cuts );
    
    % count motifs for each patient and build into a matrix with feature
    % names
    m = count_motifs_single_patient( Matrix, motif_length, num_bins, motifs );
    
end

function N = discretize_matrix( M, num_bins, all_bin_cuts )

    F = size(M,1);
    N = ones(size(M))*num_bins;
    
    % get the cumulative distribution for each feature
    for f=1:F  
        bin_cuts = all_bin_cuts{f};
        
        % convert continuous values into discrete ones
        % special value for NaNs
        for c=num_bins+1:-1:2
           N(f,M(f,:) <= bin_cuts(c)) = c-1;
        end
        N(f,isnan(M(f,:))) = 0;    
    end
    
end


function m = count_motifs_single_patient( M, motif_length, num_bins, motifs )

    F = size(M,1);
    m = zeros(1,length(motifs)*F);
    num_symbols = num_bins + 1;
    
    reverse_mux = [];
    for a=motif_length-1:-1:0
        reverse_mux(end+1) = num_symbols^a;
    end
    
    % for each feature, count all motifs and store frequencies in m
    for f=1:F
        offset = (f-1)*length(motifs);
        for a=1:size(M,2)-motif_length+1
            code = (reverse_mux*(M(f,a:a+motif_length-1))')+1;
            motif_idx = offset + code;
            m(motif_idx) = m(motif_idx) + 1;
        end
    end

end


