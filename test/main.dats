#include "{$PATSRELOCROOT}/ats-result.hats"

fn test{n:nat | n < 2}(i: int(n)): result_vt(string, string) = res where {
    val res = (if i = 0 then Ok("Woohoo!") else Error("Grrrr")): result_vt(string, string)
}

fn test01() = () where {
    val a = Ok(1): result_vt(int, string)
    val- ~Ok(x) = a
    val () = assertloc(x = 1)
    val () = println!("test01(): Success")
}

fn test02() = () where {
    val a = Error("Oops"): result_vt(int, string)
    val- ~Error(x) = a
    val () = assertloc(x = "Oops")
    val () = println!("test02(): Success")
}

fn test03() = () where {
    val res = test(0)
    val () = case+ res of
    | ~Ok(s) => assertloc(true)
    | ~Error(s) => assertloc(false)
    val () = println!("test03(): Success")
}

fn test04() = () where {
    val res = test(1)
    val () = case+ res of
    | ~Ok(s) => assertloc(false)
    | ~Error(s) => assertloc(true)
    val () = println!("test04(): Success")
}

fn test05() = () where {
    val res = Ok(1): result_vt(int, string)
    val () = println!(res, ": print Ok works")
    val- ~Ok(e) = res
    val () = println!("test05(): Success")
}

fn test06() = () where {
    val res = Error("error"): result_vt(int, string)
    val () = println!(res, ": print Error works")
    val- ~Error(e) = res
    val () = println!("test06(): Success")
}

implement main(argc, argv) = 0 where {
    val () = test01()
    val () = test02()
    val () = test03()
    val () = test04()
    val () = test05()
    val () = test06()
}