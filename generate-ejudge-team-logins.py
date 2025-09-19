import sys
from random import choice
from transliterate import translit

def gen_password(len: int = 8):
    s = 'abcdefghijklmnopqrstuvwxyz1234567890'
    return ''.join(choice(s) for _ in range(len))


n = int(sys.argv[1])
# print(n)
words = ['argument', 'elevator', 'refrigerator', 'assumption', 'pollution', 'establishment',
    'engineering', 'percentage', 'opportunity', 'passenger', 'management', 'tradition', 'community', 
    'conclusion', 'development', 'responsibility', 'recording', 'investment', 'language', 'literature', 
    'education', 'difference', 'interaction', 'appearance', 'marriage', 'profession', 'measurement', 
    'explanation', 'organization', 'location', 'importance', 'depression', 'operation', 'examination',  
    'complaint', 'psychology', 'disaster', 'assistance', 'presence', 'statement']

print("login;password;name")
for word in words[:n]:
    login = f'mps-team2025-{word}'.lower()
    print(f'{login} ; {gen_password()} ; {word}')

        

