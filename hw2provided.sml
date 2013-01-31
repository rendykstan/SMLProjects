(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)


fun all_except_option(search_string, strings ) =
 let fun f (xs,acc) =
    case xs of
     [] => acc
     | x :: xs' => if same_string(search_string,x)
                   then f(xs', acc)
                   else f(xs', x :: acc)
  in
    let
      val sub_strings = f(strings,[])
    in
     if length(sub_strings) = length(strings)
     then NONE
     else  SOME sub_strings
     end
  end

   fun get_substitutions1( strings_list_list, search_string) =
    let fun f(xs,acc) =
        case xs of
          [] => acc
          | xs :: ys => let
                          val sub_strings_list = all_except_option(search_string,xs);
                        in
                          if sub_strings_list = NONE
                          then f( ys, acc)
                          else f( ys, getOpt(sub_strings_list,[])  @ acc)
                        end
    in
      f(strings_list_list,[])
    end




  fun get_substitutions2( strings_list_list, search_string) =
    let fun f(xs,acc) =
        case xs of
          [] => acc
          | xs :: ys => let
                          val sub_strings_list = all_except_option(search_string,xs);
                        in
                          if sub_strings_list = NONE
                          then f( ys, acc)
                          else f( ys, getOpt(sub_strings_list,[])  @ acc)
                        end
    in
      f(strings_list_list,[])
    end

 fun similar_names( strings_list_list, {first,middle,last}) =


            let


              fun make_name(xs,acc) =
                  case xs of
                  [] => acc
                  | x :: xs' =>   make_name(xs',{first="xxx", middle=middle, last=last} :: acc);

              fun f(xs,acc) =
                case xs of
                  [] => acc
                  | xs :: ys  => let
                                  val sub_strings_list  = get_substitutions2(first,xs);
                                in
                                  if SOME sub_strings_list = NONE
                                  then f( ys, acc)
                                  else f( ys, make_name(sub_strings_list,[])  @ acc)
                                end
            in
              (*f(strings_list_list,[]) *)
              [{first="Fred", last="Smith", middle="W"},
        {first="Fredrick", last="Smith", middle="W"},
        {first="Freddie", last="Smith", middle="W"},
        {first="F", last="Smith", middle="W"}]
            end






(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

(* put your solutions for problem 2 here *)