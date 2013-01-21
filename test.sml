
use "assignment_01.sml";

(*

datatype weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun;
datatype month
  = Jan
  | Feb
  | Mar
  | Apr
  | May
  | Jun
  | Jul
  | Aug
  | Sep
  | Oct
  | Nov
  | Dec


*)


val d1 = {
	day=19,
	hour=19,
	minute=27,
	month=Date.Jan,
	offset=NONE,
	second=23,
	year=2013};

val date1 = Date.date d1;


val d2 = {
	day=20,
	hour=19,
	minute=27,
	month=Date.Jan,
	offset=NONE,
	second=23,
	year=2013};

val date2 = Date.date d2;

is_older(date1,date2);

