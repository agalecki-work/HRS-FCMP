%macro populate_skip_array;

cout[1] = ;
cout[2] = ; 
 
%mend populate_skip_array;

/* ====== skip variables for all years =====*/

subroutine skip_9596(cout[*], cin[*]) group ="skip";
/* cout: skip_dress, skip_other */
 outargs cout;

  do i = 1 to 2;
    cout[i] = cin[i];
    if cin[1] in (.,-8) then cout[i] =.M;
    else if cin[2] = 5 then cout[i] = 1;
    else cout[i] = 0;
  end;

endsub; /*  skip_9596 */;

subroutine skip_9800(cout[*], cin[*]) group ="skip";
  outargs cout;
 
   ADLCK = cin[1] + cin[2] + cin[3] + cin[4] + cin[5] + cin[6] + cin[7] + cin[8] + cin[9] + cin[10];
   if cin[1] =. then cout[1] =.M;
   else if ADLCK =0 then cout[1] = 1;
   else cout[1] = 0;

   if cin[1] =. then cout[2] =.M;
   else if ADLCK =0 or (ADLCK =1 & cin[11] =5) then cout[2] = 1;
   else cout[2] = 0;

endsub; /*  skip_9800 */;

subroutine skip_02_xx(cout[*], cin[*]) group ="skip";
  outargs cout;

   if cin[1] in (.,-8) then cout[1] =.M;
   else if cin[2] = 0 then cout[1] = 1;
   else cout[1] = 0;

   if cin[1] in (.,-8) then cout[2] =.M;
   else if cin[2] = 0 or (cin[2] = 1 and cin[3] = 5) then cout[2] = 1;
   else cout[2] = 0;

endsub; /*  skip_02_xx */;

subroutine skip_sub(studyyr, cout[*], cin[*]) group ="skip";
/* `skip_sub` is invoked by `exec_vgrpx` subroutine in _binder.sas */
 outargs cout;

 select(studyyr);
   when (1995,1996)      call skip_9596(cout, cin);
   when (1998,2000)      call skip_9800(cout, cin);
   otherwise             call skip_02_xx(cout, cin);
 end;

endsub; /*subroutine skip_sub */;

function skip_vin(studyyr) $ group = "skip";
/* Function `skip_vin` is invoked by `dispatch_vin` function defined in _binder.sas`*/
 length vin $500;
 length cx $1;
 clist = upcase("hjklmnopqrstuvwxyz");
 length _tmpc $200; 
 _tmpc = "@G012 @G013 @G014";

 select (studyyr);
   when (1995) vin = "D1867 D1870";     
   when (1996) vin = "E1891 E1894";      
   when (1998) vin = "F2424_1 F2424_2 F2424_3 F2424_4 F2424_5 F2424_6 F2424_7 F2424_8 F2424_9 F2424_10 F2425"; 
   when (2000) vin = "G2722_1 G2722_2 G2722_3 G2722_4 G2722_5 G2722_6 G2722_7 G2722_8 G2722_9 G2722_10 G2723";
   otherwise 
     do; 
       wv = (studyyr - 2000)/2;
       cx = substr(clist,wv,1);
       vin = translate(_tmpc, cx, "@");
     end;
 end;

 return(vin);
endsub; /* function skip_vin */


