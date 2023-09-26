function subhh_cfun(cin $) $ group = "subhh"; 
/* Invoked by `exec_vgrpc` function */
/* returns string of length of 1 without chnaging it */

 length res $1;
 res = cin;   /* -- subhh --*/;
 return(res);
endsub; /*  subhh_cfun */;

function subhh_vin(yr) $ group = "subhh";
/* Invoked by `dispatch_vin` function */
/* Based on `yr` function returns character string with an input variable name */

 length vin $500;
 length cx $1;
 clist = upcase("abcdefghjklmnopqrstuvwxyz");
 length _tmpc $200; 
 _tmpc = "@SUBHH";
 ;
 select; 
  when (1992 <= yr <= 1996) idx = yr - 1991;
  when (1998 <= yr <= 2030) idx = (yr -1996)/2 + 5; 
  otherwise;
 end;
 ;
 cx = substr(clist, idx, 1);
 vin = translate(_tmpc, cx, "@");
 return(vin);
endsub; /*  subhh_vin */;
