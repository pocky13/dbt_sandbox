FROM python:3.9.5

RUN apt update && apt install -y zip unzip
RUN pip install -U pip
RUN pip install dbt-core dbt-duckdb duckdb piperider piperider[duckdb]
RUN cd /bin/ && wget "https://github.com/duckdb/duckdb/releases/download/v0.6.1/duckdb_cli-linux-aarch64.zip" && unzip duckdb_cli-linux-aarch64.zip

WORKDIR /work
COPY entrypoint.sh /work
COPY profiles.yml /work

CMD [ "sh","/work/entrypoint.sh" ]
