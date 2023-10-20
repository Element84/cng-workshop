FROM ghcr.io/lambgeo/lambda-gdal:3.6-python3.10 as VENV
WORKDIR /opt/pyvenv
RUN python3 -m venv --copies .
COPY requirements.txt .
RUN ./bin/pip install -r requirements.txt

FROM ghcr.io/lambgeo/lambda-gdal:3.6-python3.10

RUN yum install -y git

COPY --from=VENV /opt/pyvenv /opt/pyvenv
ENV PATH=/opt/pyvenv/bin:$PATH
ENTRYPOINT []

COPY ./notebooks ./notebooks
COPY ./aois ./aois
COPY ./README.md ./README.md
