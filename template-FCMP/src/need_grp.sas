%macro populate_need_array;

cout[1] = need_meds;

%mend populate_need_array;

/* ====== need variables for all years =====*/

subroutine need_95_xx(cout[*], cin[*]) group ="need";
 outargs cout;
 
   cout[1] = cin[1];
   select(cin[1]);
	 when(5) cout[1] = 0;
	 when(7) cout[1] =.O;     
     when(8) cout[1] =.D;
     when(9) cout[1] =.R;
	 when(.) cout[1] =.M;
     otherwise;
   end;

endsub; 

subroutine need_sub(studyyr, cout[*], cin[*]) group ="need";
 outargs cout;

 call need_95_xx(cout, cin);

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
 **put "FUN need_vin(): studyyr=" studyyr ", vin=" vin;

 return(vin);
endsub; /* function need_vin */
