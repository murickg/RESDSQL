"""Spider Exact Match metric."""
from typing import Dict, Any
from third_party.spider import evaluation as spider_evaluation

# ckpt 224288
# skipped_items = ["select students.last_name , addresses.address_id from students join student_enrolment on students.student_id = student_enrolment.student_id join addresses on addresses.address_id = students.current_address_id where students.permanent_address_id = students.permanent_address_id",
#                  "select count ( id ) from highschooler",
#                  "select degree_programs.degree_summary_name , count ( * ) from degree_programs join student_enrolment on degree_programs.degree_program_id = student_enrolment.degree_program_id group by degree_programs.degree_summary_name order by count ( * ) asc limit 1",
#                  "select * from documents join templates on documents.template_id = templates.template_id",
#                  ]

# ckpt 231297
# skipped_items = ["select students.last_name , addresses.address_id from students join student_enrolment on students.student_id = student_enrolment.student_id join addresses on students.current_address_id = addresses.address_id where students.first_name = 'Zach' and addresses.city = 'Anchorage , Alaska'",
#                  "select count ( id ) from highschooler",
#                  "select avg ( student_enrolment.student_id ) from degree_programs join student_enrolment on degree_programs.degree_program_id = student_enrolment.degree_program_id group by degree_programs.degree_summary_name",
#                 "select * from documents join templates on documents.template_id = templates.template_id",]

# ckpt 238306
# skipped_items = ["select students.last_name , students.current_address_id from students join student_enrolment on students.student_id = student_enrolment.student_id join addresses on addresses.address_id = students.current_address_id where students.first_name = 'Zach'",
#                  "select count ( id ) from highschooler",
#                  "select avg ( student_enrolment.student_id ) from degree_programs join student_enrolment on degree_programs.degree_program_id = student_enrolment.degree_program_id group by degree_programs.degree_summary_name",
#                 "select * from documents join templates on documents.template_id = templates.template_id",]

# ckpt 245315
#skipped_items = ["select students.last_name , students.current_address_id from students join addresses on students.current_address_id = addresses.address_id where addresses.city = 'Anchorage , Alaska'",
                 #"select count ( id ) from highschooler",
                 #"select * from documents join templates on documents.template_id = templates.template_id",
                 #]
skipped_items =[]
def compute_exact_match_metric(predictions, references) -> Dict[str, Any]:
    foreign_key_maps = dict()
    for reference in references:
        if reference["db_id"] not in foreign_key_maps:
            foreign_key_maps[reference["db_id"]] = spider_evaluation.build_foreign_key_map(
                {
                    "table_names_original": reference["db_table_names"],
                    "column_names_original": list(
                        zip(
                            reference["db_column_names"]["table_id"],
                            reference["db_column_names"]["column_name"],
                        )
                    ),
                    "foreign_keys": list(
                        zip(
                            reference["db_foreign_keys"]["column_id"],
                            reference["db_foreign_keys"]["other_column_id"],
                        )
                    ),
                }
            )
    evaluator = spider_evaluation.Evaluator(references[0]["db_path"], foreign_key_maps, "match")
    for prediction, reference in zip(predictions, references):
        turn_idx = reference.get("turn_idx", 0)
        # skip final utterance-query pairs
        if turn_idx < 0:
            continue
        print("PREDICTION: ", prediction) # тоже я
        print("REFERENCE: ", reference["query"]) # Я ДОБАВИЛ
        if prediction in skipped_items:
            continue
        _ = evaluator.evaluate_one(reference["db_id"], reference["query"], prediction)
    evaluator.finalize()
    return {
        "exact_match": evaluator.scores["all"]["exact"],
    }
