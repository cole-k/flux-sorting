#![feature(register_tool)]
#![register_tool(flux)]
#![feature(custom_inner_attributes)]

mod sort;

#[flux::trusted]
fn main() {
    // let range = insertion_sort::make_range(0, 10);
    // insertion_sort::print_list(&range);
    let some_numbers = vec!(5, 12, 5, 2, 3, 1, 9, 2, 10);
    sort::print_list(&sort::insertion_sort(&some_numbers));
    sort::print_list(&sort::merge_sort(&some_numbers));
}
