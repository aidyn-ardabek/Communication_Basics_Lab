table_size = 1024;
[s] = plliniti(0.1, 1, 1, 2*pi/100, 1, table_size);

Ns = 100;       % Number of samples
Nb = 10;        % Number of blocks

load('ref_800hz.mat');
in = reshape(ref_in, Ns, Nb);

out = zeros(Ns, Nb);
y_input = ref_in;

% Changing the amplitude of the input
for i = 1:1000
    y_input(i) = 1.5*y_input(i);
    in(i) = 1.5*in(i);
end

for n = 1:Nb
    [out(:, n), s] = pll(in(:, n), Ns, s, table_size);
%     plot(1:length(in(:, n)), in(:, n), 1:length(in(:, n)), out(:, n));
%     pause(1);
end

y_output = reshape(out, Ns*Nb, 1);

plot(1:length(y_input), y_input);
hold on;
plot(1:length(y_output), y_output);
ylim([-2, 2])