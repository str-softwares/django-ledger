from django.core.management.base import BaseCommand
from django.contrib.auth.models import User

class Command(BaseCommand):
    help = 'Create a superuser if it doesn\'t already exist'

    def handle(self, *args, **kwargs):
        if not User.objects.filter(username='Test1234').exists():
            User.objects.create_superuser(
                username='Test1234',
                email='',
                password='Test@12345678'
            )
            self.stdout.write(self.style.SUCCESS('Superuser created'))
        else:
            self.stdout.write(self.style.SUCCESS('Superuser already exists'))
