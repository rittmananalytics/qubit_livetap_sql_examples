# Transactions (livetap_transactions)

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  transaction_id | STRING | Order ID |
|  context_id | STRING | Visitor ID based on browser cookie |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  context_entranceNumber | INTEGER | The sequential entrance number of a user in her/his lifetime (across all sessions) |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all sessions) up to the current view |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone |
|  meta_ts | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  basket_total_baseValue | FLOAT | Total paid for order in base currency |
|  basket_tax_baseValue | FLOAT | Total tax paid for order  in base currency |
|  basket_total_universalValue | FLOAT | Total paid for order in universal currency |
|  basket_subtotal_baseValue | FLOAT | Subtotal paid for order in base currency |
|  basket_quantity | INTEGER | Quantity of items in basket |
|  basket_discount_baseValue | FLOAT | Total value discounted from order in base currency |
|  transaction_total | FLOAT | Equal to basket_total_baseValue |
|  basket_shippingPrice_baseValue | FLOAT | Total paid for shipping in base currency |
|  session_id | STRING | Unique ID of session |
|  entrance_id | STRING | Unique ID of entrance |
|  view_id | STRING | Unique ID of view |
|  previous_transaction_ts | INTEGER | Epoch time of previous transaction |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
