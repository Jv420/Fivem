-- Delfzijl RP starter SQL additions

INSERT IGNORE INTO jobs (name, label) VALUES
('police', 'Politie'),
('ambulance', 'Ambulance'),
('mechanic', 'ANWB'),
('taxi', 'Taxi'),
('gemeente', 'Gemeente Delfzijl'),
('realestateagent', 'Makelaar'),
('cardealer', 'Autodealer'),
('unemployed', 'Werkloos');

INSERT IGNORE INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
('gemeente', 0, 'medewerker', 'Medewerker', 250, '{}', '{}'),
('gemeente', 1, 'manager', 'Manager', 400, '{}', '{}'),
('gemeente', 2, 'boss', 'Burgemeester', 650, '{}', '{}'),
('mechanic', 0, 'recruit', 'Stagiair', 250, '{}', '{}'),
('mechanic', 1, 'employee', 'Monteur', 400, '{}', '{}'),
('mechanic', 2, 'boss', 'ANWB Baas', 650, '{}', '{}');

INSERT IGNORE INTO licenses (type, label) VALUES
('id_card', 'Identiteitskaart'),
('drive', 'Rijbewijs B'),
('drive_truck', 'Vrachtwagenrijbewijs'),
('drive_bike', 'Motorrijbewijs'),
('weapon', 'Wapenvergunning');

CREATE TABLE IF NOT EXISTS delfzijl_illegal_cooldowns (
  identifier varchar(64) NOT NULL,
  action varchar(64) NOT NULL,
  last_time int(11) DEFAULT 0,
  PRIMARY KEY(identifier, action)
);
