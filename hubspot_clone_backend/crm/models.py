from django.db import models

# Create your models here.
class Company(models.Model):
    name = models.CharField(max_length=200)
    create_date = models.DateField()
    phone_number = models.CharField(max_length=20)
    last_activity = models.DateTimeField()
    city = models.CharField(max_length=100)
    country = models.CharField(max_length=100)
    industry = models.CharField(max_length=100)
    employee_count = models.IntegerField()
    revenue = models.DecimalField(max_digits=15, decimal_places=2)

    def __str__(self):
        return self.name