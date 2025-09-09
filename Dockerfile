FROM python:3.10
WORKDIR /flask-app

# Install dependencies
COPY ./requirements.txt ./
RUN pip install -r requirements.txt

# Copy source code
COPY ./APP ./APP

# Set flask environment variables
ENV FLASK_APP=APP/app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

EXPOSE 5000

# Run Flask app
CMD ["flask", "run"]
