# Text2query dialog system on RESDSQL framework

## Обзор
Модификация архитектуры RESDSQL для поддержки диалогового формата взаимодействия с пользователем.

## Изменения с исходным проектом

1. Предоставляются скрипты в `scripts/train/cosql_text2query` для обучения RESDSQL на тренировочном датасете CoSQL и оценки на тестовом датасете CoSQL.

2. Изменен файл `preprocessing.py` для препроцессинга датасета CoSQL
3. Изменен файл `schema_item_classidier.py` для обучения cross-encoder для поддержки датасета CoSQL
4. Изменен файл `text2sql_data_generator.py`
5. Скрипт `generate_text2sql_dataset.sh` для подготовки тренировочных и тестовых данных разделен на 3 скрипта:
   1. `generate_text2sql_train_set.sh`
   2. `generate_dev_data_with_probs.sh`
   3. `generate_text2sql_dev_set.sh`
6. Скрипт `train_text2sql_t5_base.sh` разделен на 2 скрипта:
   1. `train_text2sql_t5_base.sh`
   2. `best_text2sql_t5_base_ckpt.sh`
7. Добавлен файл `cosql.py` для тренировки модели
8. Изменен файл `dataloader.py` (добавлен класс CoSQLDataset, изменен класс ColumnAndTableClassifierDataset)
9. Изменен файл `utils/spider_metric/evaluator.py` для оценки метрик обученной модели

## Пререквизиты
Create a virtual anaconda environment:
```sh
conda create -n your_env_name python=3.8.5
```
Active it and install the cuda version Pytorch:
```sh
conda install pytorch==1.11.0 torchvision==0.12.0 torchaudio==0.11.0 cudatoolkit=11.3 -c pytorch
```
Install other required modules and tools:
```sh
pip install -r requirements.txt
pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-2.2.0/en_core_web_sm-2.2.0.tar.gz
python nltk_downloader.py
```
Create several folders:
```sh
mkdir eval_results
mkdir models
mkdir tensorboard_log
mkdir third_party
mkdir predictions
```
Clone evaluation scripts:
```sh
cd third_party
git clone https://github.com/ElementAI/spider.git
git clone https://github.com/ElementAI/test-suite-sql-eval.git
mv ./test-suite-sql-eval ./test_suite
cd ..
```

## Подготовка данных
Скачать датасет [CoSQL google_drive](https://drive.usercontent.google.com/download?id=1Y3ydpFiQQ3FC0bzdfy3groV95O_f1nXF&export=download&authuser=0). Создать в директории 
`cosql_dataset` папку `preprocessed_data`

## Обучение модели
**RESDSQL-{Base}**
```sh
# Step1: preprocess dataset
sh scripts/train/text2sql/preprocess.sh
# Step2: train cross-encoder
sh scripts/train/text2sql/train_text2sql_schema_item_classifier.sh
# Step3: generate text2sql training dataset with noise_rate 0.2
sh scripts/train/text2sql/generate_text2sql_train_set.sh
# Step4: predict probability for each schema item in the eval set
sh scripts/train/сosql_text2sql/generate_dev_data_with_probs.sh
# Step5: generate text2sql development dataset
sh scripts/train/сosql_text2sql/generate_text2sql_dev_set.sh
# Step6: fine-tune T5-Base (RESDSQL-Base)
sh scripts/train/text2sql/train_text2sql_t5_base.sh
# Step7: select the best text2sql-t5-base ckpt
sh scripts/train/сosql_text2sql/best_text2sql_t5_base_ckpt.sh
```
