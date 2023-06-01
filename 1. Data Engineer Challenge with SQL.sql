CREATE database DQLAB;
USE DQLAB;

CREATE TABLE ms_pelanggan(
	no_urut INT,
    kode_cabang VARCHAR(45),
    kode_pelanggan VARCHAR(45),
    nama_pelanggan VARCHAR(45),
    alamat VARCHAR(100)
)ENGINE=InnoDB;

INSERT INTO ms_pelanggan(no_urut,kode_cabang,kode_pelanggan,nama_pelanggan,alamat)
VALUES(1,'jkt-001','cust0001','Eva Novianti, S.H.','Vila Sempilan, No. 67'),
		(2,'jkt-001','cust0002','Heidi Goh','Ruko Sawit Permai 72 No. 1'),
        (3,'jkt-002','cust0003','Unang Handoko','Vila Sempilan No. 1'),
        (4,'jkt-001','cust0004','Jokolono Sukarman','Permata Intan Berkilau Residence, Blok C5-7'),
        (5,'bdg-001','cust0005','Tommy Sinaga','Avatar Village, Blok C8 No. 888'),
        (6,'bdg-001','cust0006','Irwan Setianto','Rukan Gunung Seribu, Blok O1 - No. 1'),
        (7,'jkt-001','cust0007','Agus Cahyono','Jalan Motivasi Tinggi, Blok F4 - No. 8'),
        (8,'jkt-001','cust0008','Maria Sirait','Cluster Akasia Residence, Blok AA No. 3'),
        (9,'jkt-002','cust0009','Ir. Ita Nugraha','Perumahan Sagitarius, Gang Kelapa No. 6'),
        (10,'bdg-001','cust0010','Djoko Wardoyo, Drs.','Bukit Pintar Data, Blok A1 No. 1');

CREATE TABLE ms_produk(
	no_urut INT,
    kode_produk VARCHAR(45),
    nama_produk VARCHAR(100),
    harga DOUBLE
)ENGINE=InnoDB;

INSERT INTO ms_produk(no_urut,kode_produk,nama_produk,harga)
VALUES(1,'prod-01','Kotak Pensil DQLab',60500),
		(2,'prod-02','Flashdisk DQLab 64 GB',55000),
        (3,'prod-03','Gift Voucher DQLab 100rb',100000),
        (4,'prod-04','Flashdisk DQLab 32 GB',40000),
        (5,'prod-05','Gift Voucher DQLab 250rb',250000),
        (6,'prod-06','Pulpen Multifunction + Laser DQLab',92500),
        (7,'prod-07','Tas Travel Organizer DQLab',48000),
        (8,'prod-08','Gantungan Kunci DQLab',15800),
        (9,'prod-09','Buku Planner Agenda DQLab',92000),
        (10,'prod-10','Sticky Notes DQLab 500 sheets',55000);



CREATE TABLE tr_penjualan(
	kode_transaksi VARCHAR(45),
    kode_pelanggan VARCHAR(45),
    tanggal_transaksi DATE,
    kode_produk VARCHAR(45)
)ENGINE=InnoDB;

INSERT INTO tr_penjualan(tanggal_transaksi,kode_transaksi,kode_pelanggan,kode_produk)
VALUES('2019-06-07','tr-0001','cust0007','prod-01'),
		('2019-06-07','tr-0001','cust0007','prod-03'),
        ('2019-06-07','tr-0001','cust0007','prod-09'),
        ('2019-06-07','tr-0001','cust0007','prod-04'),
        ('2019-06-07','tr-0002','cust0001','prod-03'),
        ('2019-06-07','tr-0002','cust0001','prod-10'),
        ('2019-06-07','tr-0002','cust0001','prod-07'),
        ('2019-06-08','tr-0003','cust0004','prod-02'),
        ('2019-06-08','tr-0004','cust0004','prod-10'),
        ('2019-06-08','tr-0004','cust0004','prod-04'),
        ('2019-06-09','tr-0005','cust0003','prod-09'),
        ('2019-06-09','tr-0005','cust0003','prod-01'),
        ('2019-06-09','tr-0005','cust0003','prod-04'),
        ('2019-06-09','tr-0006','cust0008','prod-05'),
        ('2019-06-09','tr-0006','cust0008','prod-08');


CREATE TABLE tr_penjualan_detail(
	kode_transaksi VARCHAR(45),
    kode_produk VARCHAR(45),
    qty INT,
    harga_satuan INT
)ENGINE=InnoDB;

INSERT INTO tr_penjualan_detail(kode_transaksi,kode_produk,qty,harga_satuan)
VALUES('tr-0001','prod-04',3,40000),
		('tr-0001','prod-02',1,55000),
        ('tr-0002','prod-08',2,15800),
        ('tr-0003','prod-10',1,55000),
        ('tr-0004','prod-09',1,92000),
        ('tr-0005','prod-06',1,92500),
        ('tr-0006','prod-08',2,15800),
        ('tr-0007','prod-08',2,15800),
        ('tr-0008','prod-07',1,50000),
        ('tr-0009','prod-01',2,62500),
        ('tr-0010','prod-04',3,48000),
        ('tr-0010','prod-08',1,15800),
        ('tr-0010','prod-04',1,40000);
        
##=======daftar produk yang memiliki harga antara 50.000 and 150.000.
SELECT*FROM ms_produk WHERE harga BETWEEN 50000 AND 150000;
##======menampilkan semua produk yang mengandung kata Flashdisk.
SELECT*FROM ms_produk WHERE nama_produk LIKE "%Flashdisk%";
##======menampilkan nama pelanggan yang memiliki gelar
SELECT*FROM ms_pelanggan 
WHERE
nama_pelanggan LIKE "%S.H%" OR nama_pelanggan LIKE "%Ir.%" OR nama_pelanggan LIKE "%Drs.%";
##=====mengurutkan nama pelanggan
SELECT nama_pelanggan FROM ms_pelanggan
ORDER BY nama_pelanggan DESC;
##=====mengurutkan nama pelanggan tanpa memperhatikan abjad dari gelar. 
#Contoh: Ir. Agus Nugraha harus berada di atas Heidi Goh.
SELECT nama_pelanggan FROM ms_pelanggan 
ORDER BY
	CASE WHEN LEFT(nama_pelanggan,3)='Ir.' THEN
    SUBSTRING(nama_pelanggan,5,100) ELSE nama_pelanggan END ASC;
    
##===menampilkan nama pelanggan yang paling panjang
SELECT nama_pelanggan FROM ms_pelanggan
ORDER BY LENGTH(nama_pelanggan) DESC
LIMIT 1;
-- #subquery
-- SELECT * FROM (
-- 	SELECT nama_pelanggan FROM ms_pelanggan
-- ORDER BY length(nama_pelanggan) DESC, nama_pelanggan) as a
-- LIMIT 1;

##========menampilkan nama pelanggan yang paling panjang dan paling pendek
(SELECT nama_pelanggan FROM ms_pelanggan
ORDER BY LENGTH(nama_pelanggan) DESC
LIMIT 1)
UNION
(SELECT nama_pelanggan FROM ms_pelanggan
ORDER BY LENGTH(nama_pelanggan) ASC
LIMIT 1);
-- #UNION dan ORDER BY tidak boleh dalma satu query
-- #Sehingga penggunaan tanda kurung tersebut bertujuan untuk memisahkan UNION dan ORDER BY
-- SELECT * FROM
--  (
--    SELECT nama_pelanggan FROM ms_pelanggan
--    ORDER BY length(nama_pelanggan) desc,nama_pelanggan limit 1) as a
-- UNION
-- SELECT * FROM
--  (
--    SELECT nama_pelanggan FROM ms_pelanggan
--    ORDER BY length(nama_pelanggan),nama_pelanggan limit 1) as b;

##======menampilkan produk yang paling banyak terjual, berdasarkan kuantitas
SELECT mp.kode_produk, mp.nama_produk, SUM(tpd.qty) total_qty
FROM ms_produk mp
JOIN tr_penjualan_detail tpd
ON mp.kode_produk=tpd.kode_produk
GROUP BY mp.kode_produk, mp.nama_produk
HAVING total_qty=7;

##======pelanggan yang memiliki nilai belanja paling tinggi
SELECT mp.kode_pelanggan, mp.nama_pelanggan, 
	SUM(tpd.qty*tpd.harga_satuan) total_harga
FROM ms_pelanggan mp
JOIN tr_penjualan tp ON mp.kode_pelanggan=tp.kode_pelanggan
JOIN tr_penjualan_detail tpd ON tp.kode_transaksi=tpd.kode_transaksi
GROUP BY mp.kode_pelanggan, mp.nama_pelanggan
ORDER BY total_harga DESC
LIMIT 1;


##====pelanggan yang belum pernah belanja
SELECT mp.kode_pelanggan, mp.nama_pelanggan, mp.alamat
FROM ms_pelanggan mp
WHERE mp.kode_pelanggan NOT IN (SELECT kode_pelanggan FROM tr_penjualan);

##=====menampilkan transaksi-transaksi yang memiliki jumlah item produk lebih dari 1 jenis produk.
SELECT tpd.kode_transaksi, 
		mp.kode_pelanggan, mp.nama_pelanggan,
		tp.tanggal_transaksi,
		count(tpd.kode_produk) as jumlah_detail
FROM ms_pelanggan as mp
JOIN tr_penjualan as tp ON mp.kode_pelanggan=tp.kode_pelanggan
JOIN tr_penjualan_detail as tpd ON tp.kode_transaksi=tpd.kode_transaksi
GROUP BY 
tpd.kode_transaksi,
mp.kode_pelanggan, mp.nama_pelanggan,
tp.tanggal_transaksi
HAVING COUNT(tpd.kode_produk)>1;