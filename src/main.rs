#![feature(register_tool)]
#![register_tool(flux)]
#![feature(custom_inner_attributes)]

mod insertion_sort;

fn main() {
    let range = insertion_sort::make_range(0, 10);
    insertion_sort::print_list(&range);
}
