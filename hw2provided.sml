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
                  | x :: xs' =>   make_name(xs',{first=x, middle=middle, last=last} :: acc);
              fun f(xs,acc) =
                case xs of
                  [] => acc
                  | xs  :: ys  => let
                                    val sub_strings_list  = get_substitutions2(xs,first);
                                  in
                                    if SOME sub_strings_list = NONE
                                    then f( ys, acc)
                                    else f( ys, acc @ make_name(sub_strings_list,[]))
                                  end
            in
              f([strings_list_list],[{first=first,middle=middle,last=last}])
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

exception NoCardsFound

fun card_color(card) =
  case card of
    (Spades   , _) => Black
   |(Clubs    , _) => Black
   |(Diamonds , _) => Red
   |(Hearts   , _) => Red

fun card_value(card) =
  case card of
    (_ , Jack)  => 10
   |(_ , Queen) => 10
   |(_ , King)  => 10
   |(_ , Ace)   => 11
   |(_ , Num  x)  => x


fun same(c1 , c2 ) =
    c1 = c2


fun all_cards_except_option(pick, cards ) =
 let fun f (xs,acc) =
    case xs of
     [] => acc
     | x :: xs' => if same(pick,x)
                   then f(xs', acc)
                   else f(xs', x :: acc)
  in
    let
      val cards_left = f(cards,[])
    in
     if length(cards_left) = length(cards)
     then  NONE
     else  SOME cards_left
     end
  end


fun remove_card( deck , pick , ex) =
  let
     val cards_left = all_cards_except_option(pick,deck)
    in
      if cards_left = NONE
      then raise ex
      else getOpt(cards_left,[])
   end

