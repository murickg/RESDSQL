set -e
# select the best text2sql-t5-base ckpt
python -u evaluate_text2sql_ckpts.py \
    --batch_size 10 \
    --device "0" \
    --seed 42 \
    --save_path "./models/text2sql-t5-base" \
    --eval_results_path "./eval_results/text2sql-t5-base" \
    --mode eval \
    --dev_filepath "./cosql_dataset/preprocessed_data/resdsql_dev_cosql.json" \
    --original_dev_filepath "./cosql_dataset/sql_state_tracking/cosql_dev.json" \
    --db_path "./cosql_dataset/database" \
    --num_beams 8 \
    --num_return_sequences 8 \
    --target_type "sql"