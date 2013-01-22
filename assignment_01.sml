val months = [Date.Jan,Date.Feb,Date.Mar,Date.Apr,Date.May,Date.Jun,Date.Jul,Date.Aug,Date.Sep,Date.Oct,Date.Nov,Date.Dec];
fun make_date(month:int,day:int,year:int) =
  let
    val new_date = {day=day,hour=19,minute=27,month=List.nth(months,month-1),offset=NONE,second=23,year=year};
   in
       Date.date new_date
   end
(*

   Using the library $SMLNJ-BASIS/basis.cm that comes with the SMLNJ .
   This library already has Date and Time functions build in.
*)

(*

val is_older = fn : (int * int * int) * (int * int * int) -> bool
val number_in_month = fn : (int * int * int) list * int -> int
val number_in_months = fn : (int * int * int) list * int list -> int
val dates_in_month = fn : (int * int * int) list * int -> (int * int * int) list
val dates_in_months = fn : (int * int * int) list * int list -> (int * int * int) list
val get_nth = fn : string list * int -> string
val date_to_string = fn : int * int * int -> string
val number_before_reaching_sum = fn : int * int list -> int
val what_month = fn : int -> int
val month_range = fn : int * int -> int list
val oldest = fn : (int * int * int) list -> (int * int * int) option

*)

(* 1 *)
fun is_older(date1 : (int * int * int), date2: (int * int * int)) =
    let
      val d1 = make_date(#1 date1,#2 date1, #3 date1);
      val d2 = make_date(#1 date2,#2 date2, #3 date2);
    in
      if Date.compare(d1,d2) = LESS
      then true
      else false
    end

(* 2 *)
fun number_in_month(dates : (int * int * int) list, nmonth : int) =
	let fun month_check( date : (int * int * int)) =
	   if Date.month((make_date date)) = List.nth(months,nmonth-1)
	   then 1
	   else 0
	in
		if null dates
   		then 0
   		else month_check(hd dates) + number_in_month( tl dates, nmonth)
	end

(* 3 *)
fun number_in_months(dates : (int * int * int) list, nmonths : int list) =
         if null dates orelse null nmonths
         then 0
         else number_in_month(dates , hd nmonths) + number_in_months(dates , tl nmonths )

 (* 4 *)
 fun dates_in_month(dates : (int * int * int) list, nmonth : int) =
 	let fun month_check( date : (int * int * int)) =
	   if Date.month((make_date date)) = List.nth(months,nmonth-1)
	   then [date]
	   else []
	in
		if null dates
   		then []
   		else month_check(hd dates) @ dates_in_month( tl dates, nmonth)
	end


(* 5 *)
fun dates_in_months(dates : (int * int * int) list, nmonths : int list) =
         if null dates orelse null nmonths
         then []
         else dates_in_month(dates , hd nmonths) @ dates_in_months(dates , tl nmonths )

(* 6
   There is a List.nth() function in the SMLNJ Library for this already !
  *)

fun get_nth(strings : string list, n : int) =
  let fun count_up_to(shorter_strings : string list,i : int) =
    if i = n
    then hd shorter_strings
    else count_up_to(tl shorter_strings,i + 1)
  in
     if null strings
     then hd strings
     else count_up_to(strings,1)
  end
fun get_nth2(strings : string list, n : int) =
   List.nth(strings, n-1 )