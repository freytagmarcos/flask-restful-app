from flask import Flask, request
from flask_restful import Resource, Api
from flasgger import Swagger

from extensions import db, ma
from resources.user import User

app = Flask(__name__)

app.config['MONGODB_SETTINGS'] = {
    'db': 'users',
    'host': 'mongodb_2',
    'port': 27017,
    'username': 'admin',
    'password': 'admin'
}

api = Api(app)
swagger = Swagger(app)

db.init_app(app)


api.add_resource(User, '/user')

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
