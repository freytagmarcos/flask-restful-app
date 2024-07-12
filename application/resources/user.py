from flask import request, make_response
from flask_restful import Resource

from models.user_model import UserModel
from schemas.user import UserSchema

from mongoengine.errors import FieldDoesNotExist, NotUniqueError, DoesNotExist, InvalidQueryError
from marshmallow.exceptions import ValidationError

class User(Resource):
    def get(self, username):
        """
        This in an example that returns Hello World!
        ---
        responses:
            200:
                description: A successful response
                examples:
                    application/json: "Hello, World!"
        """
        try:
            user = UserModel.objects.get(username=username)
            user_schema = UserSchema()
            return make_response(user_schema.dump(user))
        except DoesNotExist:
            return ({"error": "User with given username doesn't exists"}, 404)
        except Exception as e:
            return ("Internal Server Error", 500)

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
        try:
            user_schema = UserSchema()
            data = user_schema.load(request.json)
            user = UserModel(**data)
            user.save()
            return '', 200
        except (FieldDoesNotExist, ValidationError):
            return ({"error":"Request is missing required fields"}, 400)
        except NotUniqueError:
            return ({"error":"User with given username already exists"}, 400)
        except Exception as e:
            return ("Internal Server Error", 500)