#include "ats-result/ats-result.hats"

fn test{n:nat | n < 2}(i: int(n)): result_vt(string, string) = res where {
    val res = (if i = 0 then Ok("Woohoo!") else Error("Grrrr")): result_vt(string, string)
}

implement main(argc, argv) = 0 where {
    val a = Ok(1): result_vt(int, string)
    val () = println!(a)
    val- ~Ok(x) = a
    val () = println!(x)
    val a = Error("Oops"): result_vt(int, string)
    val () = println!(a)
    val- ~Error(x) = a
    val () = println!(x)
    val res = test(0)
    val () = case+ res of
    | ~Ok(s) => println!(s)
    | ~Error(s) => println!(s)
}