from flask import Flask
from datetime import datetime

app = Flask(__name__)

@app.route("/")
def hello_world():
    current_time = datetime.today().strftime("%Y-%m-%d %H:%M:%S")
    return f"<p>Hola, has hecho una consulta a esta web a las <b> {current_time}!!!!</b></p>"