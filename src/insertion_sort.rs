#[flux::refined_by(k: int)]
enum SortedList {
    #[flux::variant(SortedList[0])]
    Nil,
    #[flux::variant((u32[@k], Box<SortedList{v: v <= k}>) -> SortedList[k])]
    Cons(u32, Box<SortedList>)
}

fn simple_test() {
    let zero = Cons(0, Box::new(Nil));
    let one = Cons(1, Box::new(zero));
    let two = Cons(2, Box::new(one));
}
