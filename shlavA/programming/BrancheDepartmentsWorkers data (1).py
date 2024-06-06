import random
from datetime import datetime, timedelta

cities = ['jerusalem', 'TelAviv', 'ramle', 'Haifa', 'BeerSheva', 'Netanya', 'Petahtikva', 'RamatGan', 'Yavne', 'Ashdod', 'Ashkelon', 'Hadera', 'KiryatShmona', 'Afula', 'lod', 'Herzelia', 'KfarSaba', 'Raanana', 'Teveriya', 'MaaleEdomim']
department_names = ['Finance', 'HR', 'IT', 'CustomerService', 'Operations', 'Marketing', 'Legal', 'Compliance', 'Audit', 'Risk']

first_names = [
    'James', 'John', 'Robert', 'Michael', 'William', 'David', 'Richard', 'Joseph', 'Charles', 'Thomas',
    'Christopher', 'Daniel', 'Matthew', 'Anthony', 'Mark', 'Donald', 'Steven', 'Paul', 'Andrew', 'Joshua',
    'Kenneth', 'Kevin', 'Brian', 'George', 'Edward', 'Ronald', 'Timothy', 'Jason', 'Jeffrey', 'Ryan',
    'Jacob', 'Gary', 'Nicholas', 'Eric', 'Jonathan', 'Stephen', 'Larry', 'Justin', 'Scott', 'Brandon',
    'Benjamin', 'Samuel', 'Gregory', 'Frank', 'Alexander', 'Raymond', 'Patrick', 'Jack', 'Dennis', 'Jerry',
    'Tyler', 'Aaron', 'Jose', 'Adam', 'Nathan', 'Henry', 'Douglas', 'Zachary', 'Peter', 'Kyle',
    'Walter', 'Ethan', 'Jeremy', 'Harold', 'Keith', 'Christian', 'Roger', 'Noah', 'Gerald', 'Carl',
    'Terry', 'Sean', 'Austin', 'Arthur', 'Lawrence', 'Jesse', 'Dylan', 'Bryan', 'Joe', 'Jordan',
    'Billy', 'Bruce', 'Albert', 'Willie', 'Gabriel', 'Logan', 'Alan', 'Juan', 'Wayne', 'Roy',
    'Ralph', 'Randy', 'Eugene', 'Carlos', 'Russell', 'Bobby', 'Victor', 'Martin', 'Ernest', 'Phillip'
]

last_names = [
    'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller', 'Davis', 'Rodriguez', 'Martinez',
    'Hernandez', 'Lopez', 'Gonzalez', 'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin',
    'Lee', 'Perez', 'Thompson', 'White', 'Harris', 'Sanchez', 'Clark', 'Ramirez', 'Lewis', 'Robinson',
    'Walker', 'Young', 'Allen', 'King', 'Wright', 'Scott', 'Torres', 'Nguyen', 'Hill', 'Flores',
    'Green', 'Adams', 'Nelson', 'Baker', 'Hall', 'Rivera', 'Campbell', 'Mitchell', 'Carter', 'Roberts',
    'Gomez', 'Phillips', 'Evans', 'Turner', 'Diaz', 'Parker', 'Cruz', 'Edwards', 'Collins', 'Reyes',
    'Stewart', 'Morris', 'Morales', 'Murphy', 'Cook', 'Rogers', 'Gutierrez', 'Ortiz', 'Morgan', 'Cooper',
    'Peterson', 'Bailey', 'Reed', 'Kelly', 'Howard', 'Ramos', 'Kim', 'Cox', 'Ward', 'Richardson',
    'Watson', 'Brooks', 'Chavez', 'Wood', 'James', 'Bennett', 'Gray', 'Mendoza', 'Ruiz', 'Hughes',
    'Price', 'Alvarez', 'Castillo', 'Sanders', 'Patel', 'Myers', 'Long', 'Ross', 'Foster', 'Jimenez'
]

def random_date(start, end):
    return (start + timedelta(days=random.randint(0, (end - start).days))).strftime('%Y-%m-%d')

def random_phone_number():
    return f"05{random.randint(0, 9)}-{random.randint(1000000, 9999999)}"

# Branches Table
branch_insert_commands = []
branch_data = []
start_date = datetime.strptime('01-01-1990', '%d-%m-%Y')
end_date = datetime.strptime('26-05-2024', '%d-%m-%Y')

for branch_id in range(1, 401):
    city = random.choice(cities)
    establishment_date = random_date(start_date, end_date)
    number_of_workers = random.randint(20, 200)
    branch_insert_commands.append(f"INSERT INTO Branches (city, EstablishmentDate, NumberOfWorkers) VALUES ('{city}', '{establishment_date}', {number_of_workers});")
    branch_data.append((branch_id, number_of_workers))

# Departments Table
department_insert_commands = []
department_data = []
for branch_id, num_workers in branch_data:
    department_workers = [num_workers // 10 + (1 if x < num_workers % 10 else 0) for x in range(10)]
    for dept_index, dept_name in enumerate(department_names):
        department_insert_commands.append(f"INSERT INTO Departments (DepartmentName, BranchID, NumberOfWorkers) VALUES ('{dept_name}', {branch_id}, {department_workers[dept_index]});")
        department_data.append((dept_name, branch_id, department_workers[dept_index]))

# Workers Table
worker_insert_commands = []
worker_id = 1

for dept_name, branch_id, dept_workers in department_data:
    for _ in range(dept_workers):
        first_name = random.choice(first_names)
        last_name = random.choice(last_names)
        join_date = random_date(start_date, end_date)
        phone_number = random_phone_number()
        worker_insert_commands.append(f"INSERT INTO Worker (FirstName, LastName, JoinDate, PhoneNumber, BranchID, Department) VALUES ('{first_name}', '{last_name}', '{join_date}', '{phone_number}', {branch_id}, '{dept_name}');")
        worker_id += 1

# Write the SQL commands to files
with open('insert_branches.sql', 'w') as file:
    file.write('\n'.join(branch_insert_commands))

with open('insert_departments.sql', 'w') as file:
    file.write('\n'.join(department_insert_commands))

with open('insert_workers.sql', 'w') as file:
    file.write('\n'.join(worker_insert_commands))

print("SQL insert commands have been generated and written to files.")
