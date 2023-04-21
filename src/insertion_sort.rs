#[flux::refined_by(k: int)]
enum SortedList {
    #[flux::variant(SortedList[0])]
    Nil,
    #[flux::variant((u32[@k], Box<SortedList{v: v <= k}>) -> SortedList[k])]
    Cons(u32, Box<SortedList>)
}

fn simple_test() {
    let zero = SortedList::Cons(0, Box::new(SortedList::Nil));
    let one = SortedList::Cons(1, Box::new(zero));
    let two = SortedList::Cons(2, Box::new(one));
}
