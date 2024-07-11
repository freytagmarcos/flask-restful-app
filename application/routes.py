from resources.user import User
from resources.users import Users

def initialize_routes(api):
    api.add_resource(User, '/user', '/user/<string:username>')
    api.add_resource(Users, '/users')
