fun pow(x : int, y : int) =
  if y = 0
  then 1
  else x * pow(x,y-1)

fun is_older(date1 : Date, date2 : Date) =
date1 < date2
