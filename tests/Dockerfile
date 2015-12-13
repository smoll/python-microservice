# tester Dockerfile

FROM gliderlabs/alpine:3.2
RUN apk --update add python \
    python-dev \
    py-pip \
    py-curl

# Test code lives here
ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

COPY test-requirements.txt $APP_HOME/
RUN pip install -r test-requirements.txt

# Copy the rest of the test code
COPY . $APP_HOME/

# Dummy command, should exit as soon as it starts unless overridden via `docker-compose run tester cmd-to-run`
CMD true
