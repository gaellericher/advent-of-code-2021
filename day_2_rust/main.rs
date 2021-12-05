use std::io::{self, BufRead};
use std::fs::File;
use std::path::Path;

fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

fn parse_instruction(instruction: &str) -> (&str, i32) {
    let vec = instruction.split(" ").collect::<Vec<&str>>();
    let way = vec[0];
    let x:i32 = vec[1].parse::<i32>().unwrap();
    return (way, x)
}

fn get_position_after_p1(pos:[i32;2], instruction: &str) -> [i32; 2] {
    let (way, x) = parse_instruction(instruction);
    let delta:[i32;2] = match way {
        "forward"=> [x, 0],
        "down"=>[0, x],
        "up"=> [0, -x],
        _=> [0,0]
    };
    return [pos[0]+delta[0], pos[1]+delta[1]];
}

fn get_position_after_p2(pos: [i32;3], instruction: &str) -> [i32; 3] {
    let (way, x) = parse_instruction(instruction);
    let delta:[i32;3] = match way {
        "forward"=> [x, pos[2]*x, 0],
        "down"=>[0, 0, x],
        "up"=> [0, 0,-x],
        _=> [0, 0, 0]
    };
    return  [pos[0]+delta[0], pos[1]+delta[1], pos[2]+delta[2]];
}


fn main() {
    let test_lines: [&str; 6] = [
        "forward 5", "down 5", "forward 8", "up 3", "down 8", "forward 2"
    ];
    let mut pos_1 = [0, 0];
    let mut pos_2 = [0, 0, 0];
    for line in test_lines {
        pos_1 = get_position_after_p1(pos_1, line);
        println!("{} -> ({},{})", line, pos_1[0], pos_1[1]);
        pos_2 = get_position_after_p2(pos_2, line);
        println!("{} -> ({},{},{})", line, pos_2[0], pos_2[1], pos_2[2]);
    }
    assert_eq!(pos_1[0]*pos_1[1], 150);
    assert_eq!(pos_2[0]*pos_2[1], 900);

    if let Ok(lines) = read_lines("./input") {
        let mut pos_1 = [0, 0];
        let mut pos_2 = [0, 0, 0];
        for line in lines {
            if let Ok(instruction) = line {
                pos_1 = get_position_after_p1(pos_1, instruction.as_str());
                pos_2 = get_position_after_p2(pos_2, instruction.as_str());
            }
        }
        println!("{}", pos_1[0]*pos_1[1]);
        println!("{}", pos_2[0]*pos_2[1]);
    }
}