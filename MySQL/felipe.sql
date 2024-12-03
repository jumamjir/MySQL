SET SQL_SAFE_UPDATES = 0;

UPDATE tabela_json
SET doc_json = JSON_SET(doc_json, '$.id', 2)
WHERE JSON_EXTRACT(doc_json, '$.id') = 500;

SET SQL_SAFE_UPDATES = 1; -- Reative o modo seguro depois

