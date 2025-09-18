import csv
import mysql.connector

# --- MySQL connection ---
conn = mysql.connector.connect(
    user="ejudge",
    password="??????",
    database="ejudge",
)
cursor = conn.cursor()
print(cursor)
# # --- CSV path ---
csv_file = "t2.csv"

with open(csv_file, newline='') as f:
    reader = csv.DictReader(f, delimiter=';')
    # print(reader.fieldnames)
    for row in reader:
        login = row['login']
        csv_password = row['password']

        # Get password from MySQL
        if True:
            cursor.execute("SELECT password FROM logins WHERE login=%s", (login,))
            result = cursor.fetchone()
            sql_password = result[0] if result else None
            
            print(f"Login: {login}")
            print(f"CSV password: {csv_password}")
            print(f"MySQL password: {sql_password}")
            print("-" * 40)
        else:
            if login.startswith("MKO_1-"):
                try:
                    num_part = int(login.split('-')[-1])
                except ValueError:
                    continue
                print(num_part)
                if 1 <= num_part <= 245:
                    sql = """
                    UPDATE logins
                    SET password=%s, pwdmethod=0
                    WHERE login=%s;
                    """
                    print(login)
                    cursor.execute(sql, (csv_password, login))


conn.commit()
cursor.close()
conn.close()

