##=== Overall performance by year
-- total penjualan (sales) dan jumlah order (number_of_order) dari tahun 2009 sampai 2012 (years)-- 
SELECT YEAR(order_date) years, SUM(sales) sales, COUNT(order_quantity) number_of_order  FROM dqlab_sales_store
WHERE order_status='Order Finished'
GROUP BY years
ORDER BY years;

#SELECT*FROM dqlab_sales_store;

##=== Overall performance by product sub categories
-- total penjualan (sales) berdasarkan sub category dari produk (product_sub_category) pada tahun 2011 dan 2012 saja (years) 
SELECT YEAR(order_date) years, product_sub_category, SUM(sales) sales
FROM dqlab_sales_store
WHERE (order_status='Order Finished') AND (YEAR(order_date) BETWEEN '2011' AND '2012')
GROUP BY YEAR(order_date), product_sub_category
ORDER BY YEAR(order_date), sales DESC;

##=== Promotion effectiveness and efficiency by years
-- Efektifitas dan efisiensi dari promosi yang dilakukan akan dianalisa berdasarkan Burn Rate yaitu 
-- dengan membandigkan total value promosi yang dikeluarkan terhadap total sales yang diperoleh
SELECT YEAR(order_date) years, sum(sales) sales, sum(discount_value) promotion_value, ROUND((SUM(discount_value)/SUM(sales))*100,2) burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status='Order Finished'
GROUP BY years
ORDER BY YEAR(order_date);


##=== Promotion effectiveness and efficiency by product sub category
SELECT YEAR(order_date) years, product_sub_category, product_category, SUM(sales) sales, sum(discount_value) promotion_value, ROUND((SUM(discount_value)/SUM(sales))*100,2) burn_rate_percentage
FROM dqlab_sales_store
WHERE YEAR(order_date)=2012 AND order_status='Order Finished'
GROUP BY YEAR(order_date), product_sub_category, product_category
ORDER BY sales DESC;

##=== Customers transaction per year
-- jumlah customer (number_of_customer) yang bertransaksi setiap tahun dari 2009 sampai 2012 (years)
SELECT YEAR(order_date) years, COUNT(DISTINCT customer) number_of_customer
FROM dqlab_sales_store
WHERE order_status='Order Finished'
GROUP BY years
ORDER BY years;