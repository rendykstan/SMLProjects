(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern


datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let
	val r = g f1 f2
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* 1 *)

fun only_capitals strings =
  List.filter (fn x =>  Char.isUpper(String.sub(x,0))) strings

(* 2 *)

fun longest_string1 strings =
        List.foldl ( fn (x,y) => if String.size(x) > String.size(y) then x else y ) "" strings

(* 3 *)

fun longest_string2 strings =
        List.foldl ( fn (x,y) => if String.size(x) >= String.size(y) then x else y ) "" strings


(* 4 *)
fun longest_string_helper(compare_function,strings) =
	    List.foldl ( fn (x,y) => if compare_function(String.size(x),String.size(y)) then x else y ) "" strings


fun longest_string3 strings =
   let
       val compare_function = fn (x,y) => x > y ;
    in
        longest_string_helper(compare_function,strings)
    end


fun longest_string4 strings =
   let
       val compare_function = fn (x,y) => x >= y ;
    in
        longest_string_helper(compare_function,strings)
    end

(* 5 *)
fun longest_capitalized strings =
      (longest_string2 o only_capitals) strings

(* 6 *)
fun rev_string x =
    (String.implode o List.rev o String.explode) x

(* 7 *)
fun first_answer(f,xs) =
    case List.mapPartial f xs of
       [] => raise NoAnswer
     | v::vs => v

(* 8 *)
fun all_answers f xs  =
let fun helper (x, acc) =
        case x of
         [] => acc
         | head :: tail => case f head of
                           NONE =>  []
                           | SOME v => helper(tail,(v) @ acc)
in
     case (helper(xs,[])) of
       [] => NONE
       | head::tail => SOME (head::tail)
end



