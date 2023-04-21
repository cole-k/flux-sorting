#![flux::defs {
    fn min(x: int, y: int) -> int {
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

#[flux::refined_by(len: int)]
pub enum List {
    #[flux::variant(List[0])]
    Nil,
    #[flux::variant((i32, Box<SortedList[@len]>) -> SortedList[len + 1])]
    Cons(i32, Box<List>),
}

impl<'a> FromIterator<&'a i32> for List {

    #[flux::trusted]
    fn from_iter<T: IntoIterator<Item = &'a i32>>(iter: T) -> Self {
        let mut list = List::Nil;
        for i in iter {
            list = List::Cons(*i, Box::new(list));
        }
        return list;
    }
}

#[allow(dead_code)]
#[flux::sig(fn(lo: i32, hi: i32{lo <= hi && hi <= i32::MAX}) -> SortedList[lo])]
pub fn make_ascending_range(lo: i32, hi: i32) -> SortedList {
    if lo == hi {
        SortedList::Cons(lo, Box::new(SortedList::Nil))
    } else {
        let bigger_values = make_ascending_range(lo + 1, hi);
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

#[flux::sig(fn(&List) -> SortedList)]
pub fn insertion_sort(unsorted_list: &List) -> SortedList {
    let mut list = unsorted_list;
    let mut sorted_list = SortedList::Nil;
    while let List::Cons(i, next) = list {
        list = next;
        sorted_list = insort(*i, sorted_list);
    }
    sorted_list
}

#[flux::sig(fn(SortedList[@k1], SortedList[@k2]) -> SortedList[min(k1, k2)])]
fn merge(list1: SortedList, list2: SortedList) -> SortedList {
    match (list1, list2) {
        (SortedList::Nil, SortedList::Nil) => SortedList::Nil,
        (SortedList::Cons(k1, next1), SortedList::Nil) => SortedList::Cons(k1, next1),
        (SortedList::Nil, SortedList::Cons(k2, next2)) => SortedList::Cons(k2, next2),
        (SortedList::Cons(k1, next1), SortedList::Cons(k2, next2)) => {
            if k1 <= k2 {
                SortedList::Cons(k1, Box::new(merge(*next1, SortedList::Cons(k2, next2))))
            } else {
                SortedList::Cons(k2, Box::new(merge(SortedList::Cons(k1, next1), *next2)))
            }
        }
    }
}

#[flux::trusted]
fn unsafe_head(slice: &[i32]) -> i32 {
    slice[0]
}

#[flux::sig(fn(&[i32]) -> SortedList)]
pub fn merge_sort(unsorted_slice: &[i32]) -> SortedList {
    if unsorted_slice.is_empty() {
        return SortedList::Nil;
    }
    // Needed to prevent an infinite recursion when we split and get an empty
    // list and the same list.
    if unsorted_slice.len() == 1 {
        return SortedList::Cons(unsafe_head(unsorted_slice), Box::new(SortedList::Nil));
    }
    let (first_half, second_half) = unsorted_slice.split_at(unsorted_slice.len() / 2);
    merge(merge_sort(first_half), merge_sort(second_half))
}

#[flux::trusted]
pub fn print_sorted_list(mut l: &SortedList) {
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
