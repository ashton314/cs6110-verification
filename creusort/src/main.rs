extern crate creusot_contracts;

use creusot_contracts::{
    logic::{Int, OrdLogic, Seq},
    *,
};

#[predicate]
fn sorted<T: OrdLogic>(s: Seq<T>) -> bool {
    sorted_range(s, 0, s.len())
}

#[ensures(sorted((^v).deep_model()))]
#[ensures((^v)@.permutation_of(v@))]
pub fn gnome_sort<T: Ord + DeepModel>(v: &mut Vec<T>)
where
    T::DeepModelTy: OrdLogic,
{
    let old_v = ghost! { v };
    let mut i = 0;
    #[invariant(sorted_range(v.deep_model(), 0, i@))]
    #[invariant(v@.permutation_of(old_v@))]
    while i < v.len() {
        if i == 0 || v[i - 1].le(&v[i]) {
            i += 1;
        } else {
            v.swap(i - 1, i);
            i -= 1;
        }
    }
}

// fn main() {
//     println!("Hello, world!");

//     // let mut foo = vec![3, 1, 4, 5, 9, 2, 6, 8];
//     // println!("Foo: {}", foo.clone());
// }

// #[predicate]
// fn sorted_range<T: OrdLogic>(s: Seq<T>, l: Int, u: Int) -> bool {
//     pearlite! { forall<i: Int, j: Int>
//     l <= i && i < j && j < u ==> s[i] <= s[j] }
// }

// #[ensures(sorted_range(@^v, 0, (@^v).len()))]
// #[ensures((@^v).permuation_of(@*v))]
// fn gnome_sort<T: Ord>(v: &mut Vec<T>) {
//     let old_v = Ghost::record(&v);
//     let mut i = 0;
//     #[invariant(sorted_range(@*v, 0, @i))]
//     #[invariant((@*v).permuation_of(@*@old_v))]
//     while i < v.len() {
//         if i == 0 || v[i - 1] <= v[i] {
//             i += 1;
//         } else {
//             v.swap(i - 1, i);
//             i -= 1;
//         }
//     }
// }