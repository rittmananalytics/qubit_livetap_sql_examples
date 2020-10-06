# Attribution (livetap_Attribution)

Metrics and attributes used for attributing revenue by first click, last click, even click or using Qubit’s behavioral model

Attribution contains the collection of entries which happened before user transacted (i.e. the journey to conversion for a visitor). Attribution on its own or combined with other subject areas allows for analysis of user’s activity before they converted and how each part of the activity might have influenced user to make the purchase. Entry is a most centric concept to attribution and essentially this is what forms every row in the Attribution analytics model.

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_entranceNumber | INTEGER | The sequential entrance number of a user in her/his lifetime (across all sessions) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all sessions) up to the current view |
|  purchase_timestamp | TIMESTAMP | The timestap of order |
|  entry_timestamp | TIMESTAMP | The timestap of entry |
|  ranked_entry_number_reverse | INTEGER | The sequential number of entry - reversed. E.g. the last entry in purchase cycle of order would have value 1 |
|  ranked_purchase_number | INTEGER | Purchase cycle / sequential number of orders made in a session in visitor's lifetime. For example all orders made in the same session for the first time would have ranked_purchase_number 1, the orders made in the next session would have value 2. Orders made in separate session would have separate ranked purchase numbers |
|  ranked_entry_number | INTEGER | The sequential number of entry in purchase cycle. |
|  entry_id | STRING | Unique entry ID. A new entry is created when there is a new entrance in a session. Ultimately the number of entries is equal to the number of sesions and the number of entrances that happened in those sessions. |
|  order_ids_in_purchase_cycle | STRING | The number of orders made in purchase cycle. |
|  referrer_type | STRING | The type of the page a visitor has come from in the converting entry e.g. affiliate. |
|  referrer_network | STRING | If applicable - the network of the page a visitor has come from in the converting entry e.g. affiliate window. |
|  referrer_mediaType | STRING | If applicable - the media type of the page a visitor has come from (in the converting entry |
|  referrer_campaign | STRING | If applicable - the campaign of the page a visitor has come from  (in the converting entry |
|  referrer_adGroup | STRING | If applicable - the ad group of the page a visitor has come from  (in the converting entry |
|  referrer_content | STRING | If applicable - the content of the page a visitor has come from  (in the converting entry |
|  referrer_keywords | STRING | If applicable - the keywords a visitor used to get to the original page before the view  (in the converting entry |
|  referrer_searchQuery | STRING | If applicable - the search query a visitor used to get to the original page before the view  (in the converting entry |
|  referrer_label | STRING | The label of the page a visitor has come from  (in the converting entry |
|  referrer_domain | STRING | The domain of the page a visitor has come from  (in the converting entry |
|  referrer_matchType | STRING | The match type of the page a visitor has come from  (in the converting entry |
|  first_click_value | FLOAT | This column will only have a value for entries that were first in purchase cycle. They bear the full transactional value of purchase cycle. |
|  even_click_value | FLOAT | The transactional value divided by the number of entries in purchase cycle |
|  last_click_value | FLOAT | This column will only have a value for entries that were last in purchase cycle. They bear the full transactional value of purchase cycle. |
|  pageviews_in_entry | INTEGER | The total number of views in entry |
|  entries_in_purchase_cycle | INTEGER | The total number of entries in purchase cycle |
|  behavioural_value | FLOAT | The transactional value attributed to entry based on its behavioural value |
|  conversion_value_in_purchase_cycle | FLOAT | The total transactional value |
|  touchpoint | STRING | The label for entry i.e. First, Last, Assit and Single entry - designates where in purchase cycle the entry happened |
|  true_referrer_type | STRING | Normalised referrer_type |
|  purchase_cycle_group | STRING | Purchase cycle group bucketed into 5 values:  1,2,3,4, 5+, |
|  property_event_ts | TIMESTAMP | The timestamp of transaction in client property local time |
