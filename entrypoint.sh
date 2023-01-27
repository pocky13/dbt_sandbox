git clone https://github.com/dbt-labs/jaffle_shop.git
dbt --version

# dbt実行(モデル作成)
echo "========create models========"
dbt debug --project-dir /work/jaffle_shop --profiles-dir /work/
dbt seed --project-dir /work/jaffle_shop --profiles-dir /work/
dbt run --project-dir /work/jaffle_shop --profiles-dir /work/

# dbt実行(test)
echo "========execute dbt test========"
dbt test --project-dir /work/jaffle_shop --profiles-dir /work/
dbt docs generate --project-dir /work/jaffle_shop --profiles-dir /work/

# duckDB上のテーブルの確認
echo "========show duckDB tables========"
/bin/duckdb /work/db.duckdb "show tables;"


# piperider実行
echo "========execute piperider========"
piperider init
piperider diagnose
piperider run
piperider generate-assertions
piperider run

# 汚いけど、piperiderのドキュメントをdbt serveでまとめて見れるように配置...
mkdir /work/jaffle_shop/target/piperider/
cp -r /work/.piperider/outputs/latest/ /work/jaffle_shop/target/piperider/

# dbt
echo "========serve dbt docs========"
echo "dbt=> http://localhost:8080/piperider/latest/index.html"
echo "piperider=> http://localhost:8080/index.html"
dbt docs serve --project-dir /work/jaffle_shop --profiles-dir /work/

