from flask import Flask, request
from flask_restful import Resource, Api
from flasgger import Swagger

from extensions import db, ma
from schemas.user import UserSchema
from models.user_model import UserModel

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


user_schema = UserSchema()

class User(Resource):
    def get(self):
        """
        This in an example that returns Hello World!
        ---
        responses:
            200:
                description: A successful response
                examples:
                    application/json: "Hello, World!"
        """
        return {'message': 'User'}

    def post(self):
        """
        Insere um usuário
        ---
        responses:
            200:
                description: A successful response
                examples:
                    application/json: "Hello, World!"
        """
        data = user_schema.load(request.json)
        user = UserModel(**data)
        user.save()

api.add_resource(User, '/user')

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
