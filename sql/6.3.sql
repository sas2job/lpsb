-- 6.3. Задания
-- 6.3.1. Выполните агрегацию таблицы Contacts по полю ContactType.
SELECT ContactType, COUNT(*)
FROM Contacts
GROUP BY ContactType;

-- 6.3.2. Выведите средние цены товаров (UnitPrice) в каждой из категорий (CategoryId) таблицы Products, отсортированные по возрастанию.
SELECT CategoryID, AVG(UnitPrice)
FROM Products
GROUP BY CategoryID
ORDER BY AVG(UnitPrice) ASC;

-- рефлексия (задание 6.3)
-- Узнал про группировку данных через GROUP BY и ORDER BY. 