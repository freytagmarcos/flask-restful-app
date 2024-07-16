from os import getenv


class DevConfig:

    MONGODB_SETTINGS = {
        'db': getenv('MONGODB_DB'),
        'host': getenv('MONGODB_HOST'),
        'port': 27017,
        'username': getenv('MONGODB_USERNAME'),
        'password': getenv('MONGODB_PASSWORD')
    }


class PrdConfig:

    MONGODB_USER = getenv('MONGODB_USER')
    MONGODB_PASSWORD = getenv('MONGODB_PASSWORD')
    MONGODB_HOST = getenv('MONGODB_HOST')
    MONGODB_DB = getenv('MONGODB_DB')

    MONGODB_SETTINGS = {
        'host': 'mongodb+srv://%s:%s@rest-api-flask-cluster.q2bzddy.mongodb.net/?retryWrites=true&w=majority&appName=rest-api-flask-cluster' % (
          MONGODB_USER,
          MONGODB_PASSWORD
        )
    }