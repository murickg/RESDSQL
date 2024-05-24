set -e

# generate text2sql training dataset with noise_rate 0.2
python text2sql_data_generator.py \
    --input_dataset_path "./cosql_dataset/preprocessed_data/preprocessed_cosql_train.json" \
    --output_dataset_path "./cosql_dataset/preprocessed_data/resdsql_train_cosql.json" \
    --topk_table_num 4 \
    --topk_column_num 5 \
    --mode "train" \
    --noise_rate 0.2 \
    --use_contents \
    --add_fk_info \
    --output_skeleton \
    --target_type "sql"