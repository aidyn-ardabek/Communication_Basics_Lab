function[state_out, y] = FIR(state_in, x)
% [state_out, y] = fir(state_in, x);

% Executes the FIR block.

% Inputs:
%   state_in        Input state
%      x            Samples to process

% Outputs:
%   state_out       Output state
%      y            Processed samples

% Get state
s = state_in;

% Move samples into tail of buffer
for ii=0:length(x)-1
    % Store a sample
    s.buff(s.n_t+1)=x(ii+1);
    
    % Increment head index (circular)
    s.n_t=bitand(s.n_t+1, s.Mmask);
    s.n_p=bitand(s.n_t+s.Mmask, s.Mmask);
    sum=0.0;
    for j=0:length(s.h)-1
        sum=sum+s.buff(s.n_p+1)*s.h(j+1);
        s.n_p=bitand(s.n_p+s.Mmask, s.Mmask);
    end
    y(ii+1)=sum;
end

% Return updated state
state_out = s;