include "globals.mzn";

int: M;     %number of machines = number of tasks
int: J;     %number of jobs
set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;
array[JOB,TASK] of MACH: machine;    % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines

int: total = sum(j in JOB, m in MACH)(duration[j, m]);
array[JOB, TASK] of var 0..total: s;
var 0..total: makespan;

% Disjunctive Constraints
constraint forall(m in MACH)(
    disjunctive([s[j, t] | j in JOB, t in TASK where machine[j, t] = m],
                duration[..,m])
);

% Precedence Constraints
constraint forall(j in JOB, t in 1..M-1)(
    s[j, t + 1] >= s[j, t] + duration[j, machine[j, t]]
);

% Makespan Constraint
constraint forall(j in JOB)(
    makespan >= s[j, M] + duration[j, machine[j, M]]
);

solve minimize makespan;
%solve::int_search(s, smallest, indomain_min) minimize makespan;
