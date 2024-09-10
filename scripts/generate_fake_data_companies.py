import pandas as pd
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

# Set a seed for reproducibility
random.seed(42)
fake.seed_instance(42)

# Custom list of industries
industries = [
    "Technology", "Healthcare", "Finance", "Education", "Manufacturing",
    "Retail", "Agriculture", "Energy", "Transportation", "Entertainment"
]

# Generate fake company data
def generate_company_data(num_companies=100):
    companies = []
    for _ in range(num_companies):
        company = {
            'id': fake.unique.random_number(digits=5),
            'name': fake.company(),
            'create_date': fake.date_between(start_date='-5y', end_date='today'),
            'last_activity': fake.date_between(start_date='-1y', end_date='today'),
            'active_tickets': random.randint(0, 20),
            'industry': random.choice(industries),
            'employee_count': random.randint(1, 10000),
            'revenue': random.randint(100000, 1000000000)
        }
        companies.append(company)
    
    return pd.DataFrame(companies)

# Generate the data
df_companies = generate_company_data()

# Save to CSV
df_companies.to_csv('companies_data.csv', index=False)

print(df_companies.head())
print(f"Generated {len(df_companies)} company records.")