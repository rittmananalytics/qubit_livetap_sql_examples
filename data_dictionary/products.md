# Products (livetap_product)

Views where products were displayed, interacted with, or purchased.

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
|  view_id | STRING | Unique ID of view |
|  session_id | STRING | Unique ID of session |
|  entrance_id | STRING | Unique ID of entrance |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all sessions) up to the current view |
|  transaction_id | STRING | Transaction ID if user submitted order on the page view |
|  product_rows | INTEGER | The number of products a visitor has interacted with on the view |
|  product.concat_product_id | STRING | product_productId and product_sku joined together |
|  product.product_productId | STRING | Product ID |
|  product.product_sku | STRING | Product SKU |
|  product.product_category | STRING | Product Category |
|  product.product_subcategory | STRING | Product Subcategory |
|  product.product_manufacturer | STRING | Product Manufacturer |
|  product.product_color | STRING | Product Colour |
|  product.product_size | STRING | Product Size |
|  product.product_stock | INTEGER | Product Stock Level |
|  product.product_rating | FLOAT | Product Rating |
|  product.product_price_baseValue | FLOAT | Product sales price (if on sales) or product regular price |
|  product.product_originalPrice_baseValue | FLOAT | Product original price (if on sales) or product regular price |
|  product.product_price_baseCurrency | STRING | Currency of product price |
|  product.product_name | STRING | Product Name |
|  product.subtotal_baseValue | FLOAT | If product was purchased, the subtotal paid for product (i.e. total excluding discounts etc) |
|  product.quantity | INTEGER | Quantity of items if purchased |
|  product.unique_row_id | STRING | Unique row ID |
|  product.product_interaction_type | STRING | Interaction type such as product view, basket addition, purchase, recommendation view etc. |
|  product.first_rec_product_click_within_30_days_prior_to_transaction_unix_ts | INTEGER | First timestamp of click within 30 day window prior to purchase |
|  product.first_rec_product_view_within_30_days_prior_to_transaction_unix_ts | INTEGER | First timestamp of view within 30 day window prior to purchase |
|  product.last_rec_product_click_within_30_days_prior_to_transaction_unix_ts | INTEGER | Last timestamp of click within 30 day window prior to purchase |
|  product.last_rec_product_view_within_30_days_prior_to_transaction_unix_ts | INTEGER | Last timestamp of view within 30 day window prior to purchase |
|  product.rec_product_clicks_within_30_days_prior_to_transaction | INTEGER | The number of clicks that happened prior to transaction (within 30 day window) |
|  product.rec_product_view_within_30_days_prior_to_transaction | INTEGER | The number of views that happened prior to transaction (within 30 day window) |
|  product.position | INTEGER | The position at which product was shown or clicked when displayed on recommendation carousel |
|  product.viewed_product_category | STRING | information about the product being viewed when recommendations are shown |
|  product.viewed_product_name | STRING | information about the product being viewed when recommendations are shown |
|  product.viewed_product_price | FLOAT | information about the product being viewed when recommendations are shown |
|  product.viewed_product_id | STRING | information about the product being viewed when recommendations are shown |
|  product.rec_shown_product_category | STRING | Information about the product being shown in recommendations |
|  product.rec_shown_product_name | STRING | Information about the product being shown in recommendations |
|  product.rec_shown_product_price | FLOAT | Information about the product being shown in recommendations |
|  product.rec_shown_product_id | STRING | Information about the product being shown in recommendations |
|  product.clicked_product_category | STRING | Information about products that were clicked on: |
|  product.clicked_product_name | STRING | Information about products that were clicked on: |
|  product.clicked_product_price | FLOAT | Information about products that were clicked on: |
|  product.clicked_product_id | STRING | Information about products that were clicked on: |
|  product.recommended_items_count | INTEGER | Count of product items that were recommended |
|  meta_type | STRING | The name of the original QP event the row comes from |
