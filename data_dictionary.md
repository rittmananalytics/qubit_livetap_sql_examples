

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  view_id | STRING | Unique ID of view |
|  entrance_id | STRING | Unique ID of entrance. A new entrance is started if an attribute of the previous page is different i.e. the referrer, is on a different domain or if the url of<br/>  the `View` is typed in manually in the address bar. Reloading the browser or navigating between pages on the same domain will not cause entrance events to be emitted |
|  session_id | STRING | Unique ID of session - a session ends when a visitor is inactive for more than 30 minutes and starts when activity resumes after ending a session or on the first visit. |
|  entry_id | STRING | Unique ID of entry where entry is each session in an entrance |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_entranceNumber | INTEGER | The sequential entrance number of a user in her/his lifetime (across all sessions) |
|  context_sessionViewNumber | INTEGER | The sequential pageview number of a user in a session (across 1 session) |
|  context_entranceViewNumber | INTEGER | The sequential pageview number of a user in an entrance (across 1 session) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all session) up to the current view |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone |
|  context_lifetimeValue_baseValue | FLOAT | The tota conversion value visitor has had (across all session) up to the current view |
|  user_id | STRING | User ID emitted from the point user was logged on until the session expires |
|  user_username | STRING | Username emitted from the moment user was logged on all views throughout the session |
|  user_title | STRING | User's title emitted from the moment user was logged on or registered on all views throughout the session |
|  user_email | STRING | User's email emitted from the moment user was logged on or registered on all views throughout the session |
|  user_loyalty_tier | STRING | User's loyality tier emitted from the moment user was logged on or registered on all views throughout the session |
|  user_gender | STRING | User's gender from the moment user was logged on or registered on all views throughout the session |
|  user_age | INTEGER | User's age from the moment user was logged on or registered on all views throughout the session |
|  user_phoneNumber | STRING | User's phone number emitted from the moment user was logged on or registered on all views throughout the session |
|  user_isGuest | STRING | Indicates whether the visitor was using guest account (if applicable) |
|  user_firstName | STRING | User's first name emitted from the moment user was logged on or registered on all views throughout the session |
|  user_lastName | STRING | User's last name emitted from the moment user was logged on or registered on all views throughout the session |
|  is_user_sign_up_view | BOOLEAN | True if visitor registered on the view |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_url | STRING | URL on which view was emitted |
|  page_type | STRING | Type of page on which view was emitted - as emitted by website |
|  page_subtype | STRING | Page category / breadcrumb of view - as emitted by website |
|  transaction_id | STRING | Transaction ID if user submitted order on the page view |
|  views_in_session | INTEGER | The number of views user has had in a session |
|  first_view_in_session_ts | INTEGER | Epoch time of first view that was emitted in the session |
|  last_view_in_session_ts | INTEGER | Epoch time of last view that was emitted in the session |
|  views_in_entrance | INTEGER | Total number of views in visitor's entrance |
|  total_visitor_views | INTEGER | Total number of views in visitor's livetime |
|  visitor_first_entry_date | STRING | The first date visitor has entered the website |
|  last_view_in_session | BOOLEAN | True if view was the last view in visitor's session |
|  last_view_in_entrance | BOOLEAN | True if view was the last view in visitor's entrance |
|  last_visitor_view | BOOLEAN | True if view was the last view in visitor's lifetime |
|  new_vs_returning | STRING | Label for new_vs_returning status |
|  session_duration_seconds | FLOAT | The number of seconds the session was active for |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
