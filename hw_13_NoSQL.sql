/* В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
*/

SET ‘127.0.0.1’ 1 -- вносим в базу данные где IP-адресс это ключ, а value равно 1, это кол-во посещений с этого IP-адресса
GET ‘127.0.0.1’  -- проверяем результат
INCR ‘127.0.0.1’ -- увеличиваем value (кол-во посещений) на 1
GET ‘127.0.0.1’ -- проверяем результат
INCR ‘127.0.0.2’  -- добавляем новый ключ, увеличивая value с 0 до 1
GET ‘127.0.0.2’ -- результат =1
KEYS * -- проверяем коллекцию

/*
При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
поиск электронного адреса пользователя по его имени.
*/

HSET user_email Andrey andreyS@gmail.com -- добавляем в хеш имя пользователя(key) и его email (value)
HSET user_email Oleg Oleg1982@gmail.com
HSET user_email Dmitriy Dima999@gmail.com
HGETALL user_email -- проверяем 
HGET user_email Andrey -- ищим email (value) по имени (key) 

HSET user_search andreyS@gmail.com Andrey-- для поиска имени по email добавляем новый хеш, где email это key, а имя пользователя value
HSET user_search Oleg1982@gmail.com Oleg
HSET user_search  Dima999@gmail.com Dmitriy
HGETALL user_search -- проверяем 
HGET user_search andreyS@gmail.com  -- ищим имя(value) по  email(key) 


