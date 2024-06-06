import random
from datetime import datetime, timedelta

# Function to generate random dates
def random_date(start, end):
    return (start + timedelta(days=random.randint(0, (end - start).days))).strftime('%Y-%m-%d')

# Function to calculate Net salary from Gross salary
def calculate_net_salary(gross_salary):
    # Example formula: net salary is gross salary minus 20% taxes
    net_salary = int(gross_salary * 0.80)
    return net_salary

department_names = ['Finance', 'HR', 'IT', 'CustomerService', 'Operations', 'Marketing', 'Legal', 'Compliance', 'Audit', 'Risk']

# Example educations and authority levels
educations = ["Bachelor's Degree", "Master's Degree", "PhD", "Associate Degree", "High School Diploma"]
authority_levels = [
    'Manage IT Department', 'Manage HR Department', 'Manage Finance Department',
    'Manage Operations', 'Manage Customer Service', 'Manage Marketing'
]

# Date range for last update
start_date = datetime.strptime('01-01-1990', '%d-%m-%Y')
end_date = datetime.strptime('26-05-2024', '%d-%m-%Y')

# Salaries Table
salary_insert_commands = []
for worker_id in range(1, 43571):
    gross_salary = random.randint(30000, 120000)  # Random gross salary between 30k and 120k
    net_salary = calculate_net_salary(gross_salary)
    last_update = random_date(start_date, end_date)
    salary_insert_commands.append(f"INSERT INTO Salaries (WorkerID, Gross, Net, LastUpdate) VALUES ({worker_id}, {gross_salary}, {net_salary}, '{last_update}');")

# Manager Table
manager_insert_commands = []
num_managers = int(0.1 * 43570)  # Assuming 10% of workers are managers
manager_worker_ids = random.sample(range(1, 43571), num_managers)  # Unique WorkerIDs for managers

for worker_id in manager_worker_ids:
    num_workers_uhr = random.randint(5, 50)  # Number of workers under responsibility
    performance_rating = random.randint(1, 100)
    years_of_experience = random.randint(1, 40)
    education = random.choice(educations).replace("'", "''")
    level_of_authority = random.choice(authority_levels).replace("'", "''")
    manager_insert_commands.append(f"INSERT INTO Manager (WorkerID, NumWorkersUHR, PreformanceRating, YearsOfExperience, Education, LevelOfAuthority) VALUES ({worker_id}, {num_workers_uhr}, {performance_rating}, {years_of_experience}, '{education}', '{level_of_authority}');")

# Clerk Table
clerk_insert_commands = []
all_worker_ids = set(range(1, 43571))
clerk_worker_ids = all_worker_ids - set(manager_worker_ids)  # WorkerIDs for clerks, excluding managers

for worker_id in clerk_worker_ids:
    branch_id = random.randint(1, 400)
    department = random.choice(department_names).replace("'", "''")
    shift_hours = random.choice(['Morning', 'Afternoon', 'Night'])
    clerk_insert_commands.append(f"INSERT INTO Clerk (WorkerID, BranchID, Department, ShiftHours) VALUES ({worker_id}, {branch_id}, '{department}', '{shift_hours}');")

# Write the SQL commands to files
with open('insert_salaries.sql', 'w') as file:
    file.write('\n'.join(salary_insert_commands))

with open('insert_managers.sql', 'w') as file:
    file.write('\n'.join(manager_insert_commands))

with open('insert_clerks.sql', 'w') as file:
    file.write('\n'.join(clerk_insert_commands))

print("SQL insert commands for Salaries, Managers, and Clerks have been generated and written to files.")
