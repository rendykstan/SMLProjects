
use "assignment_01.sml";


val date1 = (12,10,2012);
val date2 = (12,20,2012);
val date3 = (11,20,2012);
val strings = ["SML","IS","A","COOL","LANGUAGE"];

(*
   This is my test file for assignment 1

   all the fuctions are tested for truth

   function(arguments) should = expectation

*)

(* 1 val is_older = fn : (int * int * int) * (int * int * int) -> bool *)

is_older(date1,date2) = true ;
is_older(date1,date3) = false ;


(* 2 val number_in_month = fn : (int * int * int) list * int -> int *)

number_in_month([date1,date2,date3],12) = 2;

(* 3 val number_in_months = fn : (int * int * int) list * int list -> int *)

number_in_months([date1,date2,date3],[12]) = 2;
number_in_months([date1,date2,date3],[12,11]) = 3;


(* 4 val dates_in_month = fn : (int * int * int) list * int -> (int * int * int) list *)

dates_in_month([date1,date2,date3],12) = [date1,date2];

(* 5 val dates_in_months = fn : (int * int * int) list * int list -> (int * int * int) list *)

dates_in_months([date1,date2,date3],[12]) = [date1,date2];
dates_in_months([date1,date2,date3],[12,11]) = [date1,date2,date3];

(* 6 val get_nth = fn : string list * int -> string *)

get_nth(strings,3) = "A";
get_nth(strings,4) = "COOL";
get_nth2(strings,3) = "A";
get_nth2(strings,4) = "COOL";

(* 7 val = date_to_string = fn : int * int * int -> string *)

date_to_string(date3) = "November 20, 2012";


(* 8 val number_before_reaching_sum = fn : int * int list -> int *)

number_before_reaching_sum(7,[1,2,3,4,5,6,7,8,9]) = 6;
number_before_reaching_sum(8,[1,2,3,4,5,6,7,8,9]) = 6;
number_before_reaching_sum(9,[1,2,3,4,5,6,7,8,9]) = 6;
number_before_reaching_sum(10,[1,2,3,4,5,6,7,8,9]) = 6;
number_before_reaching_sum(11,[1,2,3,4,5,6,7,8,9]) = 10;
number_before_reaching_sum(16,[1,2,3,4,5,6,7,8,9]) = 15;
number_before_reaching_sum(20,[1,2,3,4,5,6,7,8,9]) = 15;
number_before_reaching_sum(21,[1,2,3,4,5,6,7,8,9]) = 15;
number_before_reaching_sum(22,[1,2,3,4,5,6,7,8,9]) = 21;

