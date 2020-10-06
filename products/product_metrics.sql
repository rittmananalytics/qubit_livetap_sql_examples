WITH q_product_v01 AS (SELECT
          property_event_ts,
          view_id,
          context_id,
          context_viewNumber,
          context_sessionNumber,
          context_conversionNumber,
          transaction_id,
          product.product_productId  product_productId,
          product.product_sku  product_sku,
          product.product_category product_category,
          product.product_subcategory product_subcategory,
          product.product_manufacturer product_manufacturer,
          product.product_color  product_color,
          product.product_size product_size,
          product.product_stock  product_stock,
          product.product_rating  product_rating,
          product.product_price_baseValue  product_price_baseValue,
          product.product_originalPrice_baseValue product_originalPrice_baseValue,
          product.product_price_baseCurrency product_price_baseCurrency,
          product.product_name product_name,
          product.product_basket_action product_basket_action,
          product.subtotal_baseValue subtotal_baseValue,
          product.quantity quantity,
          product.meta_type meta_type
        FROM
          `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_product` v
        LEFT JOIN
          UNNEST (product) AS product
        WHERE
          ((( property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND ( property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
        )
SELECT
	q_product_v01.product_name  AS product_name,
	COUNT(DISTINCT q_product_v01.transaction_id)  AS product_orders,
	COUNT(DISTINCT(IF(q_product_v01.meta_type LIKE '%ecProduct', q_product_v01.view_id,NULL))) AS product_views,
	COUNT(DISTINCT q_product_v01.context_id)  AS product_visitors,
	COUNT(DISTINCT(IF(q_product_v01.meta_type LIKE '%ecBasketItem', q_product_v01.view_id,NULL))) AS basket_views,
	COUNT(DISTINCT IF(q_product_v01.transaction_id IS NOT NULL, q_product_v01.context_id, NULL))  AS converters
FROM `qubit-client-CLIENTPROJECTNUM.PROJECTNAME__v2.livetap_view`  AS q_view_v01
LEFT JOIN q_product_v01 ON q_product_v01.view_id = q_view_v01.view_id

WHERE
	(((q_view_v01.property_event_ts ) >= ((TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY))) AND (q_view_v01.property_event_ts ) < ((TIMESTAMP_ADD(TIMESTAMP_ADD(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), DAY), INTERVAL -6 DAY), INTERVAL 7 DAY)))))
GROUP BY 1
ORDER BY 2 DESC
LIMIT 500
