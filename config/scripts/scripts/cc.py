#!/bin/python3
import argparse
import os

MAKEFILE = '''\
CC=g++
CFLAGS= -std=c++17 -O2 -Wall -Wextra -pedantic -Wshadow -Wformat=2 -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -Wno-unused-result -Wno-sign-conversion

main:
\t$(CC) $(CFLAGS) $(FILE)
'''

TEMPLATE = '''\
#include <bits/stdc++.h>

#define deb(x) cout << #x << " = " << x << endl

#define ull unsigned long long
#define ll long long
#define MOD 1000000007

#define REP(i, n) for(int i = 0; i < (n); ++i)
#define FOR(i, s, n) for(int i = (s); i < (n); ++i)

using namespace std;

void solve()
{
}

int main()
{
	ios_base::sync_with_stdio(false);
	cin.tie(nullptr);

	int t;
	cin >> t;
	while(t--)
		solve();
	return 0;
}
'''

def parse_arguments():
    parser = argparse.ArgumentParser(description='Codeforces Helper tool V2.0')

    parser.add_argument('question', help='The codeforces question number')

    args = parser.parse_args()
    return args

def generate_source_and_makefile(filename):
    source = filename + '.cpp'
    if not os.path.exists('makefile'):
        with open('makefile', 'w') as f:
            f.write(MAKEFILE)

    if not os.path.exists(source):
        print('Generating', source)
        with open(source, 'w') as f:
            f.write(TEMPLATE)
            print('Makefile generated. Run it using mingw32-make FILE=' + source)

if __name__ == '__main__':
    args = parse_arguments()
    filename = args.question

    generate_source_and_makefile(filename)

