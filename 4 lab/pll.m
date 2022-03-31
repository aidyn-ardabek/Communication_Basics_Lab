function [out, state_out] = pll(in, N, state_in, table_size)

s = state_in;
out = zeros(size(in));
amp = 0;

for i = 1:N
    % Compute phase difference
    amp = amp + abs(in(i));
    z = in(i)/s.amp_est*s.out_old;
    v = s.a1*s.v_old + s.b0*z + s.b1*s.z_old;

    s.accum = s.accum + s.f - (s.k/(2*pi))*v;
    s.accum = s.accum - floor(s.accum);

    % Use cos_table to calculate output
    out(i) = s.cos_table(floor(table_size*s.accum) + 1);

    % Update state variables
    s.out_old = out(i);
    s.z_old = z;
    s.v_old = v;
end

% Take the average of the amplitude
s.amp_est = amp/N/(2/pi);
state_out = s;