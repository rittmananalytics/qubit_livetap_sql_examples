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
