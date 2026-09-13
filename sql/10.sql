-- 10. JOIN
-- 10.1. INNER JOIN -  пересечение двух множеств. Мы указываем условие связи, например, по FK, и получаем только те записи из обеих таблиц, которые отвечают этому требованию.
-- 10.2. FULL JOIN
-- FULL JOIN возвращает все записи из обеих таблиц. Если записи нет то в полях другой таблицы будет поставлено NULL. По сути, это операция объединения множеств.
-- 10.3. CROSS JOIN
-- Это декартово произведение двух таблиц (все ко всем)

-- 10.4. Задания
-- 10.4.1. Перепишите задание 8.3.2 через синтаксис JOIN.
-- 8.3.2 Организуйте эквисоединение, которое выводит цену и названия тех товаров, для которых цена за единицу (UnitPrice) в таблице Order Details меньше 20.
-- SELECT Products.ProductNamне, [Order Details].UnitPrice
-- FROM Products, [Order Details]
-- WHERE Products.ProductId = [Order Details].ProductID
-- AND [Order Details].UnitPrice < 20;
SELECT Products.ProductName, [Order Details].UnitPrice
FROM Products
JOIN [Order Details]
ON Products.ProductId = [Order Details].ProductID
WHERE [Order Details].UnitPrice < 20;

-- 10.4.2. Имеется запрос

-- SELECT Orders.Freight, Customers.CompanyName
-- FROM Orders INNER JOIN Customers
-- ON Orders.CustomerID = Customers.CustomerID
-- ORDER BY Freight;
-- Проверьте этот запрос с вариантом FULL JOIN -- за счёт чего выдача получилась объёмнее? Почему значения NULL встречаются в обоих полях набора?

SELECT Orders.Freight, Customers.CompanyName
FROM Orders FULL JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
ORDER BY Freight;

-- Запрос получился объемнее так как FULL JOIN возвращает все записи из обеих таблиц.
-- NULL появляется в поле той таблицы, для которой не нашлось соответствующей записи. 

-- 10.4.3. Подумайте, как с помощью предложения WHERE превратить запрос CROSS JOIN в INNER JOIN.
Нужно добавить условие по которому строки таблиц будут совпадать, например равенство ключевого поля одной таблицы и внешнего ключа другой таблицы
SELECT * 
FROM Table1 CROSS JOIN Table2
WHERE Table1.ID = Table2.Table1ID

-- 10.4.4. Перепишите данный запрос в INNER JOIN:

-- SELECT Products.ProductName, [Order Details].UnitPrice
-- FROM Products CROSS JOIN [Order Details]
-- WHERE Products.ProductID = [Order Details].ProductID


SELECT Products.ProductName, [Order Details].UnitPrice
FROM Products INNER JOIN [Order Details]
ON Products.ProductID = [Order Details].ProductID;

-- рефлексия (задание 10.4)
-- Узнал про соединения таблиц:
-- INNER JOIN выводит только совпадающие записи;
-- FULL JOIN - выводит все записи из обеих таблиц;
-- CROSS JOIN выводит все возможные сочетания строк.
-- NULL означает, что для записи одной таблицы 
-- не нашлось соответствующей записи в другой.