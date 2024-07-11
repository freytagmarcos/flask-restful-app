from flask import Flask, request
from flask_restful import Resource

from models.user_model import UserModel
from schemas.user import UserSchema



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
        user_schema = UserSchema()
        data = user_schema.load(request.json)
        user = UserModel(**data)
        user.save()