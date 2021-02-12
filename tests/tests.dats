#include "ats-result.hats"
#include "ats-unit-testing.hats"

staload $UT
staload $RESULT

fn test{n:nat | n < 2}(i: int(n)): result_vt(string, string) = res where {
    val res = (if i = 0 then Ok("Woohoo&") else Error("Grrrr")): result_vt(string, string)
}

implement tostring<string>(s) = copy s

fn test01(c: &Context): void = () where {
    val a = Ok(1): result_vt(int, string)
    val- ~Ok(x) = a
    val () = assert_equals1<int>(c, x, 1)
}

fn test02(c: &Context): void = () where {
    val a = Error("Oops"): result_vt(int, string)
    val- ~Error(x) = a
    val () = assert_equals1<string>(c, x, "Oops")
}

fn test03(c: &Context): void = () where {
    val res = test(0)
    val () = case+ res of
    | ~Ok(s) => assert_true(c, true)
    | ~Error(s) => assert_true(c, false)
}

fn test04(c: &Context): void = () where {
    val res = test(1)
    val () = case+ res of
    | ~Ok(s) => assert_true(c, false)
    | ~Error(s) => assert_true(c, true)
}

fn test05(c: &Context): void = () where {
    val res = Ok(1): result_vt(int, string)
    val () = println!(res, ": print Ok works")
    val- ~Ok(e) = res
    val () = assert_true(c, true)
}

fn test06(c: &Context): void = () where {
    val res = Error("error"): result_vt(int, string)
    val () = println!(res, ": print Error works")
    val- ~Error(e) = res
    val () = assert_true(c, true)
}

fn test07(c: &Context): void = () where {
    val res = Ok(0): result_vt(int, string)
    fn add(x: int): int = x + 1
    val res = fmap<int,string,int>(lam x => x + 1, res)
    val res = fmap<int,string,int>(add, res)
    val () = case+ res of
    | ~Ok(e) => assert_equals1<int>(c, e, 2)
    | ~Error(e) => assert_true(c, false)
}

fn test08(c: &Context): void = () where {
    val res = Error("AHH"): result_vt(int, string)
    fn add(x: int): int = x + 1
    val res = fmap<int,string,int>(lam x => x + 1, res)
    val res = fmap<int,string,int>(add, res)
    val () = case+ res of
    | ~Ok(e) => assert_true(c, false)
    | ~Error(e) => assert_equals1<string>(c, e, "AHH")
}

implement main(argc, argv) = 0 where {
    val r = create_runner()
    val s = create_suite("ats-result tests")

    val () = add_test(s, "test1", test01)
    val () = add_test(s, "test2", test02)
    val () = add_test(s, "test3", test03)
    val () = add_test(s, "test4", test04)
    val () = add_test(s, "test5", test05)
    val () = add_test(s, "test6", test06)
    val () = add_test(s, "test7 - fmap works", test07)
    val () = add_test(s, "test8 - fmap propagates error", test08)

    val () = add_suite(r, s)
    val () = run_tests(r)
    val () = free_runner(r)
}
