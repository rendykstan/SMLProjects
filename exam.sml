fun f xs =
  case xs of
  (a,b)::(c,d)::(e,f)::[] => true
  (*
| x::(y::z)
| (a,b,c)::d
| []
| (a,b)::(c,d)::(e,f)::[]
| (a,b)::(c,d)::(e,f)::g
*)