#!/bin/sh

echo "Going to run migrations"
pipenv run python manage.py migrate

echo "Creating superuser"
pipenv run python -c "
import os
from django.core.management import call_command
from django.contrib.auth.models import User

def create_superuser():
    if not User.objects.filter(username='Test1234').exists():
        User.objects.create_superuser(
            username='Test1234',
            email='test@example.com',
            password='Test@12345678'
        )
        print('Superuser created')
    else:
        print('Superuser already exists')

if __name__ == '__main__':
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'dev_env.settings')
    import django
    django.setup()
    create_superuser()
" || exit 1

echo "Going to run django server"
pipenv run python manage.py runserver 0.0.0.0:8000
