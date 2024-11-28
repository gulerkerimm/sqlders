------------------ DAY 8 DT ------------------

--41- ALTER TABLE ifadesi-DDL

/*Senaryo 3: orders tablosunda sirket_id sütununa FOREIGN KEY constraint’i ekleyiniz.*/
/*Scenario 3: Add FOREIGN KEY constraint to the company_id column in the orders table.*/

ALTER TABLE orders
ADD FOREIGN KEY(sirket_id) REFERENCES companies2(sirket_id);

DELETE FROM orders WHERE sirket_id IN(104, 105);

SELECT * FROM orders;

SELECT conname, contype
FROM pg_constraint
WHERE conrelid = 
(SELECT oid FROM pg_class WHERE relname = 'orders'); 

/*Senaryo 4: orders tablosundaki FK constraintini kaldırınız.*/
/*Scenario 4: Remove the FK constraint in the orders table.*/

ALTER TABLE orders
DROP CONSTRAINT orders_sirket_id_fkey;

/*Senaryo 5: employees5 tablosunda isim sütununda 
NOT NULL constraintini kaldırınız.*/

/*Scenario 5: Name column in employees5 table
Remove the NOT NULL constraint.*/

--isnullabla null kontrolu yapar
--NO notnull kisitlamasi var anlamina gelir

SELECT * FROM employees5;

SELECT column_name, is_nullable
FROM information_schema.columns
WHERE table_name = 'employees5' AND column_name = 'isim';

ALTER TABLE employees5
ALTER COLUMN isim DROP NOT NULL;

INSERT INTO employees5(isim) VALUES('');
INSERT INTO employees5(id) VALUES(123321);

--42- Transaction

/*Senaryo:
1- accounts adında bir tablo oluşturulacak.
2- Tabloya iki kayıt eklenecek.
3- Hesaplar arasında 1000 TL para transferi yapılacaktır.
4- Para transferi sırasında bir hata oluşacaktır.
5- Hata oluştuğunda, ROLLBACK komutu ile transaction iptal edilecek
   ve 1. hesaptan çekilen 1000 TL iade edilecektir.*/

/*Scenario:
1- A table named accounts will be created.
2- Two records will be added to the table.
3- 1000 TL money transfer will be made between accounts.
4- An error will occur during money transfer.
5- When an error occurs, the transaction will be cancelled with the ROLLBACK command
   and the 1000 TL withdrawn from the 1st account will be refunded.*/

--------------------------------------Hata senaryosu
-- Tablo Oluşturma

CREATE TABLE accounts
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real
);

--Veri Ekleme

INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3);
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;

--Para transferi

UPDATE accounts SET bakiye = bakiye - 1000 WHERE hesap_no = 1234;

SELECT * FROM accounts;

--Sistemsel hata oluştu. Jack bu 1000 tl’yi alamadi

--UPDATE accounts SET bakiye = bakiye + 1000 WHERE hesap_no = 5678; --HATA, calismadi

--------------------------------------
--Basarisiz transaction senaryosu

--BEGIN: Transaction başlatmak için kullanılır.

BEGIN;
CREATE TABLE accounts
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);

--COMMIT: Transaction'ı onaylamak ve değişiklikleri kalıcı hale getirmek için kullanılır.
COMMIT;
------------------
BEGIN;

INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3); 
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;

--SAVEPOINT <savepoint_name>: Transaction içinde belirli bir noktada kayıt oluşturmak için kullanılır. Bu, hata durumunda tüm transaction'ı geri almak yerine belirli bir noktaya dönüş yapmayı sağlar.

SAVEPOINT x; --x variable'dir

--try{

	UPDATE accounts SET bakiye = bakiye - 1000 WHERE hesap_no = 1234;
	--UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678; HATA, exception
	--COMMIT; CALISMAZ
	
--}catch() {

	ROLLBACK TO x; --ROLLBACK; begin'e goturur
	COMMIT;
--}

	SELECT * FROm accounts;

--------------------------------------
--BASARILI SENARYOSU.

BEGIN;
CREATE TABLE accounts
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;


BEGIN;
INSERT INTO accounts VALUES(1234,'Harry Potter',10000.3);
INSERT INTO accounts VALUES(5678,'Jack Sparrow',5000.5);

SELECT * FROM accounts;

SAVEPOINT x;

--try{

UPDATE accounts SET bakiye=bakiye-1000 WHERE hesap_no=1234;--başarılı
UPDATE accounts SET bakiye=bakiye+1000 WHERE hesap_no=5678;--başarılı
COMMIT;

--}catch(){

--ROLLBACK to x; CALISMAZ cunku try'da hata yok

--}

SELECT * FROM accounts;






