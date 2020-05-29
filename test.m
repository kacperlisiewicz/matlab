A = eye(2);



  
f = @(t) t.^2 + 2.^0.5 * abs(1-t) + 2 .* (1 + t) .* (1 + (1-t).^2).^0.5;
## znajdz min funkcji
