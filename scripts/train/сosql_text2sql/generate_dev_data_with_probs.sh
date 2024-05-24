set -e

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