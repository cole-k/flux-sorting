#![feature(custom_inner_attributes)]
#![flux::defs {
    fn min(x: int, y: int) {
        if x < y { x } else { y }
    }
}]

#[flux::refined_by(min: int)]
#[derive(Debug)]
pub enum SortedList {
    #[flux::variant(SortedList[i32::MAX])]
    Nil,
    #[flux::variant((i32[@k], Box<SortedList{v: v >= k}>) -> SortedList[k])]
    Cons(i32, Box<SortedList>)
}

#[flux::sig(fn(lo: i32, hi: i32{lo <= hi && hi <= i32::MAX}) -> SortedList[lo])]
pub fn make_range(lo: i32, hi: i32) -> SortedList {
    if lo == hi {
        SortedList::Cons(lo, Box::new(SortedList::Nil))
    } else {
        let bigger_values = make_range(lo + 1, hi);
        SortedList::Cons(lo, Box::new(bigger_values))
    }
}

#[flux::sig(fn(i32[@n], list: SortedList[@k]) -> SortedList[min(n, k)])]
fn insort(n: i32, list: SortedList) -> SortedList {
   match list {
       SortedList::Nil => SortedList::Cons(n, Box::new(SortedList::Nil)),
       SortedList::Cons(k, next) => {
           if k < n {
               SortedList::Cons(k, Box::new(insort(n, *next)))
           } else {
               SortedList::Cons(n, Box::new(SortedList::Cons(k, next)))
           }
       }
   }
}

#[flux::trusted]
pub fn print_list(mut l: &SortedList) {
    println!("printing list");
    while let SortedList::Cons(v, next) = l {
        l = next;
        println!("value: {:?}", *v);
    }
}

fn _simple_test_ok() {
    let _two = SortedList::Cons(2, Box::new(SortedList::Nil));
    let _one = SortedList::Cons(1, Box::new(_two));
    let _zero = SortedList::Cons(0, Box::new(_one));
}

// Leaving this commented out so that I only get an error code if there's an actual failure.
//
// fn _simple_test_fail() {
//     let _one = SortedList::Cons(1, Box::new(SortedList::Nil));
//     let _two = SortedList::Cons(2, Box::new(_one));
//     let _zero = SortedList::Cons(0, Box::new(_two));
// }
