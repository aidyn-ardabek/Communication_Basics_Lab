function [state] = FIR_init(h, Ns)

% Creates a new FIR filter.

% Inputs:
%     h     Filter taps
%    Ns     Number of samples procesed per block 

% Outputs:
%   state   Initial state

% 1. Save parameters
state.h = h;
state.Ns=Ns;

% 2. Create state variables
% Make buffer big enough to hold Ns+Nh 
% coefficients. Make it an integer power
% of 2 so we can do simple circular indexing.

state.M=2.^(ceil(log2(Ns+1)));

% Get mask allowing us to wrap index easily
state.Mmask=state.M-1;

% Temporary storage for circular buffer
state.buff=zeros(state.M, 1);

% Set initial tail pointer and temp pointer
state.n_t=0;
state.n_p=0; 