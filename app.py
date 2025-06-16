from flask import Flask, jsonify

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

@app.route('/', methods=['GET'])
def hello_world():
    return jsonify(message="Olá, Mundo! minha api DevOps está no ar!")

@app.route('/status', methods=['GET'])
def status():
    return jsonify(status="OK", message="api funcionando corretamente.")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)