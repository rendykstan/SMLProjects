(*   

   Using the library $SMLNJ-BASIS/basis.cm that comes with the SMLNJ .
   This library already has Date and Time functions build in.
	"Wed Mar 08 19:06:45 1995"
*)
(* 1 *)
fun is_older(date1 : Date.date, date2 : Date.date) =
    if Date.compare(date1,date2) = LESS
    then true
    else false
(* 2 *)
fun number_in_month(dates : Date.date list, month : Date.month) =
	let fun month_check( date : Date.date) =
	   if Date.month(date) = month
	   then 1
	   else 0
	in 
		if null dates
   		then 0
   		else month_check(hd dates) + number_in_month( tl dates, month)
	end
(* 3 *)
fun number_in_months(dates : Date.date list, months : Date.month list) =
         if null dates
         then 0
         else number_in_month(dates , hd months) + number_in_months(dates , tl months )
 (* 4 *)
 fun dates_in_month(dates : Date.date list, month : Date.month) =
 	let fun month_check( date : Date.date) =
	   if Date.month(date) = month
	   then [date]
	   else []
	in 
		if null dates
   		then []
   		else month_check(hd dates) @ dates_in_month( tl dates, month)
	end
(* 5 *)
fun dates_in_months(dates : Date.date list, months : Date.month list) =
         if null dates
         then []
         else dates_in_month(dates , hd months) @ dates_in_months(dates , tl months )
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
   List.nth(strings : string list, n : int)