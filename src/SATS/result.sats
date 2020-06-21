
dataviewtype result_vt(a:vt@ype, b:vt@ype) =
| Ok of a
| Error of b

fn {a,b:vt@ype} is_ok(r: !result_vt(a, b)): bool

fn {a,b,c:vt@ype} fmap(map: c -> a, result_vt(c, b)): result_vt(a, b)

fn {a,b:vt@ype}
fprint_result(out: FILEref, r: !result_vt(a,b)): void

fn {a,b:vt@ype}
print_result(r: !result_vt(a,b)): void

overload fprint with fprint_result
overload print with print_result
