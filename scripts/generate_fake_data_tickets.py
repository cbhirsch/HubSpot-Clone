import pandas as pd
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

# Set a seed for reproducibility
random.seed(42)
fake.seed_instance(42)

# Generate fake company data
def generate_ticket_data(num_tickets=100):
    tickets = []
    for _ in range(num_tickets):
        ticket = {
            'id': fake.unique.random_number(digits=5),
            'ticket_name': fake.name(),
            'pipeline': random.choice(['Support Pipeline', 'Sales Pipeline', 'Marketing Pipeline']),
            'ticket_status': random.choice(['Open', 'Closed']),
            'priority': random.choice(['Low', 'Medium', 'High'])
        }
        tickets.append(ticket)
    
    return pd.DataFrame(tickets)

# Generate the data
df_tickets = generate_ticket_data()

# Save to CSV
df_tickets.to_csv('tickets_data.csv', index=False)

print(df_tickets.head())
print(f"Generated {len(df_tickets)} ticket records.")