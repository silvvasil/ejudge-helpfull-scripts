import sys
from random import choice
from transliterate import translit

def gen_password(len: int = 8):
    s = 'abcdefghijklmnopqrstuvwxyz1234567890'
    return ''.join(choice(s) for _ in range(len))


filename = sys.argv[1]

with open(filename, "r") as f:
    for line in f.readlines():
        surname, name = line.split()
        login = f'mps-reg-{translit(surname, "ru", reversed=True)}'.lower()
        print(f'| {login} | {gen_password()} | {surname} {name}')

        

