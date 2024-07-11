
from extensions import db

class UserModel(db.Document):
    username = db.StringField(required=True, unique=True)
    first_name = db.StringField(required=True)
    last_name = db.StringField(required=True)
    email = db.EmailField(required=True)
    password = db.StringField(required=True)
    #birth_date = db.DateTimeField(required=True)
