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

# predict probability for each schema item in the eval set
python schema_item_classifier.py \
    --batch_size 32 \
    --device "0" \
    --seed 42 \
    --save_path "./models/text2sql_schema_item_classifier" \
    --dev_filepath "./cosql_dataset/preprocessed_data/preprocessed_cosql_dev.json" \
    --output_filepath "./cosql_dataset/preprocessed_data/dev_with_probs.json" \
    --use_contents \
    --add_fk_info \
    --mode "eval"

# generate text2sql development dataset
python text2sql_data_generator.py \
    --input_dataset_path "./cosql_dataset/preprocessed_data/dev_with_probs" \
    --output_dataset_path "./cosql_dataset/preprocessed_data/resdsql_dev_cosql.json" \
    --topk_table_num 4 \
    --topk_column_num 5 \
    --mode "eval" \
    --use_contents \
    --add_fk_info \
    --output_skeleton \
    --target_type "sql"