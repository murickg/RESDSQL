set -e

python evaluation.py \
  --gold "./files/gold.sql" \
  --pred "./files/pred.sql" \
  --etype "all" \
  --db "/Users/muradgamzatov/Desktop/text2query/project/resdsql/cosql_dataset/database" \
  --table "./files/tables.json"