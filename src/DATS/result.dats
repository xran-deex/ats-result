#include "HATS/includes.hats"
#define ATS_DYNLOADFLAG 0

staload $RESULT

implement {a,b} is_ok(r) = res where {
    val res = case+ r of
              | @Ok _ => (fold@r; true)
              | @Error _ => (fold@r; false)
}

implement {a,b}
fprint_result(out, r) = 
case+ r of
| Ok _ => print!("Ok")
| Error _ => print!("Error")

implement {a,b}
print_result(r) = fprint_result(stdout_ref, r)

implement {a,b,c}
fmap(map, res) = result where {
    val result = (case+ res of
    | ~Ok(x) => Ok(map(x))
    | ~Error(e) => Error(e)): result_vt(a, b)
}
