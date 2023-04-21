#![flux::defs {
    fn min(x: int, y: int) -> int {
        if x < y { x } else { y }
    }
}]

#[flux::refined_by(min: int, len: int)]
#[derive(Debug)]
pub enum SortedList {
    #[flux::variant(SortedList[i32::MAX, 0])]
    Nil,
    #[flux::variant((i32[@k], Box<{SortedList[@v, @len] | v >= k}>) -> SortedList[k, len + 1])]
    Cons(i32, Box<SortedList>)
}

#[flux::refined_by(len: int)]
pub enum List {
    #[flux::variant(List[0])]
    Nil,
    #[flux::variant((i32, Box<List[@len]>) -> List[len + 1])]
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

#[flux::sig(fn(hi: i32, lo: i32{lo <= hi && hi <= i32::MAX}) -> List[1 + hi - lo])]
pub fn make_descending_range(hi: i32, lo: i32) -> List {
    if hi == lo {
        List::Cons(hi, Box::new(List::Nil))
    } else {
        let smaller_values = make_descending_range(hi - 1, lo);
        List::Cons(hi, Box::new(smaller_values))
    }
}

#[allow(dead_code)]
#[flux::sig(fn(lo: i32, hi: i32{lo <= hi && hi <= i32::MAX}) -> SortedList[lo, 1 + hi - lo])]
pub fn make_ascending_range(lo: i32, hi: i32) -> SortedList {
    if lo == hi {
        SortedList::Cons(lo, Box::new(SortedList::Nil))
    } else {
        let bigger_values = make_ascending_range(lo + 1, hi);
        SortedList::Cons(lo, Box::new(bigger_values))
    }
}

#[flux::sig(fn(i32[@n], list: SortedList[@k, @len]) -> SortedList[min(n, k), len + 1])]
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

#[flux::sig(fn(&List[@n]) -> SortedList[#k, n])]
pub fn insertion_sort(unsorted_list: &List) -> SortedList {
    match unsorted_list {
        List::Nil => SortedList::Nil,
        List::Cons(i, next) => insort(*i, insertion_sort(next)),
    }
}

#[flux::sig(fn(SortedList[@k1, @len1], SortedList[@k2, @len2]) -> SortedList[min(k1, k2), len1 + len2])]
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


#[flux::sig(fn(&List[@n]) -> usize[n])]
pub fn len(list: &List) -> usize {
    match list {
        List::Nil => 0,
        List::Cons(_, next) => 1 + len(next),
    }
}

#[flux::sig(fn(&List[@n]) -> {(List[#m1], List[#m2]) | m1 + m2 == n && m1 - m2 <= 1})]
pub fn halve(list: &List) -> (List, List) {
    let mut current = list;
    let mut i = len(list);
    let midpoint = i / 2;
    let mut l1 = List::Nil;
    let mut l2 = List::Nil;
    while i > midpoint {
        match current {
            List::Nil => {
                return impossible();
            }
            List::Cons(k, next) => {
                l1 = List::Cons(*k, Box::new(l1));
                current = next;
            }
        }
        i -= 1;
    }
    while i > 0 {
        match current {
            List::Nil => {
                return impossible();
            }
            List::Cons(k, next) => {
                l2 = List::Cons(*k, Box::new(l2));
                current = next;
            }
        }
        i -= 1;
    }
    (l1, l2)
}

#[flux::sig(fn() -> {(List, List) | false})]
fn impossible() -> (List, List) {
    unreachable!()
}

#[flux::sig(fn(&List[@n]) -> SortedList[#k, n])]
pub fn merge_sort(unsorted_list: &List) -> SortedList {
    // Handle base cases
    match unsorted_list {
        List::Nil => return SortedList::Nil,
        List::Cons(i, next) => {
           match **next {
               List::Nil => return SortedList::Cons(*i, Box::new(SortedList::Nil)),
               List::Cons(_,_) => (),
           }
        }
    };
    let (l1, l2) = halve(unsorted_list);
    merge(merge_sort(&l1), merge_sort(&l2))
    // if unsorted_list.len() == 1 {
    //     return SortedList::Cons(unsafe_head(unsorted_list), Box::new(SortedList::Nil));
    // }
    // let (first_half, second_half) = unsorted_list.split_at(unsorted_list.len() / 2);
    // merge(merge_sort(first_half), merge_sort(second_half))
}

#[flux::trusted]
pub fn print_sorted_list(mut l: &SortedList) {
    println!("printing sorted list");
    while let SortedList::Cons(v, next) = l {
        l = next;
        println!("value: {:?}", *v);
    }
}

#[flux::trusted]
pub fn print_list(mut l: &List) {
    println!("printing list");
    while let List::Cons(v, next) = l {
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
