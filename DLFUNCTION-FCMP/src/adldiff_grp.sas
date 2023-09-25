%macro populate_adldiff_array;

cout[1] = adldiff_dress;
cout[2] = adldiff_walk; 
cout[3] = adldiff_bath; 
cout[4] = adldiff_eat;
cout[5] = adldiff_bed; 
cout[6] = adldiff_toilt;
 
%mend populate_adldiff_array;

/* ====== adldiff variables for all years =====*/

subroutine adldiff_95_xx(studyyr, cout[*], cin[*]) group ="adldiff";
 outargs cout;
    
   adldiff_dress    = FQ_fun(studyyr, cin[1]);
   adldiff_walk     = FQ_fun(studyyr, cin[2]);
   adldiff_bath     = FQ_fun(studyyr, cin[3]);
   adldiff_eat      = FQ_fun(studyyr, cin[4]);
   adldiff_bed      = FQ_fun(studyyr, cin[5]);
   adldiff_toilt    = FQ_fun(studyyr, cin[6]);
   %populate_adldiff_array; /* Populate cout array */
 
endsub; /* subroutine adldiff_yrs */

subroutine adldiff_sub(studyyr, cout[*], cin[*]) group ="adldiff";
 outargs cout;

 call adldiff_95_xx(studyyr, cout, cin);

endsub; /*subroutine adldiff_sub */

function adldiff_vin(studyyr) $ group ="adldiff";

 length vin $500;
 length cx $1;
 clist = upcase("hjklmnopqrstuvwxyz");
 length _tmpc $200; 
 _tmpc = "@G014 @G016 @G021 @G023 @G025 @G030";

 select (studyyr);             
   when (1995) vin = "D1884 D1871 D1894 D1904 D1914 D1927";      
   when (1996) vin = "E1908 E1895 E1918 E1928 E1938 E1951";      
   when (1998) vin = "F2425 F2427 F2444 F2454 F2464 F2477"; 
   when (2000) vin = "G2723 G2725 G2742 G2752 G2762 G2775";
   otherwise 
     do; 
       wv = (studyyr - 2000)/2;
       cx = substr(clist,wv,1);
       vin = translate(_tmpc, cx, "@");
     end;
 end;
 put "FUN adldiff_vin(): studyyr=" studyyr ", vin=" vin;

 return(vin);
endsub; /* function adldiff_vin */
