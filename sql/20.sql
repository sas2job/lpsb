-- 20. Заключительная практика: усложняем задание
-- Из вашей команды уволился архитектор, и пришедший на его место новый сотрудник энергично взялся за переделку и "оптимизацию" базы данных.

-- Вот что у него получилось:

-- База данных

-- Таблица Dwarves

-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | dwarf_id     | INT          | Уникальный идентификатор гнома            |
-- | name         | VARCHAR(100) | Имя гнома                                 |
-- | age          | INT          | Возраст гнома                             |
-- | profession   | VARCHAR(100) | Профессия гнома                           |
-- | squad_id     | INT          | Идентификатор отряда                      
--                                 (NULL, если не в отряде)                  |
-- Таблица Squads
-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | squad_id     | INT          | Уникальный идентификатор отряда           |
-- | name         | VARCHAR(100) | Название отряда                           |
-- | leader_id    | INT          | Идентификатор лидера отряда 
--                                 (ссылка на dwarf_id из таблицы Dwarves)   |

-- Таблица Tasks

-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | task_id      | INT          | Уникальный идентификатор задачи           |
-- | description  | TEXT         | Описание задачи                           |
-- | assigned_to  | INT          | Идентификатор гнома, ответственного за задачу 
--                                 (NULL, если не назначена)                 |
-- | status       | VARCHAR(50)  | Статус задачи                             
--                         (например, 'pending', 'in_progress', 'completed') |

-- Таблица Items

-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | item_id      | INT          | Уникальный идентификатор предмета         |
-- | name         | VARCHAR(100) | Название предмета                         |
-- | type         | VARCHAR(50)  | Тип предмета 
--                                 (например, 'weapon', 'armor', 'tool')     |
-- | owner_id     | INT          | Идентификатор гнома-владельца 
--                                 (ссылка на dwarf_id из таблицы Dwarves, 
--                                 или NULL если не присвоено)               |

-- Таблица Relationships


-- | Field        | Type         | Description                               |
-- |--------------|--------------|-------------------------------------------|
-- | dwarf_id     | INT          | Уникальный идентификатор гнома 
--                                 (ссылка на dwarf_id)                      |
-- | related_to   | INT          | Идентификатор другого гнома 
--                                 (ссылка на dwarf_id)                      |
-- | relationship | VARCHAR(50)  | Тип отношения 
--                                 (например, 'Друг', 'Супруг', 'Родитель')  |
-- Задания

-- 1. Найдите все отряды, у которых нет лидера.
SELECT name
FROM Squads
WHERE leader_id IS NULL;

-- 2. Получите список всех гномов старше 150 лет, 
-- у которых профессия "Warrior".
SELECT name
FROM Dwarves
WHERE age > 150
AND profession = 'Warrior';

-- 3. Найдите гномов, 
-- у которых есть хотя бы один предмет типа "weapon".
SELECT name
FROM Dwarves
WHERE dwarf_id IN (SELECT owner_id
                  FROM Items
                  WHERE type = 'weapon');

-- 4. Получите количество задач для каждого гнома, 
-- сгруппировав их по статусу.
SELECT Dwarves.name,
       Tasks.status,
       COUNT(*)
FROM Dwarves
JOIN Tasks ON Tasks.assigned_to = Dwarves.dwarf_id
GROUP BY Dwarves.dwarf_id, Dwarves.name, Tasks.status;       

-- 5. Найдите все задачи, 
-- которые были назначены гномам из отряда 
-- с именем "Guardians".
SELECT Tasks.description
FROM Tasks
JOIN Dwarves ON Tasks.assigned_to = Dwarves.dwarf_id
JOIN Squads ON Dwarves.squad_id = Squads.squad_id
WHERE Squads.name = 'Guardians';

-- 6. Выведите всех гномов и их ближайших 
-- родственников, указав тип родственных отношений.
SELECT Dwarves.name,
       Relatives.name,
       Relationships.relationship
FROM Dwarves
LEFT JOIN Relationships
ON Dwarves.dwarf_id = Relationships.dwarf_id
LEFT JOIN Dwarves AS Relatives
ON Relationships.related_to = Relatives.dwarf_id;

-- рефлексия (задание 20)
-- Повторил составление sql-запросов.