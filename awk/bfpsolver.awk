#!/usr/bin/awk --posix -f 
#~|#Postponed ~|#Pops
{
    if (/^d POSTPONED /) {
	postponed=$3;
    }
    else if (/^d POP /) {
	pops=$3;
    }
}
END{
    #printing instructions muste be in the END block
    printf " ~|%s~|%s", postponed, pops;
}
