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
