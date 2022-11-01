use std::fs;
use std::io;
use std::time::{Instant};
mod b;

fn main() {
    println!("Zadejte zadání: ");
    let input = read_line();
    let input = input.trim();

    if input == String::from("B") {
        let start = Instant::now();
        b::solve(read_file(&String::from("B.txt")));
        println!("Vyřešeno za {:?}", start.elapsed());
    } else {
        println!("Nenalezeno");
    }
}

pub fn read_line() -> String {
    let mut val = String::new();
    io::stdin().read_line(&mut val).expect("Failed to read line");
    val
}

pub fn read_file(file: &String) -> String {
    fs::read_to_string(file).expect("Failed to read the file")
}

pub fn write_file(file: &String, content: &String) {
    fs::write(file, content).unwrap();
}
