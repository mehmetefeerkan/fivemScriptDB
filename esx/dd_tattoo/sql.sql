CREATE TABLE `users_shops` (
  `shopname` varchar(50) NOT NULL,
  `is_occupied` varchar(15) DEFAULT NULL,
  `owner` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `users_shops` (`shopname`, `is_occupied`, `owner`) VALUES
('tatshop1', NULL, NULL),
('tatshop2', NULL, NULL),
('tatshop3', NULL, NULL),
('tatshop4', NULL, NULL),
('tatshop5', NULL, NULL),
('tatshop6', NULL, NULL),
('tatshop7', NULL, NULL),
('tatshop8', NULL, NULL),
('tatshop9', NULL, NULL),
('tatshop10', NULL, NULL);



CREATE TABLE `users_shop` (
  `owner` varchar(50) NOT NULL,
  `shop` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `users_shops`
  ADD PRIMARY KEY (`shopname`);

ALTER TABLE `users_shop`
  ADD PRIMARY KEY (`owner`);
