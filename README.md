# Generator-rs

rust generator library

use the dev version on master

```toml
[dependencies.generator]
git = "https://github.com/Xudong-Huang/generator-rs.git"
```


## Usage
```rust
#[macro_use]
extern crate generator;

unsafe fn fib(a: u32, b: u32) -> u32 {
    let (mut a, mut b) = (a, b);
    while b < 200 {
        std::mem::swap(&mut a, &mut b);
        b = a + b;
        _yield_!(b);
    }
    10000
}

fn main() {
    let g = generator!(fib(0, 1));

    for i in g {
        println!("{}", i);
    }
}

```

## Output
```
1
2
3
5
8
13
21
34
55
89
144
233
10000
```

## Goals

- [x] basic send/yield support
- [ ] generator cancel support
- [ ] yield_from support
- [ ] panic inside genertor support
- [x] Basic single threaded support
- [ ] compact stack support
- [ ] Multithreaded support



##  based on this basic library
- we can easily port python libary based on generator into rust. the libaray has more powerfull tools than python that can make the generator more fast, safe and multi thread support.
- schedule framework running with multi-thread.
- basic library for Asynchronous I/O

## Notices

* This crate supports platforms in

    - x86_64

* It depends on the contex libaray, currently the context library need
  some patch to compile the generator lib

