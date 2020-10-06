# Live Tap eCommerce Data Dictionary

## Views (livetap_view)

All visitor page and view events, the base "event" to which all other events are linked

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

## Entrances (livetap_entrances)

Details every entrance for users, contains referrer details along with UTM parameter values.

An entrance is defined as any sequence of pageviews where the first page comes from an external link, entered URL, or bookmark and where all subsequent pageviews are triggered by a selection within the website. A view in the same session as the previous view that lacks a referrer url, and therefore might be considered a direct entrance, is not treated as a new entrance but as a continuation of the previous one. The view will only be treated as a new entrance if it has utm parameters that suggest it really is a new entrance.

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  view_id | STRING | Unique ID of view |
|  entrance_id | STRING | Unique ID of entrance. A new entrance is started if an attribute of the previous page is different i.e. the referrer, is on a different domain or if the url of<br/>  the `View` is typed in manually in the address bar. Reloading the browser or navigating between pages on the same domain will not cause entrance events to be emitted |
|  session_id | STRING | Unique ID of session - a session ends when a visitor is inactive for more than 30 minutes and starts when activity resumes after ending a session or on the first visit. |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_entranceNumber | INTEGER | The sequential entrance number of a user in her/his lifetime (across all sessions) |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all session) up to the current view |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_url | STRING | URL on which view was emitted |
|  referrer_url | STRING | The URL of the page a visitor has come from. |
|  referrer_type | STRING | The type of the page a visitor has come from e.g. affiliate. |
|  referrer_network | STRING | If applicable - the network of the page a visitor has come from e.g. affiliate window. |
|  referrer_mediaType | STRING | If applicable - the media type of the page a visitor has come from. |
|  referrer_campaign | STRING | If applicable - the campaign of the page a visitor has come from. |
|  referrer_adGroup | STRING | If applicable - the ad group of the page a visitor has come from. |
|  referrer_content | STRING | If applicable - the content of the page a visitor has come from. |
|  referrer_keywords | STRING | If applicable - the keywords a visitor used to get to the original page before the view. |
|  referrer_searchQuery | STRING | If applicable - the search query a visitor used to get to the original page before the view. |
|  referrer_label | STRING | The label of the page a visitor has come from. |
|  referrer_domain | STRING | The domain of the page a visitor has come from. |
|  referrer_matchType | STRING | The match type of the page a visitor has come from. |
|  utm_source | STRING | The value of Google UTM source parameter - extracted from landing page (meta_url) |
|  utm_medium | STRING | The value of Google UTM medium parameter - extracted from landing page (meta_url) |
|  utm_content | STRING | The value of Google UTM content parameter - extracted from landing page (meta_url) |
|  utm_campaign | STRING | The value of Google UTM campaign parameter - extracted from landing page (meta_url) |
|  utm_term | STRING | The value of Google UTM campaign term - extracted from landing page (meta_url) |

# Sessions (livetap_segment)

Details relating to the session in which a view event occured.

A session is defined as any sequence of pageviews with less than 30 minutes between each view.

Qubit uses a Media Rating Council accredited third-party service called NetAcuity from digitalelement for geolocation. As with all geolocation services, this uses an Internet Protocol address (IP) as a unique identifier to lookup a computer or computer network location. With varying degrees of accuracy, at its most precise, this method can map an IP address to a house. At its least precise, the same method may only map an address to a country.

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  session_id | STRING | Unique ID of session - a session ends when a visitor is inactive for more than 30 minutes and starts when activity resumes after ending a session or on the first visit. |
|  view_id | STRING | Unique ID of view |
|  entrance_id | STRING | Unique ID of entrance. A new entrance is started if an attribute of the previous page is different i.e. the referrer, is on a different domain or if the url of<br/>  the `View` is typed in manually in the address bar. Reloading the browser or navigating between pages on the same domain will not cause entrance events to be emitted |
|  property_event_ts | TIMESTAMP | The timestamp of event in client property local time |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_url | STRING | URL on which view was emitted |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_entranceNumber | INTEGER | The sequential entrance number of a user in her/his lifetime (across all sessions) |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all sessions) up to the current view |
|  deviceType | STRING | The type of device user initiated the session with e.g. computer, mobile, tablet, etc |
|  deviceName | STRING | The name of device user initiated the session with e.g. Iphone, Sony etc |
|  appType | STRING | The application type used on the device user initiated the session with e.g. browser |
|  appName | STRING | The application name used on the device user initiated the session with e.g. Chrome |
|  appVersion | STRING | The application version used on the device user initiated the session with e.g. 1.3 |
|  osName | STRING | The OS type used on the device user initiated the session with e.g. Windows |
|  osVersion | STRING | The OS version used on the device user initiated the session with e.g. 7 |
|  ipLocation_country | STRING | The country in which user initiated the session e.g. United Kingdon |
|  ipLocation_country_code | STRING | The code of country in which user initiated the session e.g. UK |
|  ipLocation_region | STRING | The region of country in which user initiated the session |
|  ipLocation_city | STRING | The city in which user initiated the session e.g. London |
|  ipLocation_area | STRING | The area of city in which user initiated the session |

# Products (livetap_product)

Views where products were displayed, interacted with, or purchased.

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

# Segments (livetap_segment)

Views that happened on or after a visitor entered a segment.

When visitors enter and leave segments, a segmentMembershipChangedEvent is generated, indicating which segment was entered or left, by which visitor, and in which context, e.g what was their state, what pages were they browsing, etc. This information can be joined to all other visitor events used for analysis, to answer questions such as:

- Which referrers do visitors in the Mobile visitors from France segment come from compared to visitors in other segments?
- What are the most purchased products by visitors in the VIP segment?
- What is the Exit Feedback left by visitors in the NPS Detractors segment?
- What is the average number of sessions before purchase for visitors in the Accessories Purchasers segment?

|  **Column Name** | **Data Type** | **Column Description** |
| --- | --- | --- |
|  qp_bi_view_name | STRING | Name of BI view, static field |
|  ts | TIMESTAMP | The time the record was materialised. NB do not use for purpose of analytics |
|  view_id | STRING | Unique ID of view |
|  meta_recordDate | STRING | The date pageview was received by the server in client property's timezone (in cllent property timezone) |
|  meta_ts | INTEGER | Epoch time of event - as emitted by user's browser. NB epoch time is in UTC timezone |
|  meta_serverTs | INTEGER | Epoch time of event - as received by server. NB epoch time is in UTC timezone |
|  meta_trackingId | STRING | The ID used that uniquely identifies client brand in Qubit |
|  context_id | STRING | Visitor ID based on browser cookie |
|  context_viewNumber | INTEGER | The sequential pageview number of a user in her/his lifetime (across all sessions) |
|  context_sessionNumber | INTEGER | The sequential session number of a user in her/his lifetime (across all sessions) |
|  context_conversionNumber | INTEGER | The number of conversions visitor has had (across all session) up to the current view |
|  segment_rows | INTEGER | The number of different segments the user was in at the time of the view |
|  segment.segmentId | STRING | The numeric ID of segment |
|  segment.segmentName | STRING | The name of segment |



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

# User Actions (livetap_user_actions)

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
