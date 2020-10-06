## Experiences  (livetap_sessions)

Views that happened on or after a visitor saw an experience
If you wish to work with just the views that had the experience delivered on them, use is_post_experience_view to filter rows that are false

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
|  view_id | STRING | Unique ID of view |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone (in cllent property timezone) |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all session) up to the current view |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  experience.experienceId | INTEGER | The numeric ID of experience. |
|  experience.experienceName | STRING | The name of experience. |
|  experience.variationMasterId | INTEGER | The numeric ID of master variation. |
|  experience.variationName | STRING | The name of variation |
|  experience.iterationId | INTEGER | The numeric ID of iteration. (iteration is created when variation is updated) |
|  experience.isControl | INTEGER | True if variation represents the group control |
|  experience.first_view_meta_ts | INTEGER | First time the user has seen the iteration of variation - in epoch time |
|  experience.first_view_meta_recordDate | STRING | First day when the visitor has seen the iteration of variation |
|  experience.first_view_in_iteration | INTEGER | First view number when the visitor has seen the iteration of variation |
|  experience.last_view_in_iteration | INTEGER | Last view number when the visitor has seen the iteration of variation |
|  experience.is_post_experience_view | INTEGER | False if experience was delivered on the view. True if the experience fired prior to the view. |
