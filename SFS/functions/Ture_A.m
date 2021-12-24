S = zeros(1400,1440);
for i = 1:1440-71
    if mod(i-1,72) == 0
        S(i:i+72,i:i+72) = 1;
    end
end