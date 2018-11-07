FROM dockerregistry.test.netflix.net:7002/engtools/xenialbase:latest

RUN apt-get update && \
    apt-get install -y nflx-python-{{.ToolVersions.python}} && \
    /apps/python{{.ToolVersions.python}}/bin/python -m pip install virtualenv && \
    /apps/python{{.ToolVersions.python}}/bin/python -m virtualenv /apps/titusjob

COPY . /apps/titusjob
WORKDIR /apps/titusjob

RUN /apps/titusjob/bin/pip install --no-cache-dir -r requirements.txt
CMD ["/apps/titusjob/venv/bin/axeman", "-u", "ct.googleapis.com/logs/argon2021"]
