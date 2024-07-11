from flask import Response
from flask_restful import Resource

from models.user_model import UserModel
from schemas.user import UserSchema

class Users(Resource):
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
        users = UserModel.objects().to_json()
        return Response(users)
