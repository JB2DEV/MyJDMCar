-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 19-05-2021 a las 17:37:42
-- Versión del servidor: 8.0.24
-- Versión de PHP: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `my_jdm_car`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coche`
--

CREATE TABLE `coche` (
  `id` int NOT NULL,
  `marca_coche` int NOT NULL,
  `modelo_coche` int NOT NULL,
  `usuario` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `coche`
--

INSERT INTO `coche` (`id`, `marca_coche`, `modelo_coche`, `usuario`) VALUES
(1, 5, 1, 1),
(2, 5, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca_coche`
--

CREATE TABLE `marca_coche` (
  `id` int NOT NULL,
  `nombre` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagen` text COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `marca_coche`
--

INSERT INTO `marca_coche` (`id`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'Honda', '', 'honda.png'),
(2, 'Lexus', '', 'lexus.png'),
(3, 'Mazda', '', 'mazda.png'),
(4, 'Mitsubishi', '', 'mitsubishi.png'),
(5, 'Nissan', '', 'nissan.png'),
(6, 'Subaru', '', 'subaru.png'),
(7, 'Toyota', '', 'toyota.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca_pieza`
--

CREATE TABLE `marca_pieza` (
  `id` int NOT NULL,
  `nombre` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagen` text COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `marca_pieza`
--

INSERT INTO `marca_pieza` (`id`, `nombre`, `descripcion`, `imagen`) VALUES
(1, 'ACL', '', 'acl.png'),
(2, 'ACT', '', 'act.png'),
(3, 'Apexi', '', 'apexi.png'),
(4, 'Aragosta', '', 'aragosta.png'),
(5, 'Arc', '', 'arc.png'),
(6, 'ARP', '', 'arp.png'),
(7, 'BBS', '', 'bbs.png'),
(8, 'BC Racing', '', 'bcracing.png'),
(9, 'Bilstein', '', 'bilstein.png'),
(10, 'Blitz', '', 'blitz.png'),
(11, 'Bride', '', 'bride.png'),
(12, 'Bridgestone', '', 'bridgestone.png'),
(13, 'Cometic', '', 'cometic.png'),
(14, 'Cosmis', '', 'cosmis.png'),
(15, 'CP Carrillo', '', 'cp_carrillo'),
(16, 'Cusco', '', 'cusco.png'),
(17, 'D2 Racing', '', 'd2_racing.png'),
(18, 'DBA', '', 'dba.png'),
(19, 'Denso', '', 'denso.png'),
(20, 'Driftworks', '', 'driftworks.png'),
(21, 'Dunlop', '', 'dunlop.png'),
(22, 'Eagle', '', 'eagle.png'),
(23, 'EBC Brakes', '', 'ebc_brakes.png'),
(24, 'Eibach', '', 'eibach.png'),
(25, 'Endless', '', 'endless.png'),
(26, 'Enkei', '', 'enkei.png'),
(27, 'Exedy', '', 'exedy.png'),
(28, 'Federal', '', 'federal.png'),
(29, 'Ferodo', '', 'ferodo.png'),
(30, 'Garrett', '', 'garret.png'),
(31, 'GReddy', '', 'greddy.png'),
(32, 'Hawk Performance', '', 'hawk_performance.png'),
(33, 'HEL Performance', '', 'hel_performance.png'),
(34, 'HKS', '', 'hks.png'),
(35, 'Honda', '', 'honda.png'),
(36, 'HSD', '', 'hsd.png'),
(37, 'Invidia', '', 'invidia.png'),
(38, 'Japan Racing', '', 'japan_racing.png'),
(39, 'Japspeed', '', 'japspeed.png'),
(40, 'K1 Technologies', '', 'k1_technologies.png'),
(41, 'Kaaz', '', 'kaaz.png'),
(42, 'Lexus', '', 'lexus.png'),
(43, 'Mazda', '', 'mazda.png'),
(44, 'Mishimoto', '', 'mishimoto.png'),
(45, 'Mitsubishi', '', 'mitsubishi.png'),
(46, 'Momo', '', 'momo.png'),
(47, 'Motul', '', 'motul.png'),
(48, 'Mugen', '', 'mugen.png'),
(49, 'Nankang', '', 'nankang.png'),
(50, 'Nardi', '', 'nardi.png'),
(51, 'Nismo', '', 'nismo.png'),
(52, 'Nissan', '', 'nissan.png'),
(53, 'Öhlins', '', 'ohlins.png'),
(54, 'Origin Labo', '', 'origin_labo.png'),
(55, 'Pandem', '', 'pandem.png'),
(56, 'Project Mu', '', 'project_mu.png'),
(57, 'Rays', '', 'rays.png'),
(58, 'Recaro', '', 'recaro.png'),
(59, 'Rota', '', 'rota.png'),
(60, 'Sabelt', '', 'sabelt.png'),
(61, 'Sparco', '', 'sparco.png'),
(62, 'SSR', '', 'ssr.png'),
(63, 'STRI', '', 'stri.png'),
(64, 'Subaru', '', 'subaru.png'),
(65, 'Takata', '', 'takata.png'),
(66, 'Tein', '', 'tein.png'),
(67, 'Tomei', '', 'tomei.png'),
(68, 'Top Secret', '', 'top_secret.png'),
(69, 'Toyo Tires', '', 'toyo_tires.png'),
(70, 'Toyota', '', 'toyota.png'),
(71, 'Voltex', '', 'voltex.png'),
(72, 'Walbro', '', 'wallbro.png'),
(73, 'Whiteline', '', 'whiteline.png'),
(74, 'Willwood', '', 'wilwood.png'),
(75, 'Work', '', 'work.png'),
(76, 'Xtreme Clutch', '', 'xtreme_clutch.png'),
(77, 'Yokohama', '', 'yokohama.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_coche`
--

CREATE TABLE `modelo_coche` (
  `id` int NOT NULL,
  `nombre` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `motor` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `potencia` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `transmision` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagen` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `modelo_coche`
--

INSERT INTO `modelo_coche` (`id`, `nombre`, `motor`, `potencia`, `transmision`, `imagen`, `descripcion`) VALUES
(1, 's13 200SX', 'CA18DET', '172', 'Manual', 'nissan/s13/200SX/s13_200SX.jpg', 'test'),
(2, 's14 200SX', 'SR20DET', '200', 'Manual', '/nissan/s14/zenki/nissan_s14_zenki.jpg', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pieza`
--

CREATE TABLE `pieza` (
  `id` int NOT NULL,
  `nombre_pieza` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `marca_pieza` int NOT NULL,
  `modelo_coche` int NOT NULL,
  `tipo` int NOT NULL,
  `imagen` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `url` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `pieza`
--

INSERT INTO `pieza` (`id`, `nombre_pieza`, `marca_pieza`, `modelo_coche`, `tipo`, `imagen`, `url`, `descripcion`) VALUES
(1, 'Brazos de caída regulables', 20, 2, 12, '/chasis/brazos/traseros/driftworks/brazos_traseros_regulables_s14.jpg', 'https://www.dna-autoparts.com/accesorios-nissan-200sx-s14-chasis/4133-brazos-de-caida-traseros-regulables-driftworks-200sx-s14.html?search_query=s14+brazos+de+caida&results=7', ''),
(2, 'Brazos de caída regulables', 20, 1, 12, '/chasis/brazos/traseros/driftworks/brazos_traseros_regulables_s13.jpg', 'https://www.dna-autoparts.com/chasis/4132-brazos-de-caida-traseros-regulables-driftworks-200sx-s13.html', ''),
(3, 'Volante Nardi Deep Corn 350mm', 50, 1, 9, '/direccion/volantes/nardi/nardi_deep_corn_350mm.jpg', 'https://www.dna-autoparts.com/accesorios-toyota-gt86-interior/2770-volante-nardi-deep-corn.html?search_query=nardi&results=19', ''),
(4, 'Greddy Intercooler Kit Type24F', 31, 2, 3, '/admision/intercoolers/greddy/type24F_s14_s15.jpg', 'http://www.greddy.com/', ''),
(5, 'Turbo Garrett GT2560R', 30, 1, 2, '/motor/turbos/garrett/GT2560R.jpg', 'https://www.dna-autoparts.com/accesorios-nissan-200sx-s14-motor-y-preparacion/2864-turbo-garrett-gt2560r-466541-5004s-s15.html?search_query=turbo&results=185', ''),
(6, 'Volante Nardi Deep Corn 350mm', 50, 2, 9, '/direccion/volantes/nardi/nardi_deep_corn_350mm.jpg', 'https://www.dna-autoparts.com/accesorios-toyota-gt86-interior/2770-volante-nardi-deep-corn.html?search_query=nardi&results=19', ''),
(7, 'Turbo Garrett GT2560R', 30, 2, 2, '/motor/turbos/garrett/GT2560R.jpg', 'https://www.dna-autoparts.com/accesorios-nissan-200sx-s14-motor-y-preparacion/2864-turbo-garrett-gt2560r-466541-5004s-s15.html?search_query=turbo&results=185', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `piezas_coche`
--

CREATE TABLE `piezas_coche` (
  `id` int NOT NULL,
  `coche` int NOT NULL,
  `pieza` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `piezas_coche`
--

INSERT INTO `piezas_coche` (`id`, `coche`, `pieza`) VALUES
(1, 1, 2),
(2, 1, 3),
(3, 1, 5),
(4, 2, 1),
(5, 2, 4),
(6, 2, 6),
(7, 2, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pieza`
--

CREATE TABLE `tipo_pieza` (
  `id` int NOT NULL,
  `nombre` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagen` text COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_pieza`
--

INSERT INTO `tipo_pieza` (`id`, `nombre`, `imagen`) VALUES
(1, 'Todos', 'japan.svg'),
(2, 'Motor', 'motor.svg'),
(3, 'Admisión', 'admision.svg'),
(4, 'Escape', 'escape.svg'),
(5, 'Refrigeración', 'refrigeracion.svg'),
(6, 'Suspensión', 'suspension.svg'),
(7, 'Frenos', 'frenos.svg'),
(8, 'Transmisión', 'transmision.svg'),
(9, 'Dirección', 'direccion.svg'),
(10, 'Ruedas', 'ruedas.svg'),
(11, 'Interior', 'interior.svg'),
(12, 'Chasis', 'chasis.svg'),
(13, 'ECU', 'ecu.svg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int NOT NULL,
  `username` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `password` text COLLATE utf8mb4_spanish_ci NOT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `exp_date` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `username`, `email`, `password`, `token`, `exp_date`) VALUES
(1, 'admin', 'admin@admin.com', 'dd94709528bb1c83d08f3088d4043f4742891f4f', '6fb101a2ac604f9ed37ae8d5cd809a8e665b60da6d717d6af172de17cb6292237ad251ba06aa8f8aa49e512e5ccd608b53fec63aa7e4dc6621301ac3f7ca0c55e06025a3768417b6ab89ac074ecea50e7ce5b1c61e73b6473ab16b31cde1fce0270fd5a7528a02b1524d60bbc45b13093fbac6afc653e5e279fd572f93a8bd82', '2021-05-20');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `coche`
--
ALTER TABLE `coche`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usuario` (`usuario`),
  ADD KEY `fk_modelo_coche` (`modelo_coche`),
  ADD KEY `fk_marca_coche` (`marca_coche`);

--
-- Indices de la tabla `marca_coche`
--
ALTER TABLE `marca_coche`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `marca_pieza`
--
ALTER TABLE `marca_pieza`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `modelo_coche`
--
ALTER TABLE `modelo_coche`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pieza`
--
ALTER TABLE `pieza`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_marca_pieza` (`marca_pieza`),
  ADD KEY `fk_modelo_coche_pieza` (`modelo_coche`);

--
-- Indices de la tabla `piezas_coche`
--
ALTER TABLE `piezas_coche`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_coche` (`coche`),
  ADD KEY `fk_pieza` (`pieza`);

--
-- Indices de la tabla `tipo_pieza`
--
ALTER TABLE `tipo_pieza`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `coche`
--
ALTER TABLE `coche`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `marca_coche`
--
ALTER TABLE `marca_coche`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `marca_pieza`
--
ALTER TABLE `marca_pieza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `modelo_coche`
--
ALTER TABLE `modelo_coche`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pieza`
--
ALTER TABLE `pieza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `piezas_coche`
--
ALTER TABLE `piezas_coche`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipo_pieza`
--
ALTER TABLE `tipo_pieza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `coche`
--
ALTER TABLE `coche`
  ADD CONSTRAINT `fk_marca_coche` FOREIGN KEY (`marca_coche`) REFERENCES `marca_coche` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_modelo_coche` FOREIGN KEY (`modelo_coche`) REFERENCES `modelo_coche` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`usuario`) REFERENCES `usuario` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `pieza`
--
ALTER TABLE `pieza`
  ADD CONSTRAINT `fk_marca_pieza` FOREIGN KEY (`marca_pieza`) REFERENCES `marca_pieza` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_modelo_coche_pieza` FOREIGN KEY (`modelo_coche`) REFERENCES `modelo_coche` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Filtros para la tabla `piezas_coche`
--
ALTER TABLE `piezas_coche`
  ADD CONSTRAINT `fk_coche` FOREIGN KEY (`coche`) REFERENCES `coche` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_pieza` FOREIGN KEY (`pieza`) REFERENCES `pieza` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
