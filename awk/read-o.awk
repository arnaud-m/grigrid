#!/usr/bin/awk -f
#Instance~|Status~|Obj~|Init. Obj.~|LB~|Init. LB~|#Sol.~|Time(s)~|#Nodes~|#Backtracks|ILB Gap
BEGIN {
  tab[1] = -2;
}
{
    if (/^c (MINIMIZE|MAXIMIZE) /) {
	tab[0] = $4;
    }
    else if (/^c CSP[ \t]*(FIRST_SOLUTION|ALL_SOLUTIONS) /) {
	tab[0] = $5;
    }
    else if (/^s UNSUPPORTED[ \t]*$/) {
	tab[1] = -1; 
    } 
    else if (/^s SATISFIABLE[ \t]*$/) {
	tab[1] = 0;
    }
    else if (/^s OPTIMUM(_FOUND)?[ \t]*$/) {
	tab[1] = 1;
    }
    else if (/^s UNSATISFIABLE[ \t]*$/) {
	tab[1] = 2;
    }
    else if (/^s UNKNOWN[ \t]*$/) {
	tab[1] = 3;
    }
    else if (/^s TIMEOUT[ \t]*$/) {
	tab[1] = 4;
    }
    else if (/^d OBJECTIVE /) {
	tab[2] = $3;
    }
    else if (/^d INITIAL_OBJECTIVE /) {
	tab[3] = $3;
    }
    else if (/^d LOWER_BOUND /) {
	tab[4] = $3;
    }
    else if (/^d INITIAL_LOWER_BOUND /) {
	tab[5] = $3;
    }
    else if (/^d NBSOLS /) {
	tab[6] = $3;
    }
    else if (/^d RUNTIME /) {
	tab[7] = $3;
    }
    else if (/^d NODES /) {
	tab[8] = $3;
    }
    else if (/^d BACKTRACKS /) {
	tab[9] = $3;
    }
    else if (/^d ILB_GAP /) {
	tab[10] = $3;
    }
}

END {
    printf tab[0];
    for (x = 1; x <= 10; x++) {
	printf " ~|%s", tab[x]
    }
}
