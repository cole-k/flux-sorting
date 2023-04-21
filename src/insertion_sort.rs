#[flux::refined_by(k: int)]
enum DescendingList {
    #[flux::variant(DescendingList[0])]
    Nil,
    #[flux::variant((u32[@k], Box<DescendingList{v: v <= k}>) -> DescendingList[k])]
    Cons(u32, Box<DescendingList>)
}

#[flux::sig((hi: u32, lo: u32{lo <= hi}) -> DescendingList[hi])]
fn make_range(hi: u32, lo: u32) -> DescendingList {
    if hi == lo {
        DescendingList::Cons(hi, Box::new(DescendingList::Nil))
    } else {
        let smaller_values = make_range(hi - 1, lo);
        DescendingList::Cons(hi, Box::new(smaller_values))
    }
}

fn _simple_test_ok() {
    let _zero = DescendingList::Cons(0, Box::new(DescendingList::Nil));
    let _one = DescendingList::Cons(1, Box::new(_zero));
    let _two = DescendingList::Cons(2, Box::new(_one));
}

fn _simple_test_fail() {
    let _zero = DescendingList::Cons(0, Box::new(DescendingList::Nil));
    let _two = DescendingList::Cons(2, Box::new(_zero));
    let _one = DescendingList::Cons(1, Box::new(_two));
}
