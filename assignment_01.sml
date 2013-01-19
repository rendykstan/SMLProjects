(*   

   Using the library $SMLNJ-BASIS/basis.cm that comes with the SMLNJ .
   This library already has Date and Time functions build in.
	
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

