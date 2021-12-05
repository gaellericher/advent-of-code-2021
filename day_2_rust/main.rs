use std::io::{self, BufRead};
use std::fs::File;
use std::io::prelude::*;
use std::path::Path;

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

fn get_position_after(x : i32, y: i32, instruction: &str) -> [i32; 2] {
    let vec = instruction.split(" ").collect::<Vec<&str>>();
    let way = vec[0];
    let distance:i32 = vec[1].parse::<i32>().unwrap();

    let delta:[i32;2] = match way {
        "forward"=> [distance,0],
        "down"=>[0, distance],
        "up"=> [0, -distance],
        _=> [0,0]
    };
    let ret:[i32;2] = [x+delta[0], y+delta[1]];
    return ret
}

fn main() {
    let test_lines: [&str; 6] = [
        "forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"
    ];
    let mut pos = [0, 0];
    for line in test_lines {
        pos = get_position_after(pos[0], pos[1], line);
        println!("{} -> ({},{})", line, pos[0], pos[1]);
    }
    assert_eq!(pos[0]*pos[1], 150);

    if let Ok(lines) = read_lines("./input") {
        let mut pos = [0, 0];
        for line in lines {
            if let Ok(instruction) = line {
                pos = get_position_after(pos[0], pos[1], instruction.as_str());
            }
        }
        println!("{}", pos[0]*pos[1]);
    }
}