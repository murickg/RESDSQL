set -e

# preprocess train_ cosql dataset
python preprocessing.py \
    --mode "train" \
    --table_path "./cosql_dataset/tables.json" \
    --input_dataset_path "./cosql_dataset/sql_state_tracking/cosql_train.json" \
    --output_dataset_path "./cosql_dataset/preprocessed_data/preprocessed_cosql_train.json" \
    --db_path "./database" \
    --target_type "sql"

# preprocess dev dataset
python preprocessing.py \
    --mode "eval" \
    --table_path "./cosql_dataset/tables.json" \
    --input_dataset_path "./cosql_dataset/sql_state_tracking/cosql_dev.json" \
    --output_dataset_path "./cosql_dataset/preprocessed_data/preprocessed_cosql_dev.json" \
    --db_path "./database"\
    --target_type "sql"