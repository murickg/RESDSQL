set -e

# generate text2sql development dataset
python text2sql_data_generator.py \
    --input_dataset_path "./cosql_dataset/preprocessed_data/dev_with_probs.json" \
    --output_dataset_path "./cosql_dataset/preprocessed_data/resdsql_dev_cosql.json" \
    --topk_table_num 4 \
    --topk_column_num 5 \
    --mode "eval" \
    --use_contents \
    --add_fk_info \
    --output_skeleton \
    --target_type "sql"