import os
import json
import argparse

from tqdm import tqdm

from utils.spider_metric.evaluator import EvaluateTool

original_dev = json.load(open("cosql_dataset/cosql_samples_dev1.json"))
predict_sqls = []
predicts = open("predictions/cosql/checkpoint-245315/pred.txt")
for line in predicts:
    predict_sqls.append(line.split("\n")[0])

db_path = "./cosql_dataset/database"
original_dev_filepath = "./cosql_dataset/cosql_samples_dev1.json"
# initialize evaluator
evaluator = EvaluateTool()
evaluator.register_golds(original_dev_filepath, db_path, predict_sqls)
spider_metric_result = evaluator.evaluate(predict_sqls)
print('exact_match score: {}'.format(spider_metric_result["exact_match"]))
print('exec score: {}'.format(spider_metric_result["exec"]))