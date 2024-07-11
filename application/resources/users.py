from flask import jsonify
from flask_restful import Resource

from models.user_model import UserModel


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
        return jsonify(UserModel.objects())