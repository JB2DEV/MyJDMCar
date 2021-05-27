-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 27-05-2021 a las 18:14:36
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
  `nombre` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagen` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `marca_coche`
--

INSERT INTO `marca_coche` (`id`, `nombre`, `imagen`) VALUES
(1, 'Honda', 'honda.png'),
(2, 'Lexus', 'lexus.png'),
(3, 'Mazda', 'mazda.png'),
(4, 'Mitsubishi', 'mitsubishi.png'),
(5, 'Nissan', 'nissan.png'),
(6, 'Subaru', 'subaru.png'),
(7, 'Toyota', 'toyota.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca_pieza`
--

CREATE TABLE `marca_pieza` (
  `id` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagen` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
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
(30, 'Garrett', 'Garrett Motion, es una empresa estadounidense que se dedica principalmente a la ingeniería, el desarrollo y la fabricación de turbocompresores y sistemas de inducción forzada relacionados para vehículos terrestres, desde pequeños automóviles de pasajeros hasta grandes camiones y equipos industriales y maquinaria de construcción.', 'garret.png'),
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
  `marca_coche` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `motor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `potencia` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `transmision` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagen` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `modelo_coche`
--

INSERT INTO `modelo_coche` (`id`, `marca_coche`, `nombre`, `motor`, `potencia`, `transmision`, `imagen`, `descripcion`) VALUES
(1, 5, 's13', 'CA18DET', '169', 'Manual', '/nissan/s13/200SX/s13_200SX.jpg', 'El Silvia S13, presentado entre 1988 y 1989, se hizo muy popular en Japón. Tras su presentación en 1988, ganó el premio al coche del año en Japón. El Silvia no se exportó, sin embargo se rebautizó como 180SX. Las versiones europeas de este coche, se denominaron 200SX. En Norteamérica, el S13 (frontal 180SX, 3 carrocerías distintas) se denominó 240SX.\r\n\r\nEl Nissan Silvia S13 nunca se vendió en España, todos los ejemplares existentes son gracias al mercado de importación desde Japón.\r\n\r\nInformación General\r\n\r\nMarca							Nissan\r\nModelo						200 SX\r\nGeneración						200 SX (S13)\r\nModificación (motor)				1.8 Turbo (169 CV)\r\nAño de producción					1988\r\nAño de finalización de la producción		1993\r\nCombustión						Combustión interna\r\nTipo de carrocería					Coupe\r\nNumero de plazas					2+2\r\nNumero de puertas					2\r\n\r\nRendimiento\r\n\r\nConsumo medio					9.1 l/100 km\r\nCombustible						Gasolina\r\nAceleración 						0 - 100 km/h	7.5 s\r\nVelocidad máxima					220 km/h\r\nRelación peso/potencia				7.2 kg/CV\r\n\r\nMotor\r\n\r\nPotencia máxima					169 CV @ 6400rpm.\r\nPotencia por litro					93.4 CV/l\r\nPar máximo						224 Nm @ 4000rpm.\r\nPosición del motor					Frontal, longitudinal\r\nCilindrada real					1809 cm3\r\nNúmero de cilindros					4\r\nDistribución de los cilindros			En línea\r\nDiámetro del cilindro				83 mm\r\nRecorrido del cilindro				83.6 mm\r\nRatio de compresión				8.5\r\nNúmero de válvulas por cilindro			4\r\nSistema de combustible				Inyección indirecta multipunto\r\nAspiración del motor				Turbocompresor\r\nDistribución						DOHC\r\n\r\nVolumen y peso\r\n\r\nPeso en orden de marcha				1220 kg\r\nPeso máximo admisible				1675 kg\r\nCarga máxima						455 kg\r\nCapacidad maletero min.				320 l\r\nCapacidad depósito					60 l\r\n\r\nMedidas\r\n\r\nLongitud						4535 mm\r\nAnchura						1690 mm\r\nAltura							1290 mm\r\nDistancia entre ejes					2475 mm\r\nVía delantera						1465 mm\r\nVía trasera						1465 mm\r\n\r\nCadena cinemática, frenos y suspensión\r\n\r\nTracción						Tracción trasera\r\nNúmero de velocidades (transmisión manual)	5\r\nSuspensión delantera					Wishbone\r\nSuspensión trasera					Puntal de resorte coilover.\r\nFrenos delanteros					Discos ventilados\r\nFrenos traseros					Discos\r\nSistemas de asistencia				ABS \r\nDirección, tipo					Cremallera de dirección\r\nDirección asistida					Dirección hidráulica\r\nTamaño de neumáticos				195/60 R15\r\n'),
(2, 5, 's14', 'SR20DET', '200', 'Manual', '/nissan/s14/zenki/nissan_s14_zenki.jpg', 'El Silvia S14 fue lanzado al mercado a finales de 1993. Sus motores eran un 2.0 litros con turbocompresor, distribución variable y 200 CV de potencia máxima. También se produjo una versión atmosférica con 150CV que llevaba el motor SR20DE, es decir, sin turbo.\r\n\r\nTenía detalles similares al S13. Existían las variantes «Aero» de Q y K con alerones de mayor dimensión.\r\n\r\nInformación general\r\n\r\nMarca	Nissan\r\nModelo	Silvia\r\nGeneración	Silvia (S14)\r\nModificación (motor)	2.0 i 16V Turbo (200 CV)\r\nAño de producción	1993 \r\nAño de finalización de la producción	1999 años\r\nArquitectura de la unidad de potencia	Motor de combustión interna\r\nTipo de carrocería	Coupe\r\nNumero de plazas	2+2\r\nNumero de puertas	2\r\nRendimiento\r\nConsumo de combustible combinado	14.7 l/100 km\r\n16 US mpg\r\n19.22 UK mpg\r\nCombustible	Gasolina\r\nAceleración 0 - 100 km/h	7.3 s\r\nAceleración 0 - 62 mph	7.3 s\r\nAceleración 0 - 60 mph (Calculado por Auto-Data.net)	6.9 s\r\nVelocidad máxima	235 km/h\r\n146.02 mph\r\n\r\nMotor\r\n\r\nPotencia máxima	200 CV @ 6400rpm.\r\nPotencia por litro	100.1 CV/l\r\nPar máximo	265 Nm @ 4800rpm.\r\n195.45 lb.-ft. @ 4800rpm.\r\nPosición del motor	Frontal, longitudinal\r\nCilindrada -real-	1998 cm3\r\n121.93 cu. in.\r\nNúmero de cilindros	4\r\nDistribución de los cilindros	En línea\r\nDiámetro del cilindro	86 mm\r\n3.39 in.\r\nRecorrido del cilindro	86 mm\r\n3.39 in.\r\nRatio de compresión	8.5\r\nNúmero de válvulas por cilindro	4\r\nSistema de combustible	Inyección indirecta multipunto\r\nAspiración del motor	Turbocompresor\r\nDistribución	DOHC\r\n\r\nVolumen y peso\r\n\r\nCapacidad depósito	65 l\r\n17.17 US gal | 14.3 UK gal\r\n\r\nMedidas\r\n\r\nLongitud	4500 mm\r\n177.17 in.\r\nAnchura	1730 mm\r\n68.11 in.\r\nAltura	1295 mm\r\n50.98 in.\r\nDistancia entre ejes	2525 mm\r\n99.41 in.\r\nVía delantera	1480 mm\r\n58.27 in.\r\nVía trasera	1470 mm\r\n57.87 in.\r\nDiámetro giro	9.6 m\r\n31.5 ft.\r\n\r\nCadena cinemática, frenos y suspensión\r\n\r\nArquitectura de propulsión	El motor de combustión interna propulsa las ruedas traseras del vehículo.\r\nTracción	Tracción trasera\r\nNúmero de velocidades (transmisión manual)	5\r\nSuspensión delantera	Puntal de resorte coilover\r\nSuspensión trasera	Resorte helicoidal\r\nFrenos delanteros	Discos ventilados\r\nFrenos traseros	Discos\r\nSistemas de asistencia	ABS (Sistema antibloqueo de ruedas)\r\nDirección asistida	Dirección hidráulica\r\nTamaño de neumáticos	205/55 R16V'),
(3, 5, 's13', 'SR20DET', '205', 'Manual', '/nissan/s13/180SX/s13_180SX.jpg', 'El Silvia S13, presentado entre 1988 y 1989, se hizo muy popular en Japón. Tras su presentación en 1988, ganó el premio al coche del año en Japón. El Silvia no se exportó, sin embargo se rebautizó como 180SX. Las versiones europeas de este coche, se denominaron 200SX. En Norteamérica, el S13 (frontal 180SX, 3 carrocerías distintas) se denominó 240SX.\\nEl Nissan Silvia S13 nunca se vendió en España, todos los ejemplares existentes son gracias al mercado de importación desde Japón.\r\n\r\nInformación general\r\n\r\nMarca							Nissan\r\nModelo						Silvia\r\nGeneración						Silvia (S13)\r\nModificación (motor)					2.0T (205 CV)\r\nAño de producción					1991\r\nAño de finalización de la producción		1993 \r\nCombustión						Motor de combustión interna\r\nTipo de carrocería					Coupe\r\nNumero de plazas					4\r\nNumero de puertas					2\r\n\r\nRendimiento\r\n\r\nCombustible						Gasolina\r\nRelación peso/potencia				5.7 kg/CV\r\n\r\nMotor\r\n\r\nPotencia máxima					205 CV @ 6000rpm.\r\nPotencia por litro					102.6 CV/l\r\nPar máximo						275 Nm @ 4000rpm.\r\nPosición del motor					Frontal, transversal\r\nModelo del motor					SR20DET\r\nCilindrada -real-					1998 cm3\r\nNúmero de cilindros					4\r\nDistribución de los cilindros				En línea\r\nDiámetro del cilindro					86 mm\r\nRecorrido del cilindro					86 mm\r\nRatio de compresión					9\r\nNúmero de válvulas por cilindro			4\r\nSistema de combustible				Inyección indirecta multipunto\r\nAspiración del motor					Turbocompresor\r\nDistribución						DOHC\r\n\r\nVolumen y peso\r\n\r\nPeso en orden de marcha				1170 kg\r\nCapacidad depósito					60 l\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nMedidas\r\n\r\nLongitud						4470 mm\r\nAnchura						1690 mm\r\nAltura							1290 mm\r\nDistancia entre ejes					2475 mm\r\nVía delantera						1465 mm\r\nVía trasera						1460 mm\r\nDiámetro giro						9.4 m\r\n\r\nCadena cinemática, frenos y suspensión\r\nTracción						Tracción trasera\r\nNúmero de velocidades (transmisión manual)	5\r\nSuspensión delantera					Puntal de resorte coilover\r\nSuspensión trasera					Dependientes, muelles multibrazo con amortiguadores telescópicos\r\nFrenos delanteros					Discos ventilados\r\nFrenos traseros					Discos\r\nTamaño de neumáticos				205/60R15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pieza`
--

CREATE TABLE `pieza` (
  `id` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `marca_pieza` int NOT NULL,
  `modelo_coche` int NOT NULL,
  `tipo` int NOT NULL,
  `imagen` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `pieza`
--

INSERT INTO `pieza` (`id`, `nombre`, `marca_pieza`, `modelo_coche`, `tipo`, `imagen`, `url`, `descripcion`) VALUES
(1, 'Brazos de caída regulables', 20, 2, 12, '/chasis/brazos/traseros/driftworks/brazos_traseros_regulables_s14.jpg', 'https://www.dna-autoparts.com/accesorios-nissan-200sx-s14-chasis/4133-brazos-de-caida-traseros-regulables-driftworks-200sx-s14.html?search_query=s14+brazos+de+caida&results=7', ''),
(2, 'Brazos de caída regulables', 20, 1, 12, '/chasis/brazos/traseros/driftworks/brazos_traseros_regulables_s13.jpg', 'https://www.dna-autoparts.com/chasis/4132-brazos-de-caida-traseros-regulables-driftworks-200sx-s13.html', ''),
(3, 'Volante Nardi Deep Corn 350mm', 50, 1, 9, '/direccion/volantes/nardi/nardi_deep_corn_350mm.jpg', 'https://www.dna-autoparts.com/accesorios-toyota-gt86-interior/2770-volante-nardi-deep-corn.html?search_query=nardi&results=19', ''),
(4, 'Greddy Intercooler Kit Type24F', 31, 2, 3, '/admision/intercoolers/greddy/type24F_s14_s15.jpg', 'http://www.greddy.com/', ''),
(5, 'Turbo Garrett GT2560R', 30, 1, 2, '/motor/turbos/garrett/GT2560R.jpg', 'https://www.dna-autoparts.com/accesorios-nissan-200sx-s14-motor-y-preparacion/2864-turbo-garrett-gt2560r-466541-5004s-s15.html?search_query=turbo&results=185', 'CARACTERÍSTICAS TÉCNICAS:\r\n\r\nLado admisión:  TRIM 60 A/R 0.60\r\nLa turbina de escape está fundida en INCONEL para aplicaciones extremas\r\nLado escape:  TRIM 62 A/R 0.64 - T25  / 5-espárragos - Con válvula\r\nAlojamiento cojinetes: Refrigerado por aceite y agua\r\nCaracolas de escape opcionales\r\n\r\nINFORMACIÓN TÉCNICA:\r\n\r\nRodamientos.\r\nCuerpo refrigerado por aceite y agua.\r\nPotenciación para GT2854R - 471171-0003 y GT2854R - 471171-0009, todas las conexiones son intercambiables excepto la entrada de la admisión.\r\nEntrada de gases tipo T25.\r\nIgual que el GT2560R - 466541-0001, excepto el material de la caracola de escape y la turbina.\r\nLa caracola de escape está fundida con una aleación rica en Niquel \"Ni-Resist\", material usado en aplicaciones extremas.\r\nLa turbina de escape está fundida en \"Inconel\", material usado en turbinas que alcanzan una gran temperatura.\r\nTamaño compacto para aplicaciones con poco espacio.\r\nIdeal para pequeñas cilindradas, consiguinedo hasta 280 CV.'),
(6, 'Volante Nardi Deep Corn 350mm', 50, 2, 9, '/direccion/volantes/nardi/nardi_deep_corn_350mm.jpg', 'https://www.dna-autoparts.com/accesorios-toyota-gt86-interior/2770-volante-nardi-deep-corn.html?search_query=nardi&results=19', ''),
(7, 'Turbo Garrett GT2560R', 30, 2, 2, '/motor/turbos/garrett/GT2560R.jpg', 'https://www.dna-autoparts.com/accesorios-nissan-200sx-s14-motor-y-preparacion/2864-turbo-garrett-gt2560r-466541-5004s-s15.html?search_query=turbo&results=185', 'CARACTERÍSTICAS TÉCNICAS:\r\n\r\nLado admisión:  TRIM 60 A/R 0.60\r\nLa turbina de escape está fundida en INCONEL para aplicaciones extremas\r\nLado escape:  TRIM 62 A/R 0.64 - T25  / 5-espárragos - Con válvula\r\nAlojamiento cojinetes: Refrigerado por aceite y agua\r\nCaracolas de escape opcionales\r\n\r\nINFORMACIÓN TÉCNICA:\r\n\r\nRodamientos.\r\nCuerpo refrigerado por aceite y agua.\r\nPotenciación para GT2854R - 471171-0003 y GT2854R - 471171-0009, todas las conexiones son intercambiables excepto la entrada de la admisión.\r\nEntrada de gases tipo T25.\r\nIgual que el GT2560R - 466541-0001, excepto el material de la caracola de escape y la turbina.\r\nLa caracola de escape está fundida con una aleación rica en Niquel \"Ni-Resist\", material usado en aplicaciones extremas.\r\nLa turbina de escape está fundida en \"Inconel\", material usado en turbinas que alcanzan una gran temperatura.\r\nTamaño compacto para aplicaciones con poco espacio.\r\nIdeal para pequeñas cilindradas, consiguinedo hasta 280 CV.');

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
(3, 1, 5),
(6, 2, 6),
(7, 2, 7),
(8, 1, 3),
(11, 1, 2),
(12, 2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pieza`
--

CREATE TABLE `tipo_pieza` (
  `id` int NOT NULL,
  `nombre` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `imagen` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL
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
  `username` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `email` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci NOT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci,
  `exp_date` text CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `username`, `email`, `password`, `token`, `exp_date`) VALUES
(1, 'admin', 'admin@admin.com', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8', 'a8dc2a75a27106e5b5aa0f566be1bc13491d5ebf', '2021-05-28'),
(2, 'Test', 'test@mail.com', '8030720b9572c5d340e43ddcf35692b8ccb0efb3', NULL, NULL),
(3, 'Javi', 'javi@mail.com', '7c222fb2927d828af22f592134e8932480637c0d', '0c5ade413ff606f5a39c92a0badcfafca7e8656a148b9033584fcf174d6feb1dab949a2174653d7e8af4f86160af44c0fd3a242c6718384193d3de7a8ed57b650c6b42e3dbd77de8cfe55ab92c5722f8c4308672728e92c52c0485ad36368dd03b2974a7cc2b7ac030b47b596a0b2568d52532bf7428069886ae9be6704368ba', '2021-05-23');

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_marca_modelo` (`marca_coche`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pieza`
--
ALTER TABLE `pieza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `piezas_coche`
--
ALTER TABLE `piezas_coche`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tipo_pieza`
--
ALTER TABLE `tipo_pieza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- Filtros para la tabla `modelo_coche`
--
ALTER TABLE `modelo_coche`
  ADD CONSTRAINT `fk_marca_modelo` FOREIGN KEY (`marca_coche`) REFERENCES `marca_coche` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

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
