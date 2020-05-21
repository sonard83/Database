/*
Практическое задание по теме “Оптимизация запросов”
Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
logs
*/
USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
tablename VARCHAR(255),
identifier_id INT,
name VARCHAR(255),
created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=ARCHIVE
;
DELIMITER //
CREATE TRIGGER log_after_insert_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO logs (tablename, extenal_id, name) VALUES ('users', new.id, new.name);
END//

CREATE TRIGGER log_after_insert_catalogs  AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
  INSERT INTO logs (tablename, extenal_id, name) VALUES ('catalogs', new.id, new.name);
END//

CREATE TRIGGER log_after_insert_products  AFTER INSERT ON products 
FOR EACH ROW
BEGIN
  INSERT INTO logs (tablename, extenal_id, name) VALUES ('products ', new.id, new.name);
END//

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры')//

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12')//

INSERT INTO products
  (name, description, price, catalog_id)
VALUES ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1)//


select * from logs//

delete from users//
delete from logs//
delete from products//
delete from catalogs//
/*
(по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/
DELIMITER ;
DROP TABLE IF EXISTS tbl_users;
CREATE TABLE tbl_users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO tbl_users (name, birthday_at) VALUES
  ('Аркадий', '1992-11-06'),
  ('Светлана', '1981-12-22'),
  ('Николай', '1983-06-21'),
  ('Андрей', '1987-03-15'),
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');


INSERT INTO users (name, birthday_at)
SELECT 
tbl1.name, tbl1.birthday_at
FROM
tbl_users as tbl1,
tbl_users as tbl2,
tbl_users as tbl3,
tbl_users as tbl4,
tbl_users as tbl5,
tbl_users as tbl6;

SELECT COUNT(*) FROM users;