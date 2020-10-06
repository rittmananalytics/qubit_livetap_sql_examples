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
