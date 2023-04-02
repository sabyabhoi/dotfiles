#!/usr/bin/python3

import subprocess


class Node:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

    def write_to_dotfile(self, filename):
        q = [self]

        with open(filename, 'w') as f:
            f.write('digraph dg{\n')
            f.write("\tbgcolor=\"transparent\";\n")
            f.write("\tnode[shape=circle, fontcolor=lightgray, \
color=lightgray, fillcolor=lightgray, fixedsize=true];\n")
            f.write("\tedge[color=lightgray];\n")

            while len(q) > 0:
                node = q[0]
                q.pop()
                if(node.left):
                    f.write('\t{}->{};\n'.format(node.val, node.left.val))
                    q.append(node.left)
                if(node.right):
                    f.write('\t{}->{};\n'.format(node.val, node.right.val))
                    q.append(node.right)
            f.write('}\n')

    def generate_dotgraph(self, filename, _type='svg'):
        self.write_to_dotfile(filename)
        subprocess.Popen('dot -T {} -O {}'.format(_type, filename), shell=True)


def from_array(a):
    n = len(a)
    head = Node(a[0])
    q = []

    q.append((0, head))

    while len(q) > 0:
        ix = q[0][0]
        node = q[0][1]

        q.pop()

        left = 2 * ix + 1
        right = 2 * ix + 2

        if left < n:
            node.left = Node(a[left])
            q.append((left, node.left))
        if right < n:
            node.right = Node(a[right])
            q.append((right, node.right))

    return head


def print_inorder(head):
    if head is None:
        return
    print_inorder(head.left)
    print(head.val, end=' ')
    print_inorder(head.right)


if __name__ == '__main__':
    n = int(input())
    a = [int(x) for x in input().split(' ')]
    head = from_array(a)
    head.generate_dotgraph('tree.gv')
