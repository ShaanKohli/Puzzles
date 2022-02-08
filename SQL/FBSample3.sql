-- table: messenger_sends
-- date | ts | sender_id | receiver_id| message_id | has_reaction

-- how many unique conversation threads are there ?


-- we need unique pairings of sender and receiver_id, can achieve this using UNION ALL


SELECT
  *
FROM messenger_sends