FROM python:3.9.5

RUN apt update && apt install -y zip unzip
RUN cd /bin/ && wget "https://github.com/duckdb/duckdb/releases/download/v0.6.1/duckdb_cli-linux-aarch64.zip" && unzip duckdb_cli-linux-aarch64.zip
RUN pip install -U pip
RUN pip install dbt-duckdb duckdb
RUN pip install dbt-core piperider piperider[duckdb]

WORKDIR /work
COPY entrypoint.sh /work
COPY profiles.yml /work

CMD [ "sh","/work/entrypoint.sh" ]
