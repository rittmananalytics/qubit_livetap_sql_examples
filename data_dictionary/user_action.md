# User Action (livetap_user_action)

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
|  view_id | STRING | Unique ID of view |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_type | STRING | The name of the original QP event the row comes from |
|  type | STRING | The type of user action |
|  name | STRING | The name of user action |
|  user_interaction_type | STRING | The category of user action |
|  voucher_id | STRING | Voucher ID visitor attempted to redeem |
|  voucher_label | STRING | Voucher Label visitor attempted to redeem |
|  voucher_entry | STRING | Voucher code visitor attempted to redeem |
|  voucher_entrySuccess | INTEGER | Indicates whether visitor's attempt to redeem voucher was successful |
