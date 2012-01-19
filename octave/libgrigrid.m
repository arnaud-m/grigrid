
#a function file

##--------------------------------------------------------------------
## Setup global variables
##--------------------------------------------------------------------

global FIRST_ROW=1;
global FIRST_COL=1;

global STATUS=1;
global OBJ=2;
global INIT_OBJ=3;
global LB=4;
global INIT_LB=5;
global NB_SOLS=6;
global TIME=7;
global NODE=8;
global BCK=9;

global THRESHOLD=2;

##--------------------------------------------------------------------
## Setup functions
##--------------------------------------------------------------------

function M=fread(filename) 
  global FIRST_ROW;
  global FIRST_COL;
  M=dlmread(filename, '|', FIRST_ROW, FIRST_COL);
endfunction

function str=basename(filename)
  s=rindex(filename, "/")+1;
  l=rindex(filename, '.');
  if (l == 0 ) 
    str=substr(filename, s);
  else 
    str =substr(filename, s, l-s);
  endif
 endfunction

 

 function R=findSAT(M)
  global STATUS;
  R=find( M(:,STATUS) == 0);
endfunction

  function R=findUNSAT(M)
  global STATUS;
  R=find( M(:,STATUS) == 2);
endfunction


function R=findUNKNOWN(M)
  global STATUS;
  R=find( M(:,STATUS) == 2);
endfunction


function R=findOPT(M)
  global STATUS;
  R=find( M(:,STATUS) == 1);
endfunction

function R=findOPT_CP(M)
  R=findOPT_CP(findOPT(M), M);
endfunction

function R=findOPT_CP(OPT, M)
  global INIT_LB; 
  global INIT_OBJ;
  R=OPT( find( M(OPT, INIT_OBJ).-M(OPT, INIT_LB)));
endfunction


