int: n;
array[0..n-1] of var 0..n-1: x;
 
 
% meta constraint
constraint forall( i in 0..n-1 )( sum([x[j] == i | j in 0..n-1]) = x[i] );

% the first implied constraint
constraint sum(x) = n;
% constraint sum(x[i]) = n;

% the second implied constraint
% constraint sum([x[i] * i | i in 0..n-1]) == n;
constraint sum(i in 0..n-1)(x[i]*i) == n; % equivalent to the one above

solve satisfy;

output [ "x = \(x);\n" ] ;
