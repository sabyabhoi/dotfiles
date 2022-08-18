#!/bin/python3
import argparse

rust = '''\
use std::io::{self, prelude::*, StdinLock, StdoutLock};
use std::str;

fn solve(scan: &mut Scanner<StdinLock>, out: &mut io::BufWriter<StdoutLock>) {

}

struct Scanner<R> {
    reader: R,
    buf_str: Vec<u8>,
    buf_iter: str::SplitWhitespace<'static>,
}

impl<R: BufRead> Scanner<R> {
    fn new(reader: R) -> Self {
        Self {
            reader,
            buf_str: vec![],
            buf_iter: "".split_whitespace(),
        }
    }
    fn token<T: str::FromStr>(&mut self) -> T {
        loop {
            if let Some(token) = self.buf_iter.next() {
                return token.parse().ok().expect("Failed parse");
            }
            self.buf_str.clear();
            self.reader
                .read_until(b'\\n', &mut self.buf_str)
                .expect("Failed read");
            self.buf_iter = unsafe {
                let slice = str::from_utf8_unchecked(&self.buf_str);
                std::mem::transmute(slice.split_whitespace())
            }
        }
    }
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
