set -e

# train text2sql-t5-3b model
python -u cosql.py \
    --batch_size 1 \
    --gradient_descent_step 16 \
    --device "0" \
    --learning_rate 5e-5 \
    --epochs 128 \
    --seed 42 \
    --save_path "./models/text2sql-t5-3b" \
    --tensorboard_save_path "./tensorboard_log/text2sql-t5-3b" \
    --model_name_or_path "t5-3b" \
    --use_adafactor \
    --mode train \
    --train_filepath "./cosql_dataset/preprocessed_data/resdsql_train_cosql_samples.json"
