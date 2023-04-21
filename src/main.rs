#![feature(register_tool)]
#![register_tool(flux)]
#![feature(custom_inner_attributes)]

use sort::*;

mod sort;

#[flux::trusted]
fn main() {
    // let range = make_ascending_range(0, 10);
    // print_list(&range);
    // let some_list= List::from_iter([5, 12, 5, 2, 3, 1, 9, 2, 10].iter());
    let some_list = make_descending_range(10, 0);
    print_sorted_list(&insertion_sort(&some_list));
    // print_sorted_list(&merge_sort(&vec!(5, 12, 5, 2, 3, 1, 9, 2, 10)));
}
