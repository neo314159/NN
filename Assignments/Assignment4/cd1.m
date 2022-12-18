function ret = cd1(rbm_w, visible_data)
% <rbm_w> is a matrix of size <number of hidden units> by <number of visible units>
% <visible_data> is a (possibly but not necessarily binary) matrix of size <number of visible units> by <number of data cases>
% The returned value is the gradient approximation produced by CD-1. It's of the same shape as <rbm_w>.
    %error('not yet implemented');
    
    %add this line to sample a state for each visible unit
    visible_data = sample_bernoulli(visible_data);
    
    hidden_state1 = sample_bernoulli( ...
                    visible_state_to_hidden_probabilities( ...
                    rbm_w, visible_data ) );
    visible_state2= sample_bernoulli( ...
                    hidden_state_to_visible_probabilities( ...
                    rbm_w, hidden_state1 ) );
    %hidden_state2 = sample_bernoulli( ...
    %                visible_state_to_hidden_probabilities( ...
    %                rbm_w, visible_state2 ) );
    
    %sampling from this hidden state does not change the mean of the gradient
    %but increases the variance, modify the code so as to use the probabilities
    hidden_state2 = visible_state_to_hidden_probabilities( ...
                    rbm_w, visible_state2 );
                    
    ret = configuration_goodness_gradient( visible_data, hidden_state1 ) - ...
          configuration_goodness_gradient( visible_state2, hidden_state2 );    
end
