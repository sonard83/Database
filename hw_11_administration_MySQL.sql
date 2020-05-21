/*
1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только 
запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.
*/
use shop;
CREATE USER shop_read;
CREATE USER shop_full_access;

GRANT SELECT ON shop.* TO shop_read;
GRANT ALL ON shop.* TO shop_full_access;


select * from catalogs;
INSERT INTO catalogs VALUES (NULL, 'мониторы');

/*
2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и 
его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте пользователя user_read, 
который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.
*/

-- создаём таблицу и её заполняем -----------------
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255), 
  password BIGINT
);

INSERT INTO accounts (name, password) VALUES
  ('Геннадий', '19901005'),
  ('Наталья', '19841112'),
  ('Александр', '19850520'),
  ('Сергей', '19880214');


select * from accounts;
-- создаём представление -----------------

CREATE OR REPLACE VIEW username AS
SELECT id, name
FROM accounts
;

select * from username;
-- создаём пользователя  и даём ему права на просмотр -----------------
CREATE USER user_read;
GRANT SELECT ON shop.username TO user_read;

SELECT Host, User FROM mysql.user;
DROP USER user_read;
DROP USER shop_read;
DROP USER shop_full_access;
