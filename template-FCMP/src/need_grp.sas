
/* ====== need variables for all years =====*/

function need_95_xx(vin) group ="need";
 
 select(vin);
   when(5) vout = 0;
   when(7) vout =.O;     
   when(8) vout =.D;
   when(9) vout =.R;
   when(.) vout =.M;
   otherwise;
 end;
 return(vout);  /* `need_meds` */
endsub; 

subroutine need_sub(studyyr, cout[*], cin[*]) group ="need";
 outargs cout;
 cout[1] = need_95_xx(cin[1]);
endsub; /*subroutine need_sub */

function need_vin(studyyr) $ group ="need";

 length vin $500;
 length cx $1;
 clist = upcase("hjklmnopqrstuvwxyz");
 length _tmpc $200; 
 _tmpc = "@G051";

 select (studyyr);                 
   when (1995) vin = "";      
   when (1996) vin = ""; 
   when (1998) vin = "F2578";
   when (2000) vin = "G2876";
   otherwise 
     do; 
       wv = (studyyr - 2000)/2;
       cx = substr(clist,wv,1);
       vin = translate(_tmpc, cx, "@");
     end;
 end;

 return(vin);
endsub; /* function need_vin */
