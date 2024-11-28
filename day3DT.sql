------------------Day 3 DT--------------------

/*Senaryo: “worker” ve “address” adlarinda iki tablo oluşturun.

worker tablosu sütunları: 
id CHAR(5), isim VARCHAR(50), maas INT, ise_baslama DATE

address tablosu sütunları:
adres_id CHAR(5), sokak VARCHAR(30), cadde VARCHAR(30), sehir VARCHAR(30)

Tablolari birbirine baglayarak, UNIQUE, NOT NULL uygulamasi yapiniz*/

/*Scenario: Create two tables named "worker" and "address".

worker table columns: 
id CHAR(5), name VARCHAR(50), salary INT, job_start DATE

address table columns:
address_id CHAR(5), street VARCHAR(30), street VARCHAR(30), city VARCHAR(30)

Apply UNIQUE, NOT NULL by linking tables together*/

--NOT: UNIQUE null kabul eder. Birden fazla da kabul eder cunku null bir deger degildir. Karsilastirma yapmaz

CREATE TABLE worker(
	id char(5) PRIMARY KEY, 
	isim varchar(50) UNIQUE,
	maas int NOT NULL,
	ise_baslama date
);

CREATE TABLE address(
	adres_id char(5),
	sokak varchar(30),
	cadde varchar(30),
	sehir varchar(30),
	FOREIGN KEY(adres_id) REFERENCES worker(id) 
);

SELECT * FROM worker;
SELECT * FROM address;

INSERT INTO worker VALUES('10002', 'Donatello' ,12000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10003', null, 5000, '2018-04-14'); --basarili --unique:NULL kabul eder
INSERT INTO worker VALUES('10004', 'Donatello', 5000, '2018-04-14'); --HATA name unique olmali
INSERT INTO worker VALUES('10005', 'Michelangelo', 5000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10006', 'Leonardo', null, '2019-04-12'); --HATA, maas not null cunku
INSERT INTO worker VALUES('10007', 'Raphael', '', '2018-04-14'); --HATA, maas int bekliyor biz bos String gonderdik
INSERT INTO worker VALUES('', 'April', 2000, '2018-04-14'); --Basarili, PK hiclik kabul eder ama kullanimi onerilmez
INSERT INTO worker VALUES('', 'Ms.April', 2000, '2018-04-14'); --HATA, PK 2 tane hiclik kabul etmez cunku unique'dir
INSERT INTO worker VALUES('10002', 'Splinter', 12000, '2018-04-14'); --HATA, 10002 daha once kullanildi
INSERT INTO worker VALUES(null, 'Fred', 12000, '2018-04-14'); --HATA, PK null kabul etmez
INSERT INTO worker VALUES('10008', 'Barnie', 10000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10009', 'Wilma', 11000, '2018-04-14'); --basarili
INSERT INTO worker VALUES('10010', 'Betty' ,12000, '2018-04-14'); --basarili

INSERT INTO address VALUES('10003','Ninja Sok', '40.Cad.', 'IST'); --basarili
INSERT INTO address VALUES('10003','Kaya Sok', '50.Cad.', 'Ankara'); --basarili, FK dublicate olur
INSERT INTO address VALUES('10002','Taş Sok', '30.Cad.', 'Konya'); --basarili
INSERT INTO address VALUES('10012','Taş Sok', '30.Cad.', 'Konya'); --Hata, 10012 PK'de yok
INSERT INTO address VALUES(NULL,'Taş Sok', '23.Cad.', 'Konya'); --basarili
INSERT INTO address VALUES(NULL,'Taş Sok', '23.Cad.', 'Konya');

SELECT * FROM worker;
SELECT * FROM address;

-------------------------------------

/*14- WHERE ifadesi, belirli koşulları karşılayan kayıtları seçmek için kullanılır. Bir SELECT, UPDATE ya da DELETE sorgusunda, hangi satırların işleme dahil edileceğini belirtmek için WHERE koşulu eklenir.*/

---------------------------
--worker tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose name is 'Donatello' from the worker table

SELECT * FROM worker WHERE isim = 'Donatello';

---------------------------
--worker tablosundan maaşı 5000’den fazla olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose salary is more than 5000 from the worker table

SELECT * FROM worker WHERE maas>5000;

---------------------------
--worker tablosundan maaşı 5000’den fazla olanların isim ve maaşlarını listeleyelim
--Let's list the names and salaries of those whose salary is more than 5000 from the worker table

SELECT isim, maas FROM worker WHERE maas > 5000

---------------------------
--address tablosundan sehri 'Konya' ve 
--adres_id'si 10002 olan kaydın tüm verilerini getirelim
--select the city 'Konya' from the address table and 
--Let's get all the data of the record with address_id 10002

SELECT * FROM address WHERE sehir='Konya' AND adres_id='10002';

---------------------------
--sehri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.
--Let's get the street and city information for addresses whose city is 'Konya' or ‘Bursa'.

SELECT cadde, sehir FROM address WHERE sehir='Konya' OR sehir='Bursa';

--------------------------
--15-Tablodan kayıt silme-DELETE FROM ... komutu:DML

/*
DELETE FROM
DML (Data Manipulation Language) Komutu: DELETE FROM bir DML komutudur. DML komutları, veritabanındaki verileri yönetir ve değiştirir.

Rollback İle Geri Alınabilir: DELETE işlemi, bir işlem (transaction) içinde yapıldığında ve işlem henüz COMMIT edilmeden ROLLBACK komutu ile geri alınabilir. COMMIT edilmişse, bu işlem kalıcı hale gelir ve veritabanında yapılan değişiklikler geri alınamaz. Ayrica, transaction kullanılmadan yapılan DELETE işlemi kalıcıdır.

Performans: Büyük tablolarda DELETE komutu yavaş çalışabilir, çünkü her bir satırı tek tek siler ve işlem sırasında log kayıtları tutar. Bu nedenle, büyük miktarlarda veriyi silmek için farklı stratejiler veya komutlar kullanmak performansı iyileştirebilir (örneğin, TRUNCATE komutu veya verileri daha küçük parçalara bölerek silmek(LIMIT ile)).*/

---------
/*Senaryo: “students1” adinda bir tablo oluşturun.

students1 tablosu sütunları: 
id INTEGER, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu INTEGER

Tablo uzerinde cesitli silme islemleri yapiniz*/

/*Scenario: Create a table named "students1".

students1 table columns: 
id INTEGER, name VARCHAR(50), parent_name VARCHAR(50), written_note INTEGER

Perform various deletion operations on the table*/

CREATE TABLE students1
(
	id int,
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int       
);

INSERT INTO students1 VALUES(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM students1;

----------
--id=123 olan kaydı silelim.
-- Let's delete the record with id=123.

DELETE FROM students1 WHERE id = 123;

----------
--ismi Kemal Tan olan kaydı silelim.
-- delete the entry with the name Kemal Tan.

DELETE FROM students1 WHERE isim = 'Kemal Tan';

----------
--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
-- delete records with the name Ahmet Ran or Veli Han

DELETE FROM students1 WHERE isim = 'Ahmet Ran' OR isim = 'Veli Han';

------------------
--15-a-tablodaki tüm kayıtları silme:DELETE FROM: DML,rollback ile geri alınabilir

SELECT * FROM students;

--students tablosundan tüm kayıtları silelim.
-- delete all records from the students table.

--NOT: DELETE FROM komutu koşulsuz kullanıldığında
--tüm satırları siler ancak tablo kalır.

--satirlari tek tek sildigi icin yavastir. Daha hizlisi var. (TRUNCATE)

DELETE FROM students;

------------------
--16-Tablodaki tüm kayıtları silme:TRUNCATE TABLE:DDL

/*
TRUNCATE TABLE komutunun bazı önemli özellikleri:

Hızlı Temizlik: TRUNCATE TABLE, tablodaki tüm verileri hızla silmek için kullanılır. Bu, özellikle büyük tablolar için DELETE komutundan daha verimlidir çünkü TRUNCATE log kayıtlarını daha az tutar ve tüm satırları tek seferde siler.

Koşulsuz: TRUNCATE TABLE, DELETE komutunun aksine, WHERE koşulu kullanmaz ve tablodaki tüm satırları siler.

İşlem Logları: TRUNCATE TABLE, DELETE komutuna kıyasla daha az işlem logu tutar, bu da veritabanı kaynaklarını daha az tüketmesini sağlar.

Yapıyı Korur: TRUNCATE TABLE tablonun yapısını korur, yani sütunlar ve kısıtlamalar (constraints) silinmez, sadece içerik temizlenir. (Delete’te korur)

İşlem Geri Alınamaz: Çoğu veritabanı sistemlerinde TRUNCATE TABLE komutu işlem bloğu içinde kullanılmadığı sürece geri alınamaz. Ancak, bazı sistemlerde (örneğin, PostgreSQL) TRUNCATE TABLE komutu bir işlem bloğu içinde kullanıldığında ve işlem tamamlanmadan önce ROLLBACK komutu verildiğinde geri alınabilir.*/


CREATE TABLE doctors(
	id serial,
	name varchar(30) not null,
	salary real,
	email varchar(50) unique
);

INSERT INTO doctors(name,salary,email) VALUES('Dr. Gregory House',6000,'dr@mail.com'); --basarili
--INSERT INTO doctors(salary,email) VALUES(6000,'doctor@mail.com'); --HATA, not-null constraint
INSERT INTO doctors(name,salary,email) VALUES('',6000,'doc@mail.com'); --basarili

SELECT * FROM doctors;

--doctors tablosundan tüm kayıtları silelim.
--Delete all records from the doctors table.

TRUNCATE TABLE doctors; --where ile kullanilmaz

------------------
--17-parent-child ilişkisi olan tablolardan kayıt silme
--Delete records from tables with parent-child relationship

SELECT * FROM worker;
SELECT * FROM address;

--worker tablosundan tüm kayıtları silelim.
-- delete all records from the worker table.

DELETE FROM worker; --HATA cunku child'i var.

--worker tablosunda address tarafından referans alınan kayıtlar olduğu 
--için silmeye izin yok

DELETE FROM worker WHERE id='10002'; --HATA

--id=10002 olan kayıt adresler tarafından referans alındığı 
--için silmeye izin yok.Once child’dan iliskiyi koparalim

DELETE FROM address WHERE adres_id = '10002';
--referans alınan kayıt silindi,ilişki koparıldı

DELETE FROM worker WHERE id='10002'; --Simdi basarili

DELETE FROM address; --tum iliski koparildi
DELETE FROM worker; --artık hiçbir kayıt ref alınmadığı için başarılı.

-----------------------
--18-ON DELETE CASCADE

/*Senaryo: “students2” ve “grades2” adlarinda iki tablo oluşturun.

students2 tablosu sütunları: 
id int, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu int

grades2 tablosu sütunları:
talebe_id int, ders_adi varchar(30), yazili_notu int

Tablolari birbirine baglayarak, ON DELETE CASCADE uygulamasi yapiniz*/

/*Scenario: Create two tables named "students2" and "grades2".

students2 table columns: 
id int, name VARCHAR(50), parent_name VARCHAR(50), written_note int

grades2 table columns:
student_id int, course_name varchar(30), written_note int

Apply ON DELETE CASCADE by linking the tables together*/

CREATE TABLE students2
(
	id int primary key,  
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int
);

CREATE TABLE grades2( 
	talebe_id int,
	ders_adi varchar(30),
	yazili_notu int,
	CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES students2(id) ON DELETE CASCADE 	
);

INSERT INTO students2 VALUES
(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);


INSERT INTO grades2 VALUES 
 ('123','kimya',75),
 ('124', 'fizik',65),
 ('125', 'tarih',90),
 ('126', 'Matematik',90),
 ('127', 'Matematik',90),
 (null, 'tarih',90);

SELECT * FROM students2; --parent, referans veren
SELECT * FROM grades2; --child, referans alan

---
DELETE FROM grades2 WHERE talebe_id = 123; --basarili, child'dan bir kaydi dogrudan silebiliriz

DELETE FROM students2 WHERE id =126; --basarili

DELETE FROM students2; --child'da null kaydi kaldi
DELETE FROM grades2; --ile null'da silinir

------------------
--19-tabloyu silme

DROP TABLE students2; --HATA, tabloyu silemzsiniz cunku child'i var 
DROP TABLE students2 CASCADE; --child'daki FK kopar, child tablo silinmez

DROP TABLE IF EXISTS students18; --varsa bu tabloyu sil, yoksa hata verme
--boyle bir tablo yoksa uygulama durmasin varsa silsin demektir(IF EXISTS)

--------------------
--20-IN Condition
--IN: Bir değerin belirli bir değerler listesi içinde olup olmadığını kontrol eder.

/*Senaryo: “customers” adinda bir tablo oluşturun.

customers tablosu sütunları: 
urun_id INTEGER, musteri_isim VARCHAR(50), urun_isim VARCHAR(50)

Tablo uzerinde IN kullanimi yapiniz*/

/*Scenario: Create a table named "customers".

customers table columns: 
product_id INTEGER, customer_name VARCHAR(50), product_name VARCHAR(50)

Use IN on the table */

CREATE TABLE customers  (
	urun_id int,  
	musteri_isim varchar(50),
	urun_isim varchar(50)
);

INSERT INTO customers VALUES (10, 'Mark', 'Orange');
INSERT INTO customers VALUES (10, 'Mark', 'Orange');
INSERT INTO customers VALUES (20, 'John', 'Apple');
INSERT INTO customers VALUES (30, 'Amy', 'Palm');
INSERT INTO customers VALUES (20, 'Mark', 'Apple');
INSERT INTO customers VALUES (10, 'Adem', 'Orange');
INSERT INTO customers VALUES (40, 'John', 'Apricot');
INSERT INTO customers VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers;

--customers tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
-- List the data from the customers table with product name 'Orange', 'Apple' or 'Apricot'.

--1.yol:
SELECT * FROM customers WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--2.yol:
SELECT * FROM customers WHERE urun_isim IN('Orange','Apple','Apricot');

--customers tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.
--List the data from the customers table that do not have the product names 'Orange', 'Apple' and ‘Apricot’.

SELECT * FROM customers WHERE urun_isim NOT IN('Orange','Apple','Apricot');

------------------
--21-BETWEEN .. AND …

--BETWEEN operatörü, belirtilen iki değer arasında kalan değerleri seçmek için kullanılır ve her zaman AND ile birlikte kullanılır.

--customers tablosunda urun_id 20(dahil) ile 30(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
--List all the information of the products with product_id between 20(inclusive) and 30(inclusive) in the customers table

----20++++++++30-----

--1.yol:
SELECT *
FROM customers
WHERE urun_id >= 20 AND urun_id <=30;

--2.yol:
SELECT *
FROM customers
WHERE urun_id BETWEEN 20 AND 30;

-----
--customers tablosunda urun_id degeri 20’den küçük veya 30’dan büyük olan urunlerin tum bilgilerini listeleyiniz.(yani 20 ve 30 dahil değil)
--List all the information of the products whose product_id value is less than 20 or greater than 30 in the customers table (ie 20 and 30 are not included).

+++++20————30++++++++

SELECT *
FROM customers
WHERE urun_id NOT BETWEEN 20 AND 30;

--ODEV: Eğer kullanıcı yanlışlıkla değerleri ters girerse, bunu kontrol edip düzeltebilirsiniz. Nasil?

---------------
--22-AGGREGATE Fonk.

/*Senaryo: “brands” ve “employees3” adinda iki tablo oluşturun.*/
/*Scenario: Create two tables named "brands" and "employees3".*/

CREATE TABLE brands
(
	marka_id int, 
	marka_isim VARCHAR(20), 
	calisan_sayisi int
);

INSERT INTO brands VALUES(100, 'Vakko', 12000);
INSERT INTO brands VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO brands VALUES(102, 'Adidas', 10000);
INSERT INTO brands VALUES(103, 'LCWaikiki', 21000);

CREATE TABLE employees3 (
	id int, 
	isim VARCHAR(50), 
	sehir VARCHAR(50), 
	maas int, 
	isyeri VARCHAR(20)
);

INSERT INTO employees3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO employees3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

SELECT * FROM brands;
SELECT * FROM employees3;








