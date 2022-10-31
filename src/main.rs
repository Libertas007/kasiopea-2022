use std::time::{Instant};

fn main() {
    println!("Starting...");
    let start = Instant::now();

    const NUMBER: i64 = 1_000_000_000;
    let mut i = 0;

    while i != NUMBER {
        i+=1;
    }

    let duration = start.elapsed();

    println!("Time elapsed is: {:?}", duration);
}
