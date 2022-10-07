create or replace table analytics_xxxxx.fb_test as

SELECT
cast(safe_divide(cast(event_timestamp as int64), 10000000) as int64) event_time,
'test' as event_name,
TO_JSON_STRING (
 STRUCT (
    (select value.string_value from t0.event_params where key ='fbp') as fbp
 )

) as user_data,

"https://beardsanalytics.com/" as event_source_url,
"website" as action_source

FROM `analytics_xxxxx.events_202209*` t0, unnest(event_params) ep
where ep.key = 'fbp' and event_name = 'page_view'
