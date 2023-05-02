//test veritabanınızda employee isimli sütun bilgileri id(INTEGER), name VARCHAR(50), birthday DATE, email VARCHAR(100) olan bir tablo oluşturalım.
CREATE TABLE employee (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50),
  birthday DATE,
  email VARCHAR(100)
);

//Oluşturduğumuz employee tablosuna 'Mockaroo' servisini kullanarak 50 adet veri ekleyelim.
INSERT INTO employee (id, name, birthday, email)
SELECT * FROM (
  SELECT 
    (ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS id,
    CONCAT('Name', ROW_NUMBER() OVER (ORDER BY (SELECT NULL))) AS name,
    DATEADD(day, -1 * ABS(CHECKSUM(NEWID()) % 3650), GETDATE()) AS birthday,
    CONCAT('email', ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), '@example.com') AS email
  FROM sys.all_objects
) AS temp
WHERE id <= 50;

//Sütunların her birine göre diğer sütunları güncelleyecek 5 adet UPDATE işlemi yapalım.
-- ismi "Name1" olan kişinin ismini "John" olarak güncelleme
UPDATE employee SET name = 'John' WHERE name = 'Name1';

-- doğum tarihi 2000-01-01 olan kişinin e-posta adresini güncelleme
UPDATE employee SET email = 'newemail@example.com' WHERE birthday = '2000-01-01';

-- e-posta adresi "email3@example.com" olan kişinin doğum tarihini güncelleme
UPDATE employee SET birthday = '1995-05-12' WHERE email = 'email3@example.com';

-- id'si 25 olan kişinin ismini "Jessica" olarak, e-posta adresini "newemail2@example.com" olarak güncelleme
UPDATE employee SET name = 'Jessica', email = 'newemail2@example.com' WHERE id = 25;

-- doğum tarihi 1998-12-31 olan kişinin ismini "Adam" olarak, e-posta adresini "newemail3@example.com" olarak güncelleme
UPDATE employee SET name = 'Adam', email = 'newemail3@example.com' WHERE birthday = '1998-12-31';


//Sütunların her birine göre ilgili satırı silecek 5 adet DELETE işlemi yapalım.
-- ismi "Name2" olan kişinin satırını silme
DELETE FROM employee WHERE name = 'Name2';

-- e-posta adresi "email10@example.com" olan kişinin satırını silme
DELETE FROM employee


