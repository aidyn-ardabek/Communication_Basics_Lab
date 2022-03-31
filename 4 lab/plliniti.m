function [s] = plliniti(f, D, k, w0, T, table_size)

% Parameters
s.f = f;            % Nominal ref. frequency
s.D = D;            % Damping factor
s.k = k;            % Loop gain
s.w0 = w0;          % Loop corner frequency
s.T = T;            % Period

% Look up table
for i = 0:table_size-1
    s.cos_table(i+1) = cos(2*pi*i/table_size);
end

% Filter coeficients
s.tau1 = k/w0^2;
s.tau2 = 2*D/w0 - 1/k;
s.a1 = -(s.T - 2*s.tau1) / (s.T + 2*s.tau1);
s.b0 = (s.T + 2*s.tau2) / (s.T + 2*s.tau1);
s.b1 = (s.T - 2*s.tau2) / (s.T + 2*s.tau1);

% Create state variables
s.out_old = 0.0;
s.z_old = 0.0;
s.v_old = 0.0;
s.accum = 0.0;
s.amp_est = 1;