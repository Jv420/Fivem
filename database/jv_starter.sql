-- Jv420 FiveM Starter Database
-- Importeer dit pas nadat QBCore/ox_inventory SQL ook is toegevoegd.

CREATE TABLE IF NOT EXISTS `jv_server_settings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `setting_key` VARCHAR(100) NOT NULL,
  `setting_value` TEXT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jv_server_settings` (`setting_key`, `setting_value`) VALUES
('server_name', 'Jv420 Roleplay'),
('locale', 'nl-NL'),
('economy_style', 'starter')
ON DUPLICATE KEY UPDATE `setting_value` = VALUES(`setting_value`);

CREATE TABLE IF NOT EXISTS `jv_donations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `player_identifier` VARCHAR(100) NOT NULL,
  `player_name` VARCHAR(100) NOT NULL,
  `package_name` VARCHAR(100) NOT NULL,
  `status` VARCHAR(30) NOT NULL DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
