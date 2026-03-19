-- EXECUTIVE KPI SUMMARY
SELECT
    COUNT(DISTINCT ws.website_session_id) AS total_sessions,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        COUNT(DISTINCT o.order_id)::numeric / COUNT(DISTINCT ws.website_session_id),
        4
    ) AS conversion_rate,
    ROUND(COALESCE(SUM(o.price_usd), 0)::numeric, 2) AS total_revenue,
    ROUND(
        (COALESCE(SUM(o.price_usd), 0) / COUNT(DISTINCT ws.website_session_id))::numeric,
        4
    ) AS revenue_per_session,
    ROUND(
        (COALESCE(SUM(o.price_usd), 0) / NULLIF(COUNT(DISTINCT o.order_id), 0))::numeric,
        2
    ) AS average_order_value
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id;

-- OVERALL FUNNEL COUNTS

WITH session_funnel_flags AS (
    SELECT
        website_session_id,
        MAX(CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END) AS saw_products,
        MAX(CASE WHEN pageview_url IN (
            '/the-original-mr-fuzzy',
            '/the-forever-love-bear',
            '/the-birthday-sugar-panda',
            '/the-hudson-river-mini-bear'
        ) THEN 1 ELSE 0 END) AS saw_product_detail,
        MAX(CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END) AS saw_cart,
        MAX(CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END) AS saw_shipping,
        MAX(CASE WHEN pageview_url IN ('/billing', '/billing-2') THEN 1 ELSE 0 END) AS saw_billing,
        MAX(CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END) AS saw_order
    FROM website_pageviews
    GROUP BY website_session_id
)
SELECT
    COUNT(*) AS total_sessions,
    SUM(saw_products) AS sessions_to_products,
    SUM(saw_product_detail) AS sessions_to_product_detail,
    SUM(saw_cart) AS sessions_to_cart,
    SUM(saw_shipping) AS sessions_to_shipping,
    SUM(saw_billing) AS sessions_to_billing,
    SUM(saw_order) AS sessions_to_orders
FROM session_funnel_flags;

-- OVERALL FUNNEL STEP CONVERSION RATES

WITH session_funnel_flags AS (
    SELECT
        website_session_id,
        MAX(CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END) AS saw_products,
        MAX(CASE WHEN pageview_url IN (
            '/the-original-mr-fuzzy',
            '/the-forever-love-bear',
            '/the-birthday-sugar-panda',
            '/the-hudson-river-mini-bear'
        ) THEN 1 ELSE 0 END) AS saw_product_detail,
        MAX(CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END) AS saw_cart,
        MAX(CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END) AS saw_shipping,
        MAX(CASE WHEN pageview_url IN ('/billing', '/billing-2') THEN 1 ELSE 0 END) AS saw_billing,
        MAX(CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END) AS saw_order
    FROM website_pageviews
    GROUP BY website_session_id
),
funnel AS (
    SELECT
        COUNT(*) AS total_sessions,
        SUM(saw_products) AS sessions_to_products,
        SUM(saw_product_detail) AS sessions_to_product_detail,
        SUM(saw_cart) AS sessions_to_cart,
        SUM(saw_shipping) AS sessions_to_shipping,
        SUM(saw_billing) AS sessions_to_billing,
        SUM(saw_order) AS sessions_to_orders
    FROM session_funnel_flags
)
SELECT
    total_sessions,
    sessions_to_products,
    ROUND(sessions_to_products::numeric / NULLIF(total_sessions, 0), 4) AS pct_sessions_to_products,
    sessions_to_product_detail,
    ROUND(sessions_to_product_detail::numeric / NULLIF(sessions_to_products, 0), 4) AS pct_products_to_detail,
    sessions_to_cart,
    ROUND(sessions_to_cart::numeric / NULLIF(sessions_to_product_detail, 0), 4) AS pct_detail_to_cart,
    sessions_to_shipping,
    ROUND(sessions_to_shipping::numeric / NULLIF(sessions_to_cart, 0), 4) AS pct_cart_to_shipping,
    sessions_to_billing,
    ROUND(sessions_to_billing::numeric / NULLIF(sessions_to_shipping, 0), 4) AS pct_shipping_to_billing,
    sessions_to_orders,
    ROUND(sessions_to_orders::numeric / NULLIF(sessions_to_billing, 0), 4) AS pct_billing_to_order
FROM funnel;

-- CHANNEL PERFORMANCE SUMMARY

SELECT
    COALESCE(ws.utm_source, 'direct/unknown') AS utm_source,
    COALESCE(ws.utm_campaign, 'none') AS utm_campaign,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id)::numeric / COUNT(DISTINCT ws.website_session_id),
        4
    ) AS conversion_rate,
    ROUND(COALESCE(SUM(o.price_usd), 0)::numeric, 2) AS revenue,
    ROUND(
        (COALESCE(SUM(o.price_usd), 0) / COUNT(DISTINCT ws.website_session_id))::numeric,
        4
    ) AS revenue_per_session,
    ROUND(
        (COALESCE(SUM(o.price_usd), 0) / NULLIF(COUNT(DISTINCT o.order_id), 0))::numeric,
        2
    ) AS average_order_value
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY 1, 2
ORDER BY revenue DESC;


-- CHANNEL FUNNEL PERFORMANCE SUMMARY

WITH session_funnel_flags AS (
    SELECT
        website_session_id,
        MAX(CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END) AS saw_products,
        MAX(CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END) AS saw_cart,
        MAX(CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END) AS saw_shipping,
        MAX(CASE WHEN pageview_url IN ('/billing', '/billing-2') THEN 1 ELSE 0 END) AS saw_billing,
        MAX(CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END) AS saw_order
    FROM website_pageviews
    GROUP BY website_session_id
)
SELECT
    COALESCE(ws.utm_source, 'direct/unknown') AS utm_source,
    COALESCE(ws.utm_campaign, 'none') AS utm_campaign,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    SUM(sf.saw_products) AS products_stage,
    SUM(sf.saw_cart) AS cart_stage,
    SUM(sf.saw_shipping) AS shipping_stage,
    SUM(sf.saw_billing) AS billing_stage,
    SUM(sf.saw_order) AS order_stage
FROM website_sessions ws
LEFT JOIN session_funnel_flags sf
    ON ws.website_session_id = sf.website_session_id
GROUP BY 1, 2
ORDER BY sessions DESC;

-- LANDING PAGE PERFORMANCE SUMMARY

WITH first_pageview AS (
    SELECT
        website_session_id,
        MIN(website_pageview_id) AS first_pageview_id
    FROM website_pageviews
    GROUP BY website_session_id
),
landing_pages AS (
    SELECT
        fp.website_session_id,
        wp.pageview_url AS landing_page
    FROM first_pageview fp
    JOIN website_pageviews wp
        ON fp.first_pageview_id = wp.website_pageview_id
)
SELECT
    lp.landing_page,
    COUNT(DISTINCT lp.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id)::numeric / COUNT(DISTINCT lp.website_session_id),
        4
    ) AS conversion_rate,
    ROUND(COALESCE(SUM(o.price_usd), 0)::numeric, 2) AS revenue,
    ROUND(
        (COALESCE(SUM(o.price_usd), 0) / COUNT(DISTINCT lp.website_session_id))::numeric,
        4
    ) AS revenue_per_session
FROM landing_pages lp
LEFT JOIN orders o
    ON lp.website_session_id = o.website_session_id
GROUP BY lp.landing_page
ORDER BY sessions DESC;

-- MONTHLY TRENDS (OVERALL)

SELECT
    DATE_TRUNC('month', ws.created_at)::date AS month_start,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id)::numeric / COUNT(DISTINCT ws.website_session_id),
        4
    ) AS conversion_rate,
    ROUND(COALESCE(SUM(o.price_usd), 0)::numeric, 2) AS revenue,
    ROUND(
        (COALESCE(SUM(o.price_usd), 0) / COUNT(DISTINCT ws.website_session_id))::numeric,
        4
    ) AS revenue_per_session
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY 1
ORDER BY 1;

-- MONTHLY TRENDS BY CHANNEL

SELECT
    DATE_TRUNC('month', ws.created_at)::date AS month_start,
    COALESCE(ws.utm_source, 'direct/unknown') AS utm_source,
    COALESCE(ws.utm_campaign, 'none') AS utm_campaign,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id)::numeric / COUNT(DISTINCT ws.website_session_id),
        4
    ) AS conversion_rate,
    ROUND(COALESCE(SUM(o.price_usd), 0)::numeric, 2) AS revenue,
    ROUND(
        (COALESCE(SUM(o.price_usd), 0) / COUNT(DISTINCT ws.website_session_id))::numeric,
        4
    ) AS revenue_per_session
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;


-- LANDING PAGE CONVERSION RATE OVER TIME
WITH first_pageviews AS (
    SELECT
        website_session_id,
        MIN(website_pageview_id) AS first_pageview_id
    FROM website_pageviews
    GROUP BY website_session_id
),
landing_pages AS (
    SELECT
        fp.website_session_id,
        wp.pageview_url AS landing_page
    FROM first_pageviews fp
    JOIN website_pageviews wp
        ON fp.first_pageview_id = wp.website_pageview_id
),
landing_page_monthly AS (
    SELECT
        DATE_TRUNC('month', ws.created_at)::date AS month_start,
        lp.landing_page,
        COUNT(DISTINCT ws.website_session_id) AS sessions,
        COUNT(DISTINCT o.order_id) AS orders,
        ROUND(
            COUNT(DISTINCT o.order_id)::numeric / COUNT(DISTINCT ws.website_session_id),
            4
        ) AS conversion_rate,
        ROUND(COALESCE(SUM(o.price_usd), 0)::numeric, 2) AS revenue,
        ROUND(
            (COALESCE(SUM(o.price_usd), 0) / COUNT(DISTINCT ws.website_session_id))::numeric,
            4
        ) AS revenue_per_session
    FROM website_sessions ws
    JOIN landing_pages lp
        ON ws.website_session_id = lp.website_session_id
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
    GROUP BY 1, 2
)
SELECT *
FROM landing_page_monthly
ORDER BY month_start, landing_page;


-- FUNNEL STEP CONVERSION RATE OVER TIME
WITH session_funnel_flags AS (
    SELECT
        ws.website_session_id,
        DATE_TRUNC('month', ws.created_at)::date AS month_start,
        MAX(CASE WHEN wp.pageview_url = '/products' THEN 1 ELSE 0 END) AS saw_products,
        MAX(CASE WHEN wp.pageview_url IN (
            '/the-original-mr-fuzzy',
            '/the-forever-love-bear',
            '/the-birthday-sugar-panda',
            '/the-hudson-river-mini-bear'
        ) THEN 1 ELSE 0 END) AS saw_product_detail,
        MAX(CASE WHEN wp.pageview_url = '/cart' THEN 1 ELSE 0 END) AS saw_cart,
        MAX(CASE WHEN wp.pageview_url = '/shipping' THEN 1 ELSE 0 END) AS saw_shipping,
        MAX(CASE WHEN wp.pageview_url IN ('/billing', '/billing-2') THEN 1 ELSE 0 END) AS saw_billing
    FROM website_sessions ws
    LEFT JOIN website_pageviews wp
        ON ws.website_session_id = wp.website_session_id
    GROUP BY 1, 2
),
monthly_orders AS (
    SELECT
        DATE_TRUNC('month', ws.created_at)::date AS month_start,
        COUNT(DISTINCT o.order_id) AS orders
    FROM website_sessions ws
    LEFT JOIN orders o
        ON ws.website_session_id = o.website_session_id
    GROUP BY 1
),
monthly_funnel AS (
    SELECT
        month_start,
        COUNT(*) AS total_sessions,
        SUM(saw_products) AS products,
        SUM(saw_product_detail) AS product_detail,
        SUM(saw_cart) AS cart,
        SUM(saw_shipping) AS shipping,
        SUM(saw_billing) AS billing
    FROM session_funnel_flags
    GROUP BY 1
),
funnel_with_orders AS (
    SELECT
        mf.month_start,
        mf.total_sessions,
        mf.products,
        mf.product_detail,
        mf.cart,
        mf.shipping,
        mf.billing,
        COALESCE(mo.orders, 0) AS orders
    FROM monthly_funnel mf
    LEFT JOIN monthly_orders mo
        ON mf.month_start = mo.month_start
)
SELECT
    month_start,
    'Sess > Prod' AS funnel_step,
    1 AS step_sort,
    ROUND(products::numeric / NULLIF(total_sessions, 0), 4) AS step_rate
FROM funnel_with_orders

UNION ALL

SELECT
    month_start,
    'Prod > Detail',
    2,
    ROUND(product_detail::numeric / NULLIF(products, 0), 4)
FROM funnel_with_orders

UNION ALL

SELECT
    month_start,
    'Detail > Cart',
    3,
    ROUND(cart::numeric / NULLIF(product_detail, 0), 4)
FROM funnel_with_orders

UNION ALL

SELECT
    month_start,
    'Cart > Ship',
    4,
    ROUND(shipping::numeric / NULLIF(cart, 0), 4)
FROM funnel_with_orders

UNION ALL

SELECT
    month_start,
    'Ship > Bill',
    5,
    ROUND(billing::numeric / NULLIF(shipping, 0), 4)
FROM funnel_with_orders

UNION ALL

SELECT
    month_start,
    'Bill > Order',
    6,
    ROUND(orders::numeric / NULLIF(billing, 0), 4)
FROM funnel_with_orders

ORDER BY month_start, step_sort;
