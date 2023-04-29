--Количество исполнителей в каждом жанре.
SELECT name, COUNT(performer_id) FROM Genreperfomer gp
JOIN Genre g ON gp.genre_id = g.genre_id
GROUP BY g.name
ORDER BY COUNT(performer_id) DESC;

--Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(track_id) FROM Albums a
JOIN Track t ON a.album_id = t.album_id
WHERE EXTRACT(YEAR FROM year_of_release) BETWEEN 2019 AND 2020;

--Средняя продолжительность треков по каждому альбому
SELECT album_name, AVG(duration) FROM Albums a
JOIN Track t ON a.album_id = t.album_id
GROUP BY a.album_name
ORDER BY AVG(duration) DESC;

--Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT name 
FROM Performer p  
WHERE p.name NOT IN ( 
    SELECT p.name 
    FROM Performer p 
    JOIN performeralbums pa ON p.performer_id = pa.performer_id 
    JOIN Albums a ON a.album_id = pa.album_id 
    WHERE EXTRACT(YEAR FROM a.year_of_release)=2020); 

--Названия сборников, в которых присутствует конкретный исполнитель (Poll Makkartney).
SELECT collection_name FROM Сollection c
JOIN Collectiontrack ct ON c.collection_id = ct.collection_id
JOIN Track t ON ct.track_id = t.track_id
JOIN Albums a ON t.album_id = a.album_id  
JOIN Performeralbums pa ON a.album_id  = pa.album_id 
JOIN Performer p ON pa.performer_id = p.performer_id 
GROUP BY p.name, c.collection_id
HAVING p.name = 'Poll Makkartney';

--Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT album_name FROM Albums a
JOIN Performeralbums pa ON a.album_id  = pa.album_id 
JOIN Performer p ON pa.performer_id = p.performer_id 
JOIN Genreperfomer gp ON p.performer_id = gp.performer_id
JOIN Genre g ON gp.genre_id = g.genre_id
GROUP BY p.name, a.album_name
HAVING COUNT(g.genre_id)>1

--Наименования треков, которые не входят в сборники.
SELECT track_name FROM Track t
LEFT JOIN Collectiontrack ct ON t.track_id = ct.track_id 
WHERE ct.collection_id IS NULL

--Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT p.name FROM Performer p
JOIN Performeralbums pa ON p.performer_id = pa.performer_id
JOIN Albums a ON pa.album_id = a.album_id
LEFT JOIN Track t ON a.album_id = t.album_id
GROUP BY  p.name, t.duration
HAVING t.duration = (SELECT MIN(duration) FROM Track);

--Названия альбомов, содержащих наименьшее количество треков.
SELECT album_name, COUNT(track_id) FROM Albums a
JOIN Track t ON a.album_id = t.album_id 
GROUP BY a.album_name
HAVING COUNT(track_id) =  (SELECT MIN(e) FROM 
							(SELECT COUNT(track_id) AS e
							FROM Albums a
							JOIN Track t ON a.album_id = t.album_id 
							GROUP BY a.album_name) s);