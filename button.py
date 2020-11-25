#!/usr/bin/env python

from flask import Flask, render_template, request
import os

app = Flask(__name__)

@app.route("/", methods=['GET', 'POST'])
def main():
        if request.method == 'POST':
            if request.form.get('On') == 'On':
                # Lights on
                os.system("/home/pi/driveway-lights/sockets/control.py 1 on")
            elif  request.form.get('Off') == 'Off':
                # Lights off
                os.system("/home/pi/driveway-lights/sockets/control.py 1 off")
            else:
                # Unknown
                return render_template("index.html")
        elif request.method == 'GET':
            # return render_template("index.html")
            print("No Post Back Call")
        return render_template("index.html")


if __name__ == '__main__':
        app.run(host='0.0.0.0')
