-- 9. SQL -- дополнительные возможности
-- 9.4. Задания

-- 9.4.1. Найдите все пары из разных (уникальных) заказчиков (Customers), для которых не задан регион (поле Region).
SELECT
t1.CustomerID,
t1.ContactName,
t2.CustomerID,
t2.ContactName
FROM Customers t1, Customers t2
WHERE t1.Region IS NULL
AND t2.Region IS NULL 
AND t1.CustomerID < t2.CustomerID; 

-- 9.4.2. Найдите вложенным запросом список заказов (Orders), 
-- в котором у заказчиков (Customers) регион не пуст (поле Region).

SELECT *
FROM Orders t1
WHERE EXISTS  
(
SELECT *
FROM Customers t2
WHERE t1.CustomerID  = t2.CustomerID 
AND t2.Region IS NOT NULL
);

-- 9.4.3. Немного условный, но показательный пример. 
-- Найдите все заказы (таблица Orders), 
-- цена за доставку товара которых (Freight) превышает цену любого товара 
-- (поле UnitPrice, таблица Products).

SELECT *
FROM Orders t1
WHERE t1.Freight > ANY
(SELECT t2.UnitPrice
FROM Products t2);

-- рефлексия (задание 9.4)
-- Научился работать с копиями таблицы.
-- Для проверки записей использовал EXISTS.
-- Для сравнения использовал ANY.