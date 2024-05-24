set -e

# train schema item classifier
python -u schema_item_classifier.py \
    --batch_size 12 \
    --gradient_descent_step 2 \
    --device "0" \
    --learning_rate 1e-5 \
    --gamma 2.0 \
    --alpha 0.75 \
    --epochs 128 \
    --patience 16 \
    --seed 42 \
    --save_path "./models/text2sql_schema_item_classifier" \
    --tensorboard_save_path "./tensorboard_log/text2sql_schema_item_classifier" \
    --train_filepath "./cosql_dataset/preprocessed_data/preprocessed_cosql_train.json" \
    --dev_filepath "./cosql_dataset/preprocessed_data/preprocessed_cosql_dev.json" \
    --model_name_or_path "roberta-large" \
    --use_contents \
    --add_fk_info \
    --mode "train"