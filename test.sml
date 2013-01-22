
use "assignment_01.sml";


val date1 = (12,10,2012);
val date2 = (12,20,2012);
val date3 = (11,20,2012);
val strings = ["SML","IS","A","COOL","LANGUAGE"];


(* 1 *)
is_older(date1,date2) = true ;
is_older(date1,date3) = false ;


(* 2 *)
number_in_month([date1,date2,date3],12) = 2;

(* 3 *)
number_in_months([date1,date2,date3],[12]) = 2;
number_in_months([date1,date2,date3],[12,11]) = 3;


(* 4 *)
dates_in_month([date1,date2,date3],12) = [date1,date2];

(* 5 *)
dates_in_months([date1,date2,date3],[12]) = [date1,date2];
dates_in_months([date1,date2,date3],[12,11]) = [date1,date2,date3];

(* 6 *)
get_nth(strings,3) = "A";
get_nth(strings,4) = "COOL";
get_nth2(strings,3) = "A";
get_nth2(strings,4) = "COOL";

