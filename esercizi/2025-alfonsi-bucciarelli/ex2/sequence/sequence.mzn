include "global_cardinality.mzn";

int: n;
array[0..n-1] of var 0..n-1: x;

% base constraint
constraint forall(i in 0..n-1)(x[i] = sum(j in 0..n-1) (x[j] = i)); 

%global constraint
constraint global_cardinality(x, array1d(0..n-1, 0..n-1), x);

% the first implied constraint
constraint sum(x) = n;

% the second implied constraint
constraint sum(i in 0..n-1) (x[i]* i) = n;

solve satisfy;

output [ "x = \(x);\n" ] ;