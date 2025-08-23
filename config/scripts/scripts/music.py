import random

notes = ['A', 'B', 'C', 'D', 'E', 'F', 'G']

for i in range(4):
    for j in range(3):
        note = random.choice(notes)
        print(f"{note}", end=' ')
    print()
