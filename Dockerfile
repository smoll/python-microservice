# Tiny 5 MB base image
FROM gliderlabs/alpine:3.2

# Install python
RUN apk --update add python \
    python-dev \
    py-pip

# Code lives here
ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# pip install in a cache-efficient way
COPY requirements.txt $APP_HOME/
RUN pip install -r requirements.txt

# Copy the rest of the app
COPY app.py $APP_HOME/

EXPOSE 5000
CMD ["python", "app.py"]
