include "diffn.mzn";
include "cumulative.mzn";
  
int: n;
int: w;
int: h;
set of int: NRECTS = 1..n;
array [NRECTS] of int: ws;
array [NRECTS] of int: hs;
array [NRECTS] of var 0..w-1: xs;
array [NRECTS] of var 0..h-1: ys;

% constraints to make sure each rectangle fits inside

constraint forall( i in NRECTS ) ( xs[i] + ws[i] <= w );
constraint forall( i in NRECTS ) ( ys[i] + hs[i] <= h ); 

% no overlap naive

constraint forall(i in NRECTS, j in NRECTS where i < j) (
  xs[i] + ws[i] <= xs[j] \/ xs[j] + ws[j] <= xs[i] \/
  ys[i] + hs[i] <= ys[j] \/ ys[j] + hs[j] <= ys[i] );
  
% global constraint
constraint diffn(xs, ys, ws, hs);

% implied constraint (to explain... also why it's wrong to use it instead of diffn)
constraint cumulative(xs, ws, hs, h);
constraint cumulative(ys, hs, ws, w);
 

solve satisfy;
