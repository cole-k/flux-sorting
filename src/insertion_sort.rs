#[flux::refined_by(k: int)]
enum SortedList {
    #[flux::variant(SortedList[0])]
    Nil,
    #[flux::variant((u32[@k], Box<SortedList{v: v <= k}>) -> SortedList[0])]
    Cons(u32, Box<SortedList>)
}
