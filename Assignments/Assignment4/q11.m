#Q11

function q11 = q11(rbm_w)
   A = dec2bin(0:2^10-1)-'0';
   q11 = log( sum( prod( 1 + exp( rbm_w' * A' ) ) ) );
end

%To compute the the partition function Z we have to compute
%Z = sum_over_all_hidden_and_visible_state_combinations( e^( - E( v, h ) ) )
%For each hidden state, hi, its contribution to the sum is
%
%sum_over_all_visible_state_combinations( e^(-E(v,hi=0))+e^(-E(v,hi=1)) )
%
%since units are binary.
%The first term in each sumand is 0 and the second term is
%
%e^(-E(v,h=1)) = e^w1i + ... + e^wmi + e^(w1i+w2i) + ... + e^(w(m-1)i+wmi) + 
%    ... + e^(w1i+...+wmi) [1]
%
%assuming there are m visible units. This can be expressed as 
%
%e^(-E(v,h=1)) = prod_over_all_visible_units_j( 1 + e^wji ) [2]
%
%and then 
%Z = sum_over_all_hidden_state_combinations( prod_over_all_visible_units_j( 1 + e^wji ) )
%
%
%Implementation details.
%
%We use the matrix A to represent a binary combination matrix with all hidden 
%unit combinations.
%rbm_w' * A' generates a [num_visible_units] x [num_hidden_unit_combinations]
%matrix that has in each column the exponents corresponding to expression [1]
%for each hidden unit combination.
%Then the prod over columns computes [2] and the sum of this result computes Z.
%Finally we compute the resulting log (base e) of the partition function.

   