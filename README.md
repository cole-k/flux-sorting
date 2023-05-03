# flux-sorting
This repo is a demo of [flux](https://github.com/flux-rs/flux) on some sorting algorithms.

I used [flux-snapshot](https://github.com/cole-k/flux-snapshot) while implementing
them in order to profile interesting errors.

As I recall, only insertion sort is proved for both preserving length and order.
I ran into issues proving that merge sort preserves length. But I make no guarantees
to the validity or propriety of this code - its purpose was to see what kinds of
errors you might encounter using flux.
