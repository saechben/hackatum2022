## Fixing OSM Issues in a competitive race to conquer your neighbourhood.

##  TechStack Overview
 - Django Rest Framework with SQLite Database (for Production we can use PostgreSQL on Azure)
 - Database with User Data, Statistics and OSM Issues
 - Seperate Flutter Application calling Django and Azure Custom Vision API
 - Azure CustomVision model for classifying roads

##  Login for provided local SQLite Database
Email: admin@mail.com
Password: admin12345  

### Short Instruction to run the backend
##### Inside backend folder: 
1. create a virtual enviroment inside /backend
1. install requirements.txt on the enviroment
2. run django server via `py manage.py runserver` inside /backend/src
