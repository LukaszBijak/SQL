
CREATE TEMPORARY TABLE first_page
SELECT 
	MIN(website_pageview_id) AS first_pageview,
    website_session_id,
    pageview_url
FROM website_pageviews
WHERE created_at < '2012-06-12'
GROUP BY website_session_id;


-- My solution 
SELECT 
	pageview_url,
    count(*)
FROM first_page
GROUP BY pageview_url;

-- Course solution
SELECT
	COUNT(first_page.f_pageview),
    website_pageviews.pageview_url
FROM first_page
LEFT JOIN website_pageviews ON first_page.f_pageview = website_pageviews.website_pageview_id
GROUP BY website_pageviews.pageview_url

