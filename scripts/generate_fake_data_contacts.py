import pandas as pd
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

# Set a seed for reproducibility
random.seed(42)
fake.seed_instance(42)

# Generate fake company data
def generate_contact_data(num_contacts=100):
    contacts = []
    for _ in range(num_contacts):
        contact = {
            'id': fake.unique.random_number(digits=5),
            'name': fake.name(),
            'email': fake.email(),
            'phone': fake.phone_number(),
            'company_name': fake.company(),
            'lead_status': random.choice(['new', 'contacted', 'qualified', 'opportunity', 'closed-won', 'closed-lost']),
            'LIFECYCLE_STAGE': random.choice(['new', 'contacted', 'qualified', 'opportunity', 'closed-won', 'closed-lost'])
        }
        contacts.append(contact)
    
    return pd.DataFrame(contacts)

# Generate the data
df_contacts = generate_contact_data()

# Save to CSV
df_contacts.to_csv('contacts_data.csv', index=False)

print(df_contacts.head())
print(f"Generated {len(df_contacts)} contact records.")