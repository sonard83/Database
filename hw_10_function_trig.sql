/*
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна 
 возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
 */
 USE math;
 DELIMITER //
DROP FUNCTION IF EXISTS hello//

CREATE FUNCTION hello()
RETURNS TEXT  DETERMINISTIC
BEGIN
   IF (CURTIME()> '06:00:00' AND CURTIME()<= '12:00:00') 
      THEN RETURN 'Доброе утро';
   ELSEIF (CURTIME()> '12:00:00' AND CURTIME()<= '18:00:00') 
      THEN RETURN 'Добрый день';
   ELSE
      RETURN 'Доброй ночи';
   END IF;  
END//


select hello()//


/*
В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное 
значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/
use shop//

drop TRIGGER TRG_RESTRICT_UPDATE//
CREATE TRIGGER TRG_RESTRICT_UPDATE
BEFORE insert ON products
FOR EACH ROW  
BEGIN



IF (new.description is null AND new.name is null) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'This operation is not allowed.';
END IF;

END //

INSERT INTO products
  (price, catalog_id)
VALUES
  (7891.00, 2);


/*
Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность 
в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.
*/

DROP FUNCTION IF EXISTS FIBONACCI//
CREATE FUNCTION FIBONACCI(x bigint)
RETURNS bigint  DETERMINISTIC
BEGIN
set @y=0;
set @z=1;
set @t=0;
cycle: LOOP

set @y=@y+@z;
set @z=@y-@z;
set @t=@t+1;

IF @t = x THEN LEAVE cycle;
	END IF;

END LOOP cycle;
return @y;
end//



select FIBONACCI(9)//