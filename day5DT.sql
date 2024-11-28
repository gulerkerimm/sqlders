------------------Day 5 DT--------------------

--26-UPDATE tablo_adı SET sütunadı=yeni değer 
--WHERE koşul 
-- koşulu sağlayan kayıtlar güncellenir

------
--employees4 adli bir tablo olusturalim

CREATE TABLE employees4 (
id INT UNIQUE, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas INT, 
isyeri VARCHAR(20)
);

INSERT INTO employees4 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees4 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees4 VALUES(345678901, null, 'Ankara', 3000, 'Vakko');
INSERT INTO employees4 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees4 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees4 VALUES(678901234, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees4 VALUES(789012345, 'Fatma Yasa', null, 2500, 'Vakko');
INSERT INTO employees4 VALUES(890123456, null, 'Bursa', 2500, 'Vakko');
INSERT INTO employees4 VALUES(901234567, 'Ali Han', null, 2500, 'Vakko');

SELECT * FROM employees4;

/*Senaryo 1: employees4 adli bir tablo olusturunuz. id’si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyiniz.*/
/*Scenario 1: Create a table named employees4. update the workplace name of the employee whose id is 123456789 to ‘Trendyol'.*/

UPDATE employees4
SET isyeri = 'Trendyol'
WHERE id=123456789;

----
/*Senaryo 2: id’si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve sehrini 'Bursa' olarak güncelleyiniz.*/
/*Scenario 2: Update the name of the employee whose id is 567890123 as 'Veli Yıldırım' and the city as ‘Bursa'.*/

UPDATE employees4
SET isim = 'Veli Yildirim', sehir = 'Bursa'
WHERE id = 567890123;

SELECT * FROM employees4;

/*Senaryo 3: brands tablosundaki marka_id değeri 102’ye eşit veya büyük olanların marka_id’sini 2 ile çarparak değiştirin.*/
/*Scenario 3: change the marka_id of brands in the brands table with a marka_id greater than or equal to 102 by multiplying by 2.*/

SELECT * FROM brands

UPDATE brands
SET marka_id = marka_id * 2
WHERE marka_id >= 102;

/*Senaryo 4: brands tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.*/
/*Scenario 4: Update the calisan_sayisi values of all brands in the brands table by adding them with marka_id.*/

UPDATE brands
SET calisan_sayisi = marka_id + calisan_sayisi

/*Senaryo 5: employees4 tablosundan Ali Seker’in isyerini, 567890123 id’li çalışanın isyeri ismi ile güncelleyiniz.*/
/*Scenario 5: Update the workplace of Ali Seker from table employees4 with the workplace name of the employee with id 567890123.*/

SELECT * FROM employees4;

UPDATE employees4
SET isyeri = (SELECT isyeri FROM employees4 WHERE id = 567890123)
WHERE isim = 'Ali Seker';

/*Senaryo 6: employees4 tablosunda maasi 1500 olanların isyerini, markalar tablosunda marka_id=100 olan markanın ismi ile değiştiriniz.*/

/*Scenario 6: Replace the workplace of those with salary 1500 in the employees4 table with the name of the brand with marka_id=100 in the brands table.*/

UPDATE employees4
SET isyeri = (SELECT marka_isim FROM brands WHERE marka_id = 100)
WHERE maas = 1500;

--employees4 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
--Add ' Şubesi’ at the end of the city information of those whose workplace is 'Vakko' in the employees4 table.

--|| operatörü, SQL'de dizeleri birleştirmek (concatenate) için kullanılır. Java'daki + operatörü ile benzer işlevi görür.

UPDATE employees4
SET sehir = sehir || ' Subesi'
WHERE isyeri = 'Vakko';

SELECT * FROM employees4;

--alternatif, null'i algilamasi icin

UPDATE employees4
SET sehir = CONCAT(sehir, ' Subesi')
WHERE isyeri = 'Vakko'

--27-IS NULL condition 
 
--Ornek 1: employees4 tablosunda isim sütunu null olanları listeleyiniz.
--Example 1: List those whose name column is null in the employees4 table.

SELECT * FROM employees4
WHERE isim IS NULL

--Ornek 2: employees4 tablosunda isim sütunu null olmayanları listeleyiniz.
--Example 2: List those whose name column is not null in the employees4 table.

SELECT * FROM employees4
WHERE isim IS NOT NULL

--Ornek 3: employees4 tablosunda isim sütunu null olanların isim değerini 'isimsiz' olarak güncelleyiniz.
--Example 3: Update the name value of those whose name column is null in the employees4 table to ‘isimsiz'.

UPDATE employees4
SET isim = 'isimsiz'
WHERE isim IS NULL

-------------------
--28-ORDER BY: Kayıtları belirli bir field’e göre azalan/artan şekilde sıralamamızı sağlar.
--VARSAYILAN olarak ASC(natural-artan-doğal) olarak sıralar

/*ORDER BY komutu yalnızca SELECT sorgularıyla birlikte kullanılır çünkü amacı, bir sorgunun sonuç setini belirli kriterlere göre sıralamaktır.  INSERT, UPDATE ve DELETE komutlarıyla kullanılamaz. Bu komutlar, veritabanında veri eklemek, güncellemek veya silmek için kullanılır ve sonuç seti döndürmezler.*/

DROP TABLE person;

CREATE TABLE person
(
	ssn char(9),
	isim varchar(50),
	soyisim varchar(50),  
	adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 

SELECT * FROM person;

/*Senaryo 1: person tablosundaki tüm kayıtları adrese göre (artan sirada) sıralayarak listeleyiniz.*/
/*Scenario 1: List all records in the person table sorted by address (in ascending order).*/

SELECT *
FROM person
ORDER BY adres

SELECT *
FROM person
ORDER BY adres ASC --ASC natural siralama yapar (A_Z)

SELECT *
FROM person
ORDER BY adres, isim, soyisim;

/*Senaryo 2: person tablosundaki tüm kayıtları soyisime göre (azalan) sıralayarak listeleyiniz.*/
/*Scenario 2: List all records in the person table sorted by surname (descending).*/

SELECT *
FROM person
ORDER BY soyisim DESC

/*Senaryo 3: person tablosundaki tüm kayıtları isme göre azalan, soyisme göre artan sekilde sıralayarak listeleyiniz.*/
/*Scenario 3: List all records in the person table in descending order by first name and ascending order by surname.*/

SELECT *
FROM person
ORDER BY isim DESC, soyisim ASC

/*Senaryo 4: person tablosunda isim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.*/
/*Scenario 4: List the name and surname values in the person table, sorted by surname word lengths.*/

SELECT isim, soyisim
FROM person
ORDER BY LENGTH(soyisim)

SELECT isim, soyisim, LENGTH(soyisim) AS karakter_sayisi
FROM person
ORDER BY LENGTH(soyisim)

SELECT isim, soyisim, LENGTH(soyisim) AS karakter_sayisi
FROM person
ORDER BY karakter_sayisi --ORDER BY takma ismi tanir

/*Senaryo 5: person tablosunda, tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak, her bir isim ve soyisim değerinin toplam uzunluğuna göre sıralayınız.*/

/*Scenario 5: In the person table, call all first and last name values in the same column with a space between them and sort by the total length of each first and last name value.*/

SELECT CONCAT(isim,' ', soyisim) AS isim_soyisim
FROM person
ORDER BY LENGTH(isim) + LENGTH(soyisim);

SELECT CONCAT(isim,' ', soyisim) AS isim_soyisim,LENGTH(CONCAT(isim, soyisim)) karakter_sayisi
FROM person
ORDER BY LENGTH(CONCAT(isim, soyisim));

/*Senaryo 6: employees4 tablosunda maaşı ortalama maaştan yüksek olan çalışanların isim,şehir ve maaşlarını maaşa göre artan sekilde sıralayarak listeleyiniz.*/

/*Scenario 6: In table employees4, list the names, cities and salaries of employees whose salaries are higher than the average salary in ascending order by salary.*/

SELECT * FROM employees4;

SELECT AVG(maas) FROM employees4; --2666.6666666666666667

SELECT isim, sehir, maas
FROM employees4
WHERE maas > (SELECT AVG(maas) FROM employees4)
ORDER BY maas;

----------------------
--29-GROUP BY

CREATE TABLE greengrocer
(
	isim varchar(50),
	urun_adi varchar(50),
	urun_miktar int
);

INSERT INTO greengrocer VALUES( 'Ali', 'Elma', 5);
INSERT INTO greengrocer VALUES( 'Ayse', 'Armut', 3);
INSERT INTO greengrocer VALUES( 'Veli', 'Elma', 2);  
INSERT INTO greengrocer VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO greengrocer VALUES( 'Ali', 'Armut', 2);  
INSERT INTO greengrocer VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO greengrocer VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO greengrocer VALUES( 'Ali', 'Armut', 2);  
INSERT INTO greengrocer VALUES( 'Veli', 'Elma', 3);  
INSERT INTO greengrocer VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM greengrocer;

/*Senaryo 1: greengrocer tablosundaki tüm isimleri ve her bir isim için, toplam ürün miktarını görüntüleyiniz.*/
/*Scenario 1: Display all names in the greengrocer table and, for each name, the total quantity of products.*/

SELECT isim, SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim;

/*Senaryo 2: greengrocer tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
Toplam ürün miktarına göre azalan olarak sıralayınız.*/

/*Scenario 2: Display all names in the greengrocer table and the total product quantity for each name.
Sort in descending order by total product quantity.*/

SELECT isim, SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim
ORDER BY SUM(urun_miktar) DESC;

/*Senaryo 3: Her bir ismin aldığı, her bir ürünün toplam miktarını, isme göre sıralı görüntüleyiniz.*/
/*Scenario 3: Display the total amount of each product purchased by each name, ordered by name.*/

SELECT isim, urun_adi, SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim, urun_adi
ORDER BY isim

/*Senaryo 4: ürün adina göre, her bir ürünü alan toplam kişi sayısını gösteriniz.*/
/*Scenario 4: by product name, show the total number of people who bought each product.*/

SELECT urun_adi, COUNT(DISTINCT(isim)) kisi_sayisi
FROM greengrocer
GROUP BY urun_adi

/*Senaryo 5: Isme göre, alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz*/
/*Scenario 5: According to the name, find the total quantity of products received and the quantity of product types*/

SELECT isim, SUM(urun_miktar) toplam_kg, COUNT(DISTINCT urun_adi) cesit_sayisi
FROM greengrocer
GROUP BY isim

--ÖDEV: Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sirada sıralayınız.

--30-HAVING ifadesi
--where kayitlari filtreler, having ise sonuclari

--where kayitlari filtreler, having sonuclari filtreler
--group by olmadan having kullanilmasi anlamsiz.

CREATE TABLE personel  (
	id int,
	isim varchar(50),
	sehir varchar(50), 
	maas int,  
	sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(678901245, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel;

/*Senaryo 1: Her bir şirketin MIN maas bilgisini, bu bilgi eğer 4000 den fazla ise görüntüleyiniz.*/
/*Scenario 1: Display the MIN salary information for each company, if this information is more than 4000 */

SELECT sirket, MIN(maas) min_maas
FROM personel
GROUP BY sirket
HAVING MIN(maas) > 4000

/*Senaryo 2: Maaşı 4000 den fazla olan çalışanlarin sirketlerini bulduktan sonra, bu sinirin ustunde olan MIN maas bilgisini her sirket icin görüntüleyiniz.*/

/*Scenario 2: After finding the companies of employees with salaries over 4000, display the MIN salary information for each company above this limit.*/

SELECT sirket, MIN(maas) min_maas
FROM personel
WHERE maas > 4000
GROUP BY sirket

/*Senaryo 3: Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.*/
/*Scenario 3: If the total income received by each name is more than 10000 liras, write a query showing the name and total salary.*/

SELECT isim, SUM(maas) toplam_gelir
FROM personel
GROUP BY isim
HAVING SUM(maas) > 10000;

/*Senaryo 4: Eğer bir şehirde çalışan personel(id) sayısı 1’den çoksa, sehir 
ismini ve personel sayısını veren sorgu yazınız*/

/*Scenario 4: If the number of personnel(id) working in a city is more than 1, city 
Write a query that gives the name and number of personnel */

SELECT sehir, COUNT(id) kisi_sayisi
FROM personel
GROUP BY sehir
HAVING COUNT(id) > 1;

--ÖDEV: Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.

--31- UNION - UNION ALL ifadesi

CREATE TABLE developers(
	id SERIAL PRIMARY KEY,
	name varchar(50),
	email varchar(50) UNIQUE,
	salary real,
	prog_lang varchar(20),
	city varchar(50),
	age int	
);

INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Abdullah Berk','abdullah@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mehmet Cenk','mehmet@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayşenur Han ','aysenur@mail.com',5000,'Java','Izmir',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Han','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Muhammed Demir','muhammed@mail.com',6000,'Java','Izmir',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fevzi Kaya','fevzi@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Can','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Tansu Han','tansu@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Said Ran','said@mail.com',4500,'Html','Izmir',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Mustafa Pak','mustafa@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hakan Tek','hakan@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Deniz Çetin','deniz@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Betül Çetin','btl@mail.com',4000,'C#','Bursa',29);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ayse Gul','ayse@mail.com',4000,'C#','Ankara',29);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ali Seker','ali@mail.com',4000,'C#','Ankara',29);

CREATE TABLE contact_info(
	address_id int,
	street varchar(30),
	number int,	
	city varchar(30),
	FOREIGN KEY(address_id) REFERENCES developers(id)	
);

INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');

SELECT * FROM developers;
SELECT * FROM contact_info;
SELECT * FROM employees4; 

/*Senaryo 1: Ankara'da yaşayan developer ve İstanbul’da yaşayan çalışanların(employees4) isimlerini birlikte tekrarsız gösteren sorguyu yaziniz*/

/*Scenario 1: Write the query that shows the names of the developer living in Ankara and the employees (employees4) living in Istanbul together without duplicates*/

SELECT name FROM developers WHERE city = 'Ankara'
UNION
SELECT isim FROM employees4 WHERE sehir = 'Istanbul';

--developer ve çalışanların(employees4) isimlerini birlikte tekrarlı gösteren sorguyu yaziniz
--Write the query that shows the names of developer and employees(employees4) repeatedly together

SELECT name FROM developers WHERE city = 'Ankara'
UNION ALL
SELECT isim FROM employees4 WHERE sehir = 'Istanbul';

--union mantigi veri setlerini birlestirmedir, ancak veri type’lari ayni ya da uyumlu olmak zorundadir.

/*Senaryo 2: Yaşı 25’den büyük olan developer isimlerini ve yaşı 30'dan küçük developerların kullandığı prog. dillerini birlikte tekrarlı gösteren sorguyu yaziniz*/

/*Scenario 2: Write the query that shows the names of developers older than 25 and the prog. languages used by developers younger than 30 repeatedly together*/

SELECT name AS name_prog_lang FROM developers WHERE age>25
UNION ALL
SELECT prog_lang FROM developers WHERE age < 30;






