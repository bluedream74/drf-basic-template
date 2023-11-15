#!/bin/bash

if [ "$DATABASE" = "mysql" ]
then
    echo "Waiting for mysql..."
    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done
    echo "MySQL started"
fi

# Décommenter pour supprimer la bdd à chaque redémarrage (danger)
# echo "Clear entire database"
# python manage.py flush --no-input

echo "Appling database migrations..."
python manage.py makemigrations 
python manage.py migrate
# python manage.py loaddata seed/PointRate.json
python manage.py runserver 0.0.0.0:8000

exec "$@"
