{{config(materialized='table')}}

SELECT 'Mobile' AS payment_type, 'Payment using Phone' AS payment_label, 'Online' AS payment_category
UNION ALL
SELECT 'Way2ride', 'Payment using the Way2ride app', 'Online'
UNION ALL
SELECT 'No Charge','No Payment','Other'
UNION ALL
SELECT 'Credit Card', 'Payment using the credit card', 'Online'
UNION ALL
SELECT 'Cash', 'Payments using cash', 'Offline'
UNION ALL
SELECT 'Unknown','Payment using Unknown method','Other'
UNION ALL
SELECT 'Dispute','Payment accounted as a dispute','Other'
UNION ALL
SELECT 'Pcard','Eneterprise issued card','Online'
UNION ALL
SELECT 'Prepaid','Payment through online sources','Online'
UNION ALL
SELECT 'Prcard','Payment method unavailable','Other'
UNION ALL
SELECT 'Split','Payment split amongst people','Online'