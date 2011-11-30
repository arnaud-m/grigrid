#!/usr/bin/awk --posix -f 
#~|#Items~|Capacity
{
    if (/^c [0-9]+ +ITEMS +[0-9]+ +CAPACITY/) {
	nbItems=$2;
	capa=$4;
    }
}
END{
    #printing instructions muste be in the END block
    printf " ~|%s~|%s", nbItems, capa;
}
