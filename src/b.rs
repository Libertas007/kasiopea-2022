use std::cmp;
use std::fs;

pub fn solve(input: String) {
    let splitted : Vec<&str> = input.split("\n").collect();

    let problems = splitted.first().unwrap();
    let problems : i32 = problems.parse().unwrap();
    let mut i = 0;
    let mut line_pointer = 1;
    let mut out = String::new();

    while problems != i {

        let mut odd_count = 0;
        let mut even_count = 0;
        i += 1;
        let _numbers = splitted[line_pointer];
        line_pointer += 1;
        let weeks: Vec<&str> = splitted[line_pointer].split(" ").collect();
        line_pointer += 1;

        for week in weeks {
            let num : u16 = week.parse().unwrap();
            if num % 2 == 0 {
                even_count += 1;
            } else {
                odd_count += 1;
            }
        }


        match even_count.cmp(&odd_count) {
            cmp::Ordering::Less => out.push_str("NE\n"),
            cmp::Ordering::Equal => out.push_str("NE\n"),
            cmp::Ordering::Greater => out.push_str("ANO\n"),
        }
        println!("Vyřešeno {} z {} problémů...", i, problems);
    }
    fs::write("B.out", out).unwrap();
}