use "hw2provided.sml";

(* 1.a *)
all_except_option( "x", ["x","y","z"]) = SOME(rev(["y","z"]));

(* 1.b *)
get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred")
= rev ["Fredrick","Freddie","F"];  (* Should be true *)

(* 1.c *)
get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")
= ["Jeffrey","Geoff","Jeffrey"]; (* Should be true *)

get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Harry")
= []; (* Should be true *)


(* 1.d *)

similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],{first="Fred", middle="W", last="Smith"}) =
[{first="Fred", last="Smith", middle="W"},
{first="Fredrick", last="Smith", middle="W"},
{first="Freddie", last="Smith", middle="W"},
{first="F", last="Smith", middle="W"}] ; (* Should be true *)


(* 2.a *)
card_color(Spades,Ace) = Black;
card_color(Clubs,Ace) = Black;
card_color(Diamonds,Ace) = Red;
card_color(Hearts,Ace) = Red;


(* 2.b *)
card_value(Spades,Ace) = 11;
card_value(Clubs,Ace) = 11;
card_value(Diamonds,Ace) = 11;
card_value(Hearts,Ace) = 11;

card_value(Spades,Num 9) = 9;
card_value(Spades,Num 3) = 3;
card_value(Clubs,Jack) = 10;
card_value(Diamonds,Queen) = 10;
card_value(Hearts,King) = 10;

(* 2.c *)
val c1 = (Spades,Ace);
val c2 = (Spades,Jack);
val c3 = (Clubs,Queen);
val c4 = (Spades,Queen);

val y = remove_card([c1,c2],c3,NoCardsFound)  handle NoCardsFound  => [c1,c2];
val x = remove_card([c1,c2],c4,NoCardsFound)  handle NoCardsFound  => [c1,c2];

remove_card([c1,c2],c1,NoCardsFound) = [c2];

(* 2.d *)

all_same_color([(Spades,Ace),(Clubs,Ace),(Clubs,King)]) = true;
all_same_color([(Spades,Ace),(Diamonds,Ace)]) = false;


(* 2.e *)

sum_cards([c1,c2]) = 21;
sum_cards([(Spades,Num 9),(Clubs,Num 3),(Spades,King)]) = 22;

(* 2.f *)

score([c1,c2],5) = 21 - 5;
score([(Spades,Num 9),(Clubs,Num 3),(Spades,King)],25) = 25 - 22;

