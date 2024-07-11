from flask import Flask, request
from flask_restful import Resource, Api
from flasgger import Swagger

from extensions import db, ma
from routes import initialize_routes

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
initialize_routes(api)

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
