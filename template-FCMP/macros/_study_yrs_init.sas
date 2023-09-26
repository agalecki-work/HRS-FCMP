%macro _study_yrs_init;
data  _study_yrs_init;
/* List of acceptable study years (it is fine to be inclusive) */
 do year = 1992 to 1996, 1998 to 2030 by 2;
  output;
 end;
run;
%mend _study_yrs_init;