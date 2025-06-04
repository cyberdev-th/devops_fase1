import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_hello_world(client):
    resposta = client.get('/')
    assert resposta.status_code == 200
    dados_json = resposta.get_json()
    assert dados_json['message'] == "Olá, Mundo! minha api DevOps está no ar!"

def test_status(client):
    resposta = client.get('/status')
    assert resposta.status_code == 200
    dados_json = resposta.get_json()
    assert dados_json['status'] == "OK"
    assert dados_json['message'] == "api funcionando corretamente."

def test_hello_world_content_type(client):
    resposta = client.get('/')
    assert resposta.headers['Content-Type'] == 'application/json'

def test_status_content_type(client):
    resposta = client.get('/status')
    assert resposta.headers['Content-Type'] == 'application/json'