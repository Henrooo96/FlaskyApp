import os
import tempfile
import json
import base64

import pytest

from demo_app import create_app
from demo_app.db import init_db


USER_DATA = {
    'username': 'henryaneke',
    'password': 'test',
    'firstname': 'Henry',
    'lastname': 'Aneke',
    'phone': '01234'
}


@pytest.fixture
def client():
    db_fd, db_path = tempfile.mkstemp()
    app = create_app({'TESTING': True, 'DATABASE': db_path})

    with app.test_client() as client:
        with app.app_context():
            init_db()
        yield client

    os.close(db_fd)
    os.unlink(db_path)


def setUp(client):
    header = {'Content-Type': 'application/json'}
    user_EndPoint = '/api/users'
    response = client.post(user_EndPoint, json=USER_DATA, headers=header)
    assert response.status_code == 201


def get_token(client, username, password):
    auth_string = "{}:{}".format(username, password)
    credentials = base64.b64encode(f'{auth_string}'.encode()).decode('utf-8')
    token_endpoint = "/api/auth/token"

    header = {
        "Authorization": f"Basic {credentials}",
        "Content-Type":"application/json"
    }

    response = client.get(token_endpoint, headers=header)
    assert response.status_code == 200
    data = json.loads(response.data)
    token = data['token']
    return token


def test_add_user(client):
    setUp(client)
 

def test_get_all_users(client):
    setUp(client)

    username=USER_DATA['username']
    password=USER_DATA['password']
    user_EndPoint='/api/users'
    token = get_token(client, username, password)

    header={"Token": f"{token}", "Content-Type": "application/json"}

    response = client.get(user_EndPoint, headers=header)
    assert response.status_code == 200
    assert b'payload' in response.data

    data = json.loads(response.data)
    assert len(data['payload']) == 1
    assert data['payload'][0] == username


def test_get_personal_information_of_specific_user(client):
    setUp(client)
    username=USER_DATA['username']
    password=USER_DATA['password']
    user_EndPoint=f"/api/users/{username}"
    token = get_token(client, username, password)

    header={"Token": f"{token}", "Content-Type": "application/json"}

    response = client.get(user_EndPoint, headers=header)
    assert response.status_code == 200


def test_update_personal_information_of_specific_user(client):
    setUp(client)
    username=USER_DATA['username']
    password=USER_DATA['password']
    username_EndPoint=f"/api/users/{username}"
    token = get_token(client, username, password)

    header={"Token": f"{token}", "Content-Type": "application/json"}

    response = client.put(username_EndPoint, json=dict(firstname="Kelvin"), headers=header)
    assert response.status_code == 201
