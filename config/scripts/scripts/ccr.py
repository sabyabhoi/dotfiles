#!/bin/python3
import argparse

rust = '''\
use std::io::{self, prelude::*, StdinLock, StdoutLock};
use std::str;

fn solve(scan: &mut Scanner<StdinLock>, out: &mut io::BufWriter<StdoutLock>) {

}

fn main() {
    let (stdin, stdout) = (io::stdin(), io::stdout());
    let mut scan = Scanner::new(stdin.lock());
    let mut out = io::BufWriter::new(stdout.lock());

    let t = scan.token::<usize>();
    for _ in 0..t {
        solve(&mut scan, &mut out);
    }
}

pub struct Scanner<R> {
    reader: R,
    buffer: Vec<String>,
}

impl<R: io::BufRead> Scanner<R> {
    pub fn new(reader: R) -> Self {
        Self {
            reader,
            buffer: vec![],
        }
    }

    pub fn token<T: str::FromStr>(&mut self) -> T {
        loop {
            if let Some(token) = self.buffer.pop() {
                return token.parse().ok().expect("Failed parse");
            }
            let mut input = String::new();
            self.reader.read_line(&mut input).expect("Failed read");
            self.buffer = input.split_whitespace().rev().map(String::from).collect();
        }
    }
}
'''

cargo = '''
[[bin]]
name = "{}"
'''

def parse():
    parser = argparse.ArgumentParser(description='Rust cc templater')
    parser.add_argument('problem', metavar='P', type=str, help='problem name/number')
    args = parser.parse_args()
    return args.problem

def run(question):
    with open('./src/bin/{}.rs'.format(question), 'w') as f:
        f.write(rust)
    with open('./Cargo.toml', 'a') as f:
        f.write(cargo.format(question))

if __name__ == '__main__':
    run(parse())
