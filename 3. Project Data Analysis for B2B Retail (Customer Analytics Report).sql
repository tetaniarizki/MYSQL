-- Latar Belakang ---
-- xyz.com adalah perusahan rintisan B2B yang menjual berbagai produk tidak langsung kepada end user tetapi ke bisnis/perusahaan lainnya. 
-- Sebagai data-driven company, maka setiap pengambilan keputusan di xyz.com selalu berdasarkan data. 
-- Setiap quarter xyz.com akan mengadakan townhall dimana seluruh atau perwakilan divisi akan berkumpul untuk me-review performance perusahaan selama quarter terakhir.

-- Sebagai seorang data analyst, kita dimintai untuk menyediakan data dan analisa mengenai kondisi perusahaan bulan terakhir untuk dipresentasikan di townhall tersebut. 
-- (Asumsikan tahun yang sedang berjalan adalah tahun 2004 dan data yang digunakan hanya sampai bulan Juni).

-- Adapun hal yang akan direview adalah :
-- 1. Bagaimana pertumbuhan penjualan saat ini?
-- 2. Apakah jumlah customers xyz.com semakin bertambah ?
-- 3. Dan seberapa banyak customers tersebut yang sudah melakukan transaksi?
-- 4. Category produk apa saja yang paling banyak dibeli oleh customers?
-- 5. Seberapa banyak customers yang tetap aktif bertransaksi?

-- Let's begin !

## Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)
SELECT SUM(quantity) total_penjualan, SUM(quantity*priceeach) revenue
FROM orders_1
WHERE status='Shipped';

SELECT SUM(quantity) total_penjualan, SUM(quantity*priceeach) revenue
FROM orders_2
WHERE status='Shipped';

## Menghitung persentasi keseluruhan penjualan
SELECT quarter, SUM(quantity) total_penjualan, SUM(quantity*priceeach) revenue 
FROM
	( SELECT OrderNumber, status, quantity, priceeach,'1' quarter
	 FROM orders_1
	 WHERE status='Shipped'
	 UNION
	 SELECT OrderNumber, status, quantity, priceeach, '2' quarter
	 FROM orders_2
	 WHERE status='Shipped'
	) tabel_a
GROUP BY quarter;

-- Kedua query tersebut menghasilkan informasi bahwa
-- %Growth Penjualan = (6717 – 8694)/8694 = -22%
-- %Growth Revenue = (607548320 – 799579310)/ 799579310 = -24%

## Jumlah customers pada quarter ke-1 dan quarter ke-2
SELECT quarter, COUNT(DISTINCT customerID) total_customers
FROM 
	(SELECT customerID, createDate, QUARTER(createDate) quarter 
	FROM customer
	WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30') table_b
GROUP BY quarter;

## Jumlah customers yang melakukan transaksi pada quarter ke-1 dan quarter ke-2
SELECT quarter, COUNT(DISTINCT customerID) total_customers
FROM(
	SELECT customerID, createDate, QUARTER(createDate) quarter
	FROM customer
	WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30') tabel_b
WHERE customerID IN(
	SELECT DISTINCT customerID
	FROM orders_1
	UNION
	SELECT DISTINCT customerID
	FROM orders_2)
GROUP BY quarter;

## Category produk yang paling banyak di order pada quarter ke-2
SELECT*FROM
	(SELECT categoryID, COUNT(DISTINCT orderNumber) total_order, 	
	 		SUM(quantity) total_penjualan
	FROM (
			SELECT productCode, orderNumber, quantity, status, 		
				LEFT(productCode,3) categoryID
			FROM orders_2
			WHERE status='Shipped') tabel_c
	GROUP BY categoryID) a
ORDER BY total_order DESC;

## Retention cohort pada quarter ke-1 dan quarter ke-2
#Menghitung total unik customers yang transaksi di quarter_1
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;
#output = 25

SELECT '1' quarter, 
	((COUNT(DISTINCT customerID)/25)*100) Q2
FROM orders_1 a
WHERE customerID IN (
		SELECT DISTINCT customerID
		FROM orders_2);
        

-- Kesimpulan ---
-- Berdasarkan data yang telah kita peroleh melalui query SQL, Kita dapat menarik kesimpulan bahwa :

-- 1. Performance xyz.com menurun signifikan di quarter ke-2, terlihat dari nilai penjualan dan revenue yang drop hingga 20% dan 24%, 
-- perolehan customer baru juga tidak terlalu baik, dan sedikit menurun dibandingkan quarter sebelumnya.
-- 2. Ketertarikan customer baru untuk berbelanja di xyz.com masih kurang, hanya sekitar 56% saja yang sudah bertransaksi. 
-- Disarankan tim Produk untuk perlu mempelajari behaviour customer dan melakukan product improvement, sehingga conversion rate (register to transaction) dapat meningkat.
-- 3. Produk kategori S18 dan S24 berkontribusi sekitar 50% dari total order dan 60% dari total penjualan, 
-- sehingga xyz.com sebaiknya fokus untuk pengembangan category S18 dan S24.
-- 4. Retention rate customer xyz.com juga sangat rendah yaitu hanya 24%, 
-- artinya 76% customer yang sudah bertransaksi di quarter-1 tidak kembali melakukan order di quarter ke-2 (no repeat order).
-- xyz.com mengalami pertumbuhan negatif di quarter ke-2 dan perlu melakukan banyak improvement baik itu di sisi produk dan bisnis marketing, 
-- jika ingin mencapai target dan positif growth di quarter ke-3. 
-- Rendahnya retention rate dan conversion rate bisa menjadi diagnosa awal bahwa customer tidak tertarik/kurang puas/kecewa berbelanja di xyz.com.