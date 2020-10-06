## Goal Achieved (livetap_goal_achieved)

Contains all views after the goal was achieved. If is_post_goal_achieved_view is FALSE, goal was achieved on the current view_id and if TRUE the goal was achieved previously"

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
|  view_id | STRING | Unique ID of view |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone (in cllent property timezone) |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all session) up to the current view |
|  experience_goal_achieved.experienceId | INTEGER | The numeric ID of experience. |
|  experience_goal_achieved.experienceName | STRING | The name of experience. |
|  experience_goal_achieved.variationMasterId | INTEGER | The numeric ID of master variation. |
|  experience_goal_achieved.variationName | STRING | The name of variation |
|  experience_goal_achieved.iterationId | INTEGER | The numeric ID of iteration. (iteration is created when variation is updated) |
|  experience_goal_achieved.isControl | INTEGER | True if variation represents the group control |
|  experience_goal_achieved.goalId | INTEGER | The numeric ID of experience goal |
|  experience_goal_achieved.goalValue | STRING | The value emitted for experience goal |
|  experience_goal_achieved.goalType | STRING | The type emitted for experience goal |
|  experience_goal_achieved.first_view_meta_ts | INTEGER | First time the user has seen the iteration of variation - in epoch time |
|  experience_goal_achieved.first_view_meta_recordDate | STRING | First day when the visitor has seen the iteration of variation |
|  experience_goal_achieved.first_view_in_iteration | INTEGER | First view number when the visitor has seen the iteration of variation |
|  experience_goal_achieved.last_view_in_iteration | INTEGER | Last view number when the visitor has seen the iteration of variation |
|  experience_goal_achieved.is_post_goal_achieved_view | INTEGER | False if goal was achieved on the view. True if the goal was achieved prior to the view. |
