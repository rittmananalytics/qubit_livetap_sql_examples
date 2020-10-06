# Visitor Pulse (livetap_visitor_pulse)

Questions and answers for Visitor Pulse surveys

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_url | STRING | URL on which view was emitted |
|  survey_id | STRING | The ID of visitor pulse survey |
|  question_text | STRING | Text of question asked in the Visitor Pulse survey |
|  question_type | STRING | The type of a question in survey |
|  question_order | INTEGER | The order of a question in survey |
|  question_id | STRING | The ID of a question in survey |
|  survey_totalQuestions | INTEGER | The total number of question in the survey |
|  answer | STRING | The answer given by the visitor to a question in the survey |
|  question_freetext | STRING | The answer given by the visitor to a question in the survey (if it was a free text type) |
|  view_id | STRING | Unique ID of view |
|  user_survey_response_id | STRING | Unique ID of response in a survey |
|  unique_row_id | STRING | Unique ID of the row |
|  user_survey_answer_1 | STRING | Answer given to question number 1 |
|  user_survey_answer_2 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_3 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_4 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_5 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_6 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_7 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_8 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_9 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_10 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_11 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_12 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_13 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_14 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_15 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_16 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_17 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_18 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_19 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
|  user_survey_answer_20 | STRING | Answer given to question number  (if question exists). This column has been added to support filtering answers given to other questions |
