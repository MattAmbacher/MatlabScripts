function [ref_K, ref_53, ref_3] = make_slopes(height, K_left, K_right)
ref_K = K_left:K_right;
ref_53 = height/K_left^(-5/3) * ref_K.^(-5/3);
ref_3 = height/K_left^(-3) * ref_K.^(-3);
end