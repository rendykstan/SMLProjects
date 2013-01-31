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

