CREATE TEMPORARY TABLE first_pageviews_moja
SELECT 
    website_session_id,
    website_pageviews.pageview_url AS landing_page,
    MIN(website_pageview_id) AS min_pageview_id_LP
FROM website_pageviews
WHERE created_at BETWEEN '2014-01-01' AND '2014-02-01'
	GROUP BY website_session_id;

CREATE TEMPORARY TABLE bounced
SELECT 
	website_session_id,
    COUNT(website_pageview_id) AS nr_of_pageviews
FROM website_pageviews
WHERE created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY website_session_id;

SELECT 
    first_pageviews_moja.landing_page,
    COUNT(*) AS all_sessions,
    COUNT(CASE bounced.nr_of_pageviews WHEN bounced.nr_of_pageviews = 1 THEN '1' END) AS bounced_sessions,
    COUNT(CASE bounced.nr_of_pageviews WHEN bounced.nr_of_pageviews = 1 THEN '1' END) / COUNT(*) AS bounce_rate
FROM  first_pageviews_moja
JOIN bounced ON first_pageviews_moja.website_session_id = bounced.website_session_id
GROUP BY first_pageviews_moja.landing_page
ORDER BY landing_page;
