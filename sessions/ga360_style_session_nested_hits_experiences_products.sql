WITH
  q_session_v01 AS (
  SELECT
    *
  FROM
    `qubit-client-37262.wolfandbadger__v2.livetap_session`
  WHERE
    ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
        AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) ),
  q_entrance_v01 AS (
  SELECT
    *
  FROM
    `qubit-client-37262.wolfandbadger__v2.livetap_entrance`
  WHERE
    ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
        AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) ),
  q_transaction_v01 AS (
  SELECT
    *
  FROM
    `qubit-client-37262.wolfandbadger__v2.livetap_transaction`
  WHERE
    ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
        AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) ),
  q_product_v01 AS (
  SELECT
    meta_recordDate,
    ts,
    property_event_ts,
    view_id,
    session_id,
    entrance_id,
    meta_serverTs,
    meta_ts,
    meta_trackingId,
    context_id,
    context_viewNumber,
    context_sessionNumber,
    context_conversionNumber,
    transaction_id,
    product_rows,
    product.concat_product_id product_concat_product_id,
    product.product_productId product_productId,
    product.product_sku product_sku,
    product.product_category product_category,
    product.product_subcategory product_subcategory,
    product.product_manufacturer product_manufacturer,
    product.product_color product_color,
    product.product_size product_size,
    product.product_stock product_stock,
    product.product_rating product_rating,
    product.product_price_baseValue product_price_baseValue,
    product.product_originalPrice_baseValue product_originalPrice_baseValue,
    product.product_price_baseCurrency product_price_baseCurrency,
    product.product_name product_name,
    product.product_basket_action product_basket_action,
    product.subtotal_baseValue subtotal_baseValue,
    product.quantity quantity,
    product.unique_row_id unique_row_id,
    product.product_interaction_type product_interaction_type,
    product.meta_type meta_type
  FROM
    `qubit-client-37262.wolfandbadger__v2.livetap_product` v
  LEFT JOIN
    UNNEST (product) AS product
  WHERE
    ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
        AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) ),
  q_experience_v01 AS (
  SELECT
    qp_bi_view_name,
    ts,
    property_event_ts,
    view_id,
    meta_recordDate,
    meta_trackingId,
    context_id,
    context_viewNumber,
    context_sessionNumber,
    context_conversionNumber,
    meta_ts,
    meta_serverTs,
    experience.experienceId AS experienceId,
    experience.experienceName AS experienceName,
    experience.variationMasterId AS variationMasterId,
    experience.variationName AS variationName,
    experience.iterationName AS iterationName,
    experience.iterationId AS iterationId,
    experience.isControl AS isControl,
    experience.first_view_meta_ts AS first_view_meta_ts,
    experience.first_view_meta_recordDate AS first_view_meta_recordDate,
    experience.first_view_in_iteration AS first_view_in_iteration,
    experience.last_view_in_iteration AS last_view_in_iteration,
    experience.is_post_experience_view AS is_post_experience_view,
    experience.trafficAllocation AS trafficAllocation,
    experience.experience_status AS experience_status,
    experience.days_experience_live AS days_experience_live,
    experience.experience_first_published_at AS experience_first_published_at,
    experience.iteration_published_at AS iteration_published_at,
    experience.iteration_paused_at AS iteration_paused_at,
    experience.experience_last_paused_at AS experience_last_paused_at,
    experience.experience_paused_on_view AS experience_paused_on_view,
    experience.experience_paused_within_15_days AS experience_paused_within_15_days
  FROM
    `qubit-client-37262.wolfandbadger__v2.livetap_experience`
  LEFT JOIN
    UNNEST (experience) AS experience
  WHERE
    ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
        AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY))))) ),
  q_experience_meta_data_v01 AS (
  SELECT
    CAST(experienceId AS STRING) experienceId,
    DATE(MAX(experience_last_paused_at)) experience_last_paused_at,
    DATE(MIN(experience_first_published_at)) experience_first_published_at
  FROM (
    SELECT
      *,
      MIN(iteration_published_at) OVER (PARTITION BY experienceId) AS experience_first_published_at,
      CAST(DATE(iteration_paused_at) AS STRING) iteration_paused_at_date,
      CAST(DATE(iteration_published_at) AS STRING) iteration_published_at_date,
      UNIX_MILLIS(iteration_paused_at) AS iteration_paused_at_unix_ts,
      MAX(iteration_paused_at) OVER (PARTITION BY experienceId) AS experience_last_paused_at
    FROM (
      SELECT
        COALESCE(iteration_published_at_first,
          iteration_started_at,
          iteration_created_at,
          iteration_upadted_at) AS iteration_published_at,
        *
      FROM (
        SELECT
          experienceId AS experienceId,
          variationMasterId AS variationMasterId,
          iterationId AS iterationId,
          MAX(experienceName) AS experienceName,
          MAX(variationName) AS variationName,
          MAX(iterationName) AS iterationName,
          MIN(CASE
              WHEN iterationUpdatedAt > COALESCE(iterationStartedAt, TIMESTAMP_MILLIS(0)) AND iterationPausedAt IS NULL THEN iterationUpdatedAt
              WHEN iterationPausedAt > COALESCE(iterationStartedAt,
              TIMESTAMP_MILLIS(0))
            AND iterationPausedAt > COALESCE(iterationPublishedAt,
              TIMESTAMP_MILLIS(0))
            AND iterationPausedAt > COALESCE(iterationResumedAt,
              TIMESTAMP_MILLIS(0)) THEN iterationPausedAt
            ELSE
            TIMESTAMP('2030-01-01 00:00:00 UTC')
          END
            ) AS iteration_paused_at,
          MIN(iterationPublishedAt) AS iteration_published_at_first,
          MIN(iterationStartedAt) AS iteration_started_at,
          MIN(iterationCreatedAt) AS iteration_created_at,
          MIN(iterationUpdatedAt) AS iteration_upadted_at
        FROM
          `qubit-client-37262.wolfandbadger__v2.aux_experience_iteration_variation_v01`
        GROUP BY
          1,
          2,
          3) AS experience_metadata ) AS experience_metadata_1
    WHERE
      (experienceId IS NOT NULL
        AND CAST(experienceId AS STRING) != 'undefined'
        AND variationMasterId IS NOT NULL
        AND CAST(variationMasterId AS STRING) != 'undefined'
        AND iterationId IS NOT NULL
        AND CAST(iterationId AS STRING) != 'undefined' ))
  GROUP BY
    1 )
SELECT
  q_session_v01.context_id AS visitorId,
  q_session_v01.context_sessionNumber AS visitId,
  FORMAT_TIMESTAMP('%T', q_view_v01.property_event_ts ) AS visitStartTime,
  DATE(q_view_v01.property_event_ts) AS visitDate,
  ARRAY_AGG(STRUCT( q_entrance_v01.referrer_url AS referralPath,
      q_entrance_v01.referrer_network AS referrerNetwork,
      q_entrance_v01.referrer_type AS referrerType,
      q_entrance_v01.referrer_label AS referrerLabel,
      q_entrance_v01.utm_campaign AS campaign,
      q_entrance_v01.utm_content AS content,
      q_entrance_v01.utm_medium AS medium,
      q_entrance_v01.utm_source AS source,
      q_entrance_v01.utm_term AS term )) trafficSource,
  ARRAY_AGG(STRUCT( q_session_v01.appName AS browser,
      q_session_v01.appVersion AS browserVersion,
      q_session_v01.deviceName AS device,
      q_session_v01.deviceType AS deviceType,
      q_session_v01.osName AS operatingSystem,
      q_session_v01.osVersion AS operatingSystemVersion )) device,
  ARRAY_AGG(STRUCT( q_session_v01.ipLocation_region AS region,
      q_session_v01.ipLocation_country AS country,
      q_session_v01.ipLocation_area AS q_session_v01_ip_location_area,
      q_session_v01.ipLocation_city AS q_session_v01_ip_location_city )) geoNetwork,
  ARRAY_AGG(STRUCT(q_view_v01.context_viewNumber AS hitNumber,
      q_view_v01.property_event_ts AS time,
      q_view_v01.meta_url AS pagePath,
      q_view_v01.page_type AS PageType,
      q_view_v01.page_subtype AS PageSubType )) hits,
  ARRAY_AGG(STRUCT(q_product_v01.product_productId AS productId,
      q_product_v01.product_sku AS productSKU,
      q_product_v01.product_name AS productName,
      q_product_v01.product_category AS productCategory,
      q_product_v01.product_subcategory AS productSubcategory,
      q_product_v01.product_interaction_type AS productInteractionType,
      CASE
        WHEN q_product_v01.product_interaction_type = 'Product Listing View' THEN '1. Product Listing View'
        WHEN q_product_v01.product_interaction_type = 'Product Detail View' THEN '2. Product Detail View'
        WHEN q_product_v01.product_interaction_type = 'Product View' THEN '2. Product Detail View'
        WHEN q_product_v01.product_interaction_type = 'View with Product in Basket' THEN '3. View with Product in Basket'
        WHEN q_product_v01.product_interaction_type = 'Basket Action' THEN '4. Basket Action'
        WHEN q_product_v01.product_interaction_type = 'Product Purchase' THEN '5. Product Purchase'
      ELSE
      q_product_v01.product_interaction_type
    END
      AS productInteractionTypeOrdered,
      q_product_v01.product_size AS productSize,
      q_product_v01.product_rating AS productRating,
      q_product_v01.product_stock AS productStock,
    IF
      (q_product_v01.transaction_id IS NOT NULL,
        q_product_v01.quantity,
        NULL) AS productQuantity,
      q_product_v01.product_price_baseValue AS productPrice,
      q_product_v01.product_originalPrice_baseValue AS productOriginalPrice,
      q_product_v01.product_manufacturer AS productManufacturer,
      q_product_v01.product_price_baseCurrency AS productPriceCurrency,
      q_product_v01.product_color AS productColor )) product,
  ARRAY_AGG(STRUCT( CAST(q_experience_v01.experienceId AS STRING) AS experienceId,
      CAST(q_experience_v01.iterationId AS STRING) AS iterationId,
      CAST(q_experience_v01.variationMasterId AS STRING) AS variationMasterId,
      q_experience_v01.experienceName AS experienceName,
      q_experience_v01.variationName AS variationName,
    IF
      (q_experience_meta_data_v01.experience_last_paused_at <= CURRENT_DATE(),
        "Paused",
        "Active") AS currentExperiencestatus,
      CAST(TIMESTAMP(q_experience_meta_data_v01.experience_first_published_at) AS DATE) AS experienceFirstPublishedAt,
      CASE
        WHEN q_experience_v01.isControl = 1 THEN 'Yes'
      ELSE
      'No'
    END
      AS isControl,
      CASE
        WHEN q_experience_v01.experience_paused_within_15_days = 1 THEN 'Paused for 15 days or less'
        WHEN q_experience_v01.experience_status = 'Paused' THEN 'Paused for more than 15 days'
        WHEN q_experience_v01.experience_status = 'Live' THEN 'Live'
    END
      AS statusAsOfDate,
      CAST(TIMESTAMP(q_experience_meta_data_v01.experience_last_paused_at) AS DATE) AS experienceLastPausedAt,
      CASE
        WHEN q_experience_v01.experience_paused_on_view = 1 THEN 'Yes'
      ELSE
      'No'
    END
      AS experiencePausedOnView,
      CAST(TIMESTAMP(q_experience_v01.iteration_paused_at) AS DATE) AS iterationPausedAt,
      CAST(TIMESTAMP(q_experience_v01.iteration_published_at) AS DATE) AS iterationPublishedAt,
    IF
      (q_experience_v01.trafficAllocation IS NOT NULL,
        CAST(q_experience_v01.trafficAllocation AS NUMERIC),
        1) AS trafficAllocation ) ) experience,
  STRUCT( COUNT(DISTINCT q_session_v01.session_id) AS q_session_v01_sessions,
    COUNT(DISTINCT q_view_v01.view_id) AS q_view_v01_views,
    COUNT(DISTINCT q_transaction_v01.transaction_id) AS transactions,
    SUM(q_transaction_v01.basket_total_baseValue) AS total_transactions) totals
FROM
  `qubit-client-37262.wolfandbadger__v2.livetap_view` AS q_view_v01
LEFT JOIN
  q_session_v01
ON
  q_session_v01.session_id = q_view_v01.session_id
LEFT JOIN
  q_entrance_v01
ON
  q_entrance_v01.entrance_id = q_view_v01.entrance_id
LEFT JOIN
  q_transaction_v01
ON
  q_view_v01.view_id = q_transaction_v01.view_id
LEFT JOIN
  q_product_v01
ON
  q_product_v01.view_id = q_view_v01.view_id
LEFT JOIN
  q_experience_v01
ON
  q_view_v01.view_id = q_experience_v01.view_id
LEFT JOIN
  q_experience_meta_data_v01
ON
  q_experience_v01.experienceId = q_experience_meta_data_v01.experienceId
WHERE
  (((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY)))
      AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY
  1,
  2,
  3,
  4
LIMIT
  500
