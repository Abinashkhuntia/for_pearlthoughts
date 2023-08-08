from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, mars!'

@app.route('/main')
def wow():
    return 'roorroor!'
if __name__ == '__main__':
    app.run(debug=True)
