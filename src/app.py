from flask import Flask
from flask_restful import Resource, Api
from flasgger import Swagger

app = Flask(__name__)
api = Api(app)
swagger = Swagger(app)

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

api.add_resource(User, '/')

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0")
