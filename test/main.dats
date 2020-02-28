#include "ats-result/ats-result.hats"

implement main(argc, argv) = 0 where {
    val a = Ok(1): result_vt(int, string)
    val () = println!(a)
    val- ~Ok(x) = a
    val () = println!(x)
    val a = Error("Oops"): result_vt(int, string)
    val () = println!(a)
    val- ~Error(x) = a
    val () = println!(x)
}