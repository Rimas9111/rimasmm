-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 2018 m. Spa 30 d. 19:12
-- Server version: 5.7.23
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rimasmm`
--

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_admin_chat`
--

DROP TABLE IF EXISTS `cf_admin_chat`;
CREATE TABLE IF NOT EXISTS `cf_admin_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin` varchar(25) COLLATE utf8_lithuanian_ci NOT NULL,
  `msg` longtext COLLATE utf8_lithuanian_ci NOT NULL,
  `date` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_chat_box`
--

DROP TABLE IF EXISTS `cf_chat_box`;
CREATE TABLE IF NOT EXISTS `cf_chat_box` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nikas` varchar(150) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `msg` varchar(250) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `niko_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_chat_box`
--

INSERT INTO `cf_chat_box` (`id`, `nikas`, `msg`, `time`, `niko_id`) VALUES
(1, 'Sistema', 'Labas, Pasauli :)', '2012-09-09 13:48:22', 1);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_duk`
--

DROP TABLE IF EXISTS `cf_duk`;
CREATE TABLE IF NOT EXISTS `cf_duk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `klausimas` varchar(200) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `atsakymas` text COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_d_forumai`
--

DROP TABLE IF EXISTS `cf_d_forumai`;
CREATE TABLE IF NOT EXISTS `cf_d_forumai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pav` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `place` int(11) DEFAULT NULL,
  `teises` varchar(250) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_d_straipsniai`
--

DROP TABLE IF EXISTS `cf_d_straipsniai`;
CREATE TABLE IF NOT EXISTS `cf_d_straipsniai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `pav` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `last_data` int(10) DEFAULT NULL,
  `last_nick` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `autorius` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `uzrakinta` set('taip','ne') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'ne',
  `sticky` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_d_temos`
--

DROP TABLE IF EXISTS `cf_d_temos`;
CREATE TABLE IF NOT EXISTS `cf_d_temos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) DEFAULT NULL,
  `pav` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `aprasymas` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `last_data` int(10) DEFAULT NULL,
  `last_nick` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `place` int(11) DEFAULT NULL,
  `teises` varchar(250) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_d_zinute`
--

DROP TABLE IF EXISTS `cf_d_zinute`;
CREATE TABLE IF NOT EXISTS `cf_d_zinute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `nick` int(11) DEFAULT NULL,
  `zinute` text COLLATE utf8_lithuanian_ci,
  `laikas` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_galerija`
--

DROP TABLE IF EXISTS `cf_galerija`;
CREATE TABLE IF NOT EXISTS `cf_galerija` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `pavadinimas` char(100) COLLATE utf8_lithuanian_ci DEFAULT 'Be pavadinimo',
  `file` char(100) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'none.png',
  `foto` text COLLATE utf8_lithuanian_ci,
  `apie` longtext COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `autorius` int(6) NOT NULL DEFAULT '0',
  `data` int(10) DEFAULT NULL,
  `categorija` int(3) DEFAULT '1',
  `teises` varchar(2) COLLATE utf8_lithuanian_ci DEFAULT 'N;',
  `kom` set('taip','ne') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'taip',
  `rodoma` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  PRIMARY KEY (`ID`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_grupes`
--

DROP TABLE IF EXISTS `cf_grupes`;
CREATE TABLE IF NOT EXISTS `cf_grupes` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(128) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `aprasymas` mediumtext COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `teises` varchar(150) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  `pav` varchar(256) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `path` varchar(150) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  `kieno` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `place` int(11) NOT NULL DEFAULT '1',
  `mod` text COLLATE utf8_lithuanian_ci,
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_kas_prisijunges`
--

DROP TABLE IF EXISTS `cf_kas_prisijunges`;
CREATE TABLE IF NOT EXISTS `cf_kas_prisijunges` (
  `id` int(11) NOT NULL,
  `uid` varchar(11) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '',
  `timestamp` int(15) NOT NULL DEFAULT '0',
  `ip` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `file` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `user` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `agent` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `ref` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `clicks` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `ip` (`ip`),
  KEY `file` (`file`),
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_kas_prisijunges`
--

INSERT INTO `cf_kas_prisijunges` (`id`, `uid`, `timestamp`, `ip`, `file`, `user`, `agent`, `ref`, `clicks`) VALUES
(1, 'i7fjvXsYNS', 1540364968, '::1', 'admin;a,3', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36\'', 'http://localhost/Rimass/mightmedia_cms-trunk/tevai/admin;a,3', 4),
(1, 'Y3a3cNdzT5', 1540365389, '::1', '', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36\'', 'http://localhost/Rimass/mightmedia_cms-trunk/', 8),
(1, 'sEzFFfpjtB', 1540366633, '::1', 'admin;a,3', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36\'', 'http://localhost/RimasS/mightmedia_cms-trunk/tevai/admin;a,3', 17),
(1, 'afYSYDCaS3', 1540372710, '::1', 'admin;a,3', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36\'', 'http://localhost/RimasS/mightmedia_cms-trunk/tevai/admin;a,3', 23),
(1, 'sovLZiktQF', 1540385605, '::1', 'install/klaida.php', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36\'', 'http://localhost/RimasS/mightmedia_cms-trunk/stiliai/iridium/default.css', 127),
(1, 'kEJQSyzZLd', 1540385604, '::1', 'Forumas', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.67 Safari/537.36\'', 'http://localhost/RimasS/mightmedia_cms-trunk/Apie', 50);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_knyga`
--

DROP TABLE IF EXISTS `cf_knyga`;
CREATE TABLE IF NOT EXISTS `cf_knyga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nikas` varchar(150) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `msg` varchar(250) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `msg` (`msg`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_kom`
--

DROP TABLE IF EXISTS `cf_kom`;
CREATE TABLE IF NOT EXISTS `cf_kom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kid` int(11) NOT NULL DEFAULT '0',
  `pid` varchar(255) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  `zinute` text COLLATE utf8_lithuanian_ci,
  `nick` varchar(250) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `nick_id` int(11) NOT NULL DEFAULT '0',
  `data` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_logai`
--

DROP TABLE IF EXISTS `cf_logai`;
CREATE TABLE IF NOT EXISTS `cf_logai` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `action` text COLLATE utf8_lithuanian_ci,
  `time` int(10) DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_naujienos`
--

DROP TABLE IF EXISTS `cf_naujienos`;
CREATE TABLE IF NOT EXISTS `cf_naujienos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `kategorija` int(2) NOT NULL DEFAULT '1',
  `naujiena` mediumtext COLLATE utf8_lithuanian_ci,
  `daugiau` text COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `data` int(10) DEFAULT NULL,
  `autorius` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `kom` set('taip','ne') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'taip',
  `rodoma` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  `sticky` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_naujienos`
--

INSERT INTO `cf_naujienos` (`id`, `pavadinimas`, `kategorija`, `naujiena`, `daugiau`, `lang`, `data`, `autorius`, `kom`, `rodoma`, `sticky`) VALUES
(1, 'Sveikiname įdiegus MightMedia TVS v.1.46', 0, 'Jūs sėkmingai įdiegėte <a target=\"_blank\" title=\"MightMedia TVS\" href=\"http://www.mightmedia.lt\">MightMedia TVS</a> . Jos autoriai <a target=\"_blank\" href=\"http://code.google.com/p/coders/\"><strong>CodeRS</strong></a> . Prašome nepasisavinti autorinių teisių, priešingu atveju jūs pažeisite GNU teises.', 'Kiekvienam puslapyje privalomas užrašas apačioje \"<a target=\"_blank\" href=\"http://www.mightmedia.lt/\">MightMedia</a>\" su nuoroda į <a target=\"_blank\" href=\"http://www.mightmedia.lt/\">http://www.mightmedia.lt</a>\r\n', 'lt', 1346622467, 'Sistema', 'taip', 'TAIP', 0);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_newsgetters`
--

DROP TABLE IF EXISTS `cf_newsgetters`;
CREATE TABLE IF NOT EXISTS `cf_newsgetters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(250) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_nuorodos`
--

DROP TABLE IF EXISTS `cf_nuorodos`;
CREATE TABLE IF NOT EXISTS `cf_nuorodos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cat` int(3) NOT NULL DEFAULT '1',
  `url` varchar(200) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'http://',
  `pavadinimas` varchar(200) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  `click` int(11) NOT NULL DEFAULT '0',
  `nick` int(5) DEFAULT NULL,
  `date` int(10) DEFAULT NULL,
  `apie` text COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `active` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  `balsai` int(255) NOT NULL DEFAULT '0',
  `balsavo` text COLLATE utf8_lithuanian_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_nustatymai`
--

DROP TABLE IF EXISTS `cf_nustatymai`;
CREATE TABLE IF NOT EXISTS `cf_nustatymai` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `val` text COLLATE utf8_lithuanian_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_nustatymai`
--

INSERT INTO `cf_nustatymai` (`id`, `key`, `val`) VALUES
(1, 'Pavadinimas', 'Rimas'),
(2, 'Apie', 'Rimo portalas'),
(3, 'Keywords', 'TVS, mightmedia, coders'),
(4, 'Copyright', '<a href=\"http://www.mightmedia.lt\" target=\"_blank\">MightMedia TVS</a> labas kaip sekas'),
(5, 'Palaikymas', '0'),
(6, 'Maintenance', 'Atsiprašome<br /> Svetainė šiuo metu yra tvarkoma.<br /> Prisijungti gali tik administratoriai.'),
(7, 'Chat_limit', '5'),
(8, 'News_limit', '5'),
(9, 'Stilius', 'iridium'),
(10, 'Bandymai', '3'),
(11, 'fotodyd', '450'),
(12, 'minidyd', '150'),
(13, 'galbalsuot', '1'),
(14, 'fotoperpsl', '10'),
(15, 'galkom', '1'),
(16, 'pirminis', 'naujienos'),
(17, 'keshas', '0'),
(18, 'kmomentarai_sveciams', '0'),
(19, 'F_urls', ';'),
(20, 'galorder', 'data'),
(21, 'galorder_type', 'DESC'),
(22, 'Editor', 'markitup'),
(23, 'hyphenator', '1'),
(24, 'Pastas', 'rimas9111@yahoo.com'),
(25, 'kalba', 'lt.php'),
(26, 'Admin_folder', 'tevai');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_page`
--

DROP TABLE IF EXISTS `cf_page`;
CREATE TABLE IF NOT EXISTS `cf_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `file` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `place` int(11) DEFAULT NULL,
  `show` enum('Y','N') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'Y',
  `teises` varchar(150) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  `parent` int(150) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_page`
--

INSERT INTO `cf_page` (`id`, `pavadinimas`, `lang`, `file`, `place`, `show`, `teises`, `parent`) VALUES
(1, 'Forumas', 'lt', 'frm.php', 3, 'Y', 'N;', 0),
(2, 'Naujienos', 'lt', 'naujienos.php', 1, 'Y', 'N;', 0),
(3, 'Apie', 'lt', 'apie.php', 5, 'Y', 'N;', 0),
(4, 'Registracija', 'lt', 'reg.php', 13, 'N', 'N;', 0),
(5, 'Slaptažodis', 'lt', 'slaptazodzio_priminimas.php', 12, 'N', 'N;', 0),
(6, 'Profilio redagavimas', 'lt', 'edit_user.php', 11, 'N', 'N;', 0),
(7, 'Paieška', 'lt', 'search.php', 6, 'Y', 'N;', 0),
(8, 'Kontaktai', 'lt', 'kontaktas.php', 6, 'Y', 'N;', 0),
(9, 'Prisijungę', 'lt', 'online.php', 7, 'Y', 'N;', 0),
(10, 'Archyvas', 'lt', 'deze.php', 8, 'N', 'N;', 0),
(11, 'Asmeniniai pranešimai', 'lt', 'pm.php', 0, 'N', 'N;', 0),
(12, 'Profilis', 'lt', 'view_user.php', 9, 'N', 'N;', 0),
(13, 'Nariai', 'lt', 'nariai.php', 10, 'Y', 'N;', 0),
(14, 'Galerija', 'lt', 'galerija.php', 4, 'Y', 'N;', 0),
(15, 'Straipsniai', 'lt', 'straipsnis.php', 2, 'Y', 'N;', 0);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_panel`
--

DROP TABLE IF EXISTS `cf_panel`;
CREATE TABLE IF NOT EXISTS `cf_panel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `panel` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `file` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `place` int(11) DEFAULT NULL,
  `align` enum('R','L','C') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'C',
  `rodyti` varchar(4) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `show` enum('Y','N') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'Y',
  `teises` varchar(150) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_panel`
--

INSERT INTO `cf_panel` (`id`, `panel`, `lang`, `file`, `place`, `align`, `rodyti`, `show`, `teises`) VALUES
(1, 'Kas naujo?', 'lt', 'kas_naujo.php', 1, 'R', 'Taip', 'Y', 'N;'),
(2, 'Narys', 'lt', 'vartotojas.php', 2, 'R', 'Taip', 'Y', 'N;'),
(3, 'Rėksnių dėžė', 'lt', 'reksniu_deze.php', 3, 'R', 'Taip', 'Y', 'N;'),
(4, 'Kalendorius', 'lt', 'kalendorius.php', 4, 'L', 'Taip', 'Y', 'N;'),
(5, 'Meniu', 'lt', 'meniu.php', 5, 'L', 'Taip', 'Y', 'N;'),
(6, 'Nullam purus diam, facilisis in ipsum eu', 'lt', 'lorem.php', 0, 'C', 'Taip', 'Y', 'i:0;');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_poll_answers`
--

DROP TABLE IF EXISTS `cf_poll_answers`;
CREATE TABLE IF NOT EXISTS `cf_poll_answers` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `question_id` int(255) NOT NULL DEFAULT '0',
  `answer` text CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_poll_questions`
--

DROP TABLE IF EXISTS `cf_poll_questions`;
CREATE TABLE IF NOT EXISTS `cf_poll_questions` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `question` text CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  `radio` int(1) NOT NULL DEFAULT '0',
  `shown` int(1) NOT NULL DEFAULT '0',
  `only_guests` int(1) NOT NULL,
  `author_id` int(11) NOT NULL DEFAULT '1',
  `author_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'Admin',
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_poll_votes`
--

DROP TABLE IF EXISTS `cf_poll_votes`;
CREATE TABLE IF NOT EXISTS `cf_poll_votes` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `question_id` int(255) NOT NULL DEFAULT '0',
  `answer_id` int(255) NOT NULL DEFAULT '0',
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_private_msg`
--

DROP TABLE IF EXISTS `cf_private_msg`;
CREATE TABLE IF NOT EXISTS `cf_private_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `to` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '...',
  `msg` text COLLATE utf8_lithuanian_ci,
  `read` set('YES','NO') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NO',
  `date` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_ratings`
--

DROP TABLE IF EXISTS `cf_ratings`;
CREATE TABLE IF NOT EXISTS `cf_ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_id` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `rating_num` int(11) DEFAULT NULL,
  `IP` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `psl` varchar(255) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_salis`
--

DROP TABLE IF EXISTS `cf_salis`;
CREATE TABLE IF NOT EXISTS `cf_salis` (
  `iso` char(2) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '',
  `name` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `printable_name` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `iso3` char(3) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`iso`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_salis`
--

INSERT INTO `cf_salis` (`iso`, `name`, `printable_name`, `iso3`, `numcode`) VALUES
('LT', 'LITHUANIA', 'Lithuania', 'LTU', 440),
('RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643),
('US', 'UNITED STATES', 'United States', 'USA', 840);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_siuntiniai`
--

DROP TABLE IF EXISTS `cf_siuntiniai`;
CREATE TABLE IF NOT EXISTS `cf_siuntiniai` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `paspaudimai` decimal(11,0) NOT NULL DEFAULT '0',
  `pavadinimas` char(100) COLLATE utf8_lithuanian_ci DEFAULT 'Be pavadinimo',
  `file` char(100) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'none.png',
  `foto` text COLLATE utf8_lithuanian_ci,
  `apie` longtext COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `autorius` int(6) NOT NULL DEFAULT '0',
  `data` int(10) DEFAULT NULL,
  `categorija` int(3) DEFAULT '1',
  `teises` varchar(2) COLLATE utf8_lithuanian_ci DEFAULT 'N;',
  `rodoma` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  PRIMARY KEY (`ID`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_straipsniai`
--

DROP TABLE IF EXISTS `cf_straipsniai`;
CREATE TABLE IF NOT EXISTS `cf_straipsniai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `pav` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `t_text` text COLLATE utf8_lithuanian_ci,
  `f_text` longtext COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `date` int(11) DEFAULT NULL,
  `autorius` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `autorius_id` int(11) DEFAULT NULL,
  `vote` int(11) DEFAULT NULL,
  `click` int(11) DEFAULT NULL,
  `kom` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'ne',
  `rodoma` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  `kat` int(125) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_s_punktai`
--

DROP TABLE IF EXISTS `cf_s_punktai`;
CREATE TABLE IF NOT EXISTS `cf_s_punktai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pav` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_s_punktai`
--

INSERT INTO `cf_s_punktai` (`id`, `pav`, `sid`) VALUES
(1, 'Atviras Kodas', 1);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `cf_users`
--

DROP TABLE IF EXISTS `cf_users`;
CREATE TABLE IF NOT EXISTS `cf_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `nick` varchar(15) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `levelis` int(2) NOT NULL DEFAULT '3',
  `pass` varchar(32) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `slaptas` char(32) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `icq` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `msn` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `skype` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `yahoo` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `aim` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `url` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `salis` varchar(3) COLLATE utf8_lithuanian_ci DEFAULT 'LT',
  `miestas` varchar(20) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `vardas` varchar(15) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `pavarde` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `gim_data` date DEFAULT NULL,
  `parasas` text COLLATE utf8_lithuanian_ci,
  `forum_temos` int(11) NOT NULL DEFAULT '0',
  `forum_atsakyta` int(11) NOT NULL DEFAULT '0',
  `taskai` decimal(11,0) NOT NULL DEFAULT '0',
  `balsai` int(11) NOT NULL DEFAULT '0',
  `balsavo` text COLLATE utf8_lithuanian_ci,
  `pm_viso` int(11) NOT NULL DEFAULT '50',
  `reg_data` int(10) DEFAULT NULL,
  `login_data` int(10) DEFAULT NULL,
  `login_before` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nick` (`nick`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `cf_users`
--

INSERT INTO `cf_users` (`id`, `ip`, `nick`, `levelis`, `pass`, `email`, `slaptas`, `icq`, `msn`, `skype`, `yahoo`, `aim`, `url`, `salis`, `miestas`, `vardas`, `pavarde`, `gim_data`, `parasas`, `forum_temos`, `forum_atsakyta`, `taskai`, `balsai`, `balsavo`, `pm_viso`, `reg_data`, `login_data`, `login_before`) VALUES
(1, '::1', 'rimas', 1, 'cbb143e7fd549cc5480f6475d5c861de', 'rimas9111@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'LT', NULL, NULL, NULL, NULL, 'Svetainės administratorius', 0, 0, '0', 0, NULL, 500, 1540322376, NULL, NULL);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_admin_chat`
--

DROP TABLE IF EXISTS `yn_admin_chat`;
CREATE TABLE IF NOT EXISTS `yn_admin_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin` varchar(25) COLLATE utf8_lithuanian_ci NOT NULL,
  `msg` longtext COLLATE utf8_lithuanian_ci NOT NULL,
  `date` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_chat_box`
--

DROP TABLE IF EXISTS `yn_chat_box`;
CREATE TABLE IF NOT EXISTS `yn_chat_box` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nikas` varchar(150) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `msg` varchar(250) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `niko_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_chat_box`
--

INSERT INTO `yn_chat_box` (`id`, `nikas`, `msg`, `time`, `niko_id`) VALUES
(1, 'Sistema', 'Labas, Pasauli :)', '2012-09-09 13:48:22', 1);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_duk`
--

DROP TABLE IF EXISTS `yn_duk`;
CREATE TABLE IF NOT EXISTS `yn_duk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `klausimas` varchar(200) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `atsakymas` text COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_d_forumai`
--

DROP TABLE IF EXISTS `yn_d_forumai`;
CREATE TABLE IF NOT EXISTS `yn_d_forumai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pav` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `place` int(11) DEFAULT NULL,
  `teises` varchar(250) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_d_straipsniai`
--

DROP TABLE IF EXISTS `yn_d_straipsniai`;
CREATE TABLE IF NOT EXISTS `yn_d_straipsniai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `pav` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `last_data` int(10) DEFAULT NULL,
  `last_nick` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `autorius` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `uzrakinta` set('taip','ne') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'ne',
  `sticky` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_d_temos`
--

DROP TABLE IF EXISTS `yn_d_temos`;
CREATE TABLE IF NOT EXISTS `yn_d_temos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fid` int(11) DEFAULT NULL,
  `pav` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `aprasymas` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `last_data` int(10) DEFAULT NULL,
  `last_nick` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `place` int(11) DEFAULT NULL,
  `teises` varchar(250) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_d_zinute`
--

DROP TABLE IF EXISTS `yn_d_zinute`;
CREATE TABLE IF NOT EXISTS `yn_d_zinute` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `nick` int(11) DEFAULT NULL,
  `zinute` text COLLATE utf8_lithuanian_ci,
  `laikas` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_galerija`
--

DROP TABLE IF EXISTS `yn_galerija`;
CREATE TABLE IF NOT EXISTS `yn_galerija` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `pavadinimas` char(100) COLLATE utf8_lithuanian_ci DEFAULT 'Be pavadinimo',
  `file` char(100) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'none.png',
  `foto` text COLLATE utf8_lithuanian_ci,
  `apie` longtext COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `autorius` int(6) NOT NULL DEFAULT '0',
  `data` int(10) DEFAULT NULL,
  `categorija` int(3) DEFAULT '1',
  `teises` varchar(2) COLLATE utf8_lithuanian_ci DEFAULT 'N;',
  `kom` set('taip','ne') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'taip',
  `rodoma` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  PRIMARY KEY (`ID`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_grupes`
--

DROP TABLE IF EXISTS `yn_grupes`;
CREATE TABLE IF NOT EXISTS `yn_grupes` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(128) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `aprasymas` mediumtext COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `teises` varchar(150) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  `pav` varchar(256) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `path` varchar(150) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  `kieno` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `place` int(11) NOT NULL DEFAULT '1',
  `mod` text COLLATE utf8_lithuanian_ci,
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_kas_prisijunges`
--

DROP TABLE IF EXISTS `yn_kas_prisijunges`;
CREATE TABLE IF NOT EXISTS `yn_kas_prisijunges` (
  `id` int(11) NOT NULL,
  `uid` varchar(11) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '',
  `timestamp` int(15) NOT NULL DEFAULT '0',
  `ip` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `file` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `user` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `agent` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `ref` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `clicks` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`),
  KEY `ip` (`ip`),
  KEY `file` (`file`),
  KEY `timestamp` (`timestamp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_kas_prisijunges`
--

INSERT INTO `yn_kas_prisijunges` (`id`, `uid`, `timestamp`, `ip`, `file`, `user`, `agent`, `ref`, `clicks`) VALUES
(1, 'jyD25Vf5OQ', 1540924786, '::1', 'admin/a,ajax/', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36\'', 'http://localhost:8081/rimasmm/tevai/admin/a,configuration/c,main', 50),
(1, 'WCAEFXnLAR', 1540921951, '::1', 'mightmedia_cms-trunk/tevai/admin;a,3', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36\'', 'http://localhost:8081/rimasmm/mightmedia_cms-trunk/tevai/admin;a,8', 11),
(1, '4o8COgj2xV', 1540926601, '::1', 'mightmedia_cms-trunk/', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36\'', 'Direct Link', 145),
(1, 'zbmEDJXCfC', 1540923334, '::1', 'Nario_profilis/rimas', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36\'', 'http://localhost:8081/rimasmm/tevai/admin/a,configuration/c,main', 2);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_knyga`
--

DROP TABLE IF EXISTS `yn_knyga`;
CREATE TABLE IF NOT EXISTS `yn_knyga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nikas` varchar(150) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `msg` varchar(250) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `msg` (`msg`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_kom`
--

DROP TABLE IF EXISTS `yn_kom`;
CREATE TABLE IF NOT EXISTS `yn_kom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kid` int(11) NOT NULL DEFAULT '0',
  `pid` varchar(255) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  `zinute` text COLLATE utf8_lithuanian_ci,
  `nick` varchar(250) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `nick_id` int(11) NOT NULL DEFAULT '0',
  `data` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_logai`
--

DROP TABLE IF EXISTS `yn_logai`;
CREATE TABLE IF NOT EXISTS `yn_logai` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `action` text COLLATE utf8_lithuanian_ci,
  `time` int(10) DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_naujienos`
--

DROP TABLE IF EXISTS `yn_naujienos`;
CREATE TABLE IF NOT EXISTS `yn_naujienos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `kategorija` int(2) NOT NULL DEFAULT '1',
  `naujiena` mediumtext COLLATE utf8_lithuanian_ci,
  `daugiau` text COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `data` int(10) DEFAULT NULL,
  `autorius` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `kom` set('taip','ne') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'taip',
  `rodoma` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  `sticky` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_naujienos`
--

INSERT INTO `yn_naujienos` (`id`, `pavadinimas`, `kategorija`, `naujiena`, `daugiau`, `lang`, `data`, `autorius`, `kom`, `rodoma`, `sticky`) VALUES
(1, 'Sveikiname įdiegus MightMedia TVS v.1.46', 0, 'Jūs sėkmingai įdiegėte <a target=\"_blank\" title=\"MightMedia TVS\" href=\"http://www.mightmedia.lt\">MightMedia TVS</a> . Jos autoriai <a target=\"_blank\" href=\"http://code.google.com/p/coders/\"><strong>CodeRS</strong></a> . Prašome nepasisavinti autorinių teisių, priešingu atveju jūs pažeisite GNU teises.', 'Kiekvienam puslapyje privalomas užrašas apačioje \"<a target=\"_blank\" href=\"http://www.mightmedia.lt/\">MightMedia</a>\" su nuoroda į <a target=\"_blank\" href=\"http://www.mightmedia.lt/\">http://www.mightmedia.lt</a>\r\n', 'lt', 1346622467, 'Sistema', 'taip', 'TAIP', 0);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_newsgetters`
--

DROP TABLE IF EXISTS `yn_newsgetters`;
CREATE TABLE IF NOT EXISTS `yn_newsgetters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(250) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_nuorodos`
--

DROP TABLE IF EXISTS `yn_nuorodos`;
CREATE TABLE IF NOT EXISTS `yn_nuorodos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cat` int(3) NOT NULL DEFAULT '1',
  `url` varchar(200) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'http://',
  `pavadinimas` varchar(200) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  `click` int(11) NOT NULL DEFAULT '0',
  `nick` int(5) DEFAULT NULL,
  `date` int(10) DEFAULT NULL,
  `apie` text COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `active` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  `balsai` int(255) NOT NULL DEFAULT '0',
  `balsavo` text COLLATE utf8_lithuanian_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_nustatymai`
--

DROP TABLE IF EXISTS `yn_nustatymai`;
CREATE TABLE IF NOT EXISTS `yn_nustatymai` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `val` text COLLATE utf8_lithuanian_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_nustatymai`
--

INSERT INTO `yn_nustatymai` (`id`, `key`, `val`) VALUES
(1, 'Pavadinimas', 'MightMedia TVS'),
(2, 'Apie', 'Trumpai apie svetainę'),
(3, 'Keywords', 'TVS, mightmedia, coders'),
(4, 'Copyright', '<a href=\"http://www.mightmedia.lt\" target=\"_blank\">MightMedia TVS</a>'),
(5, 'Palaikymas', '1'),
(6, 'Maintenance', '<p>Atsipra&scaron;ome<br /> Svetainė &scaron;iuo metu yra tvarkoma.<br /> Prisijungti gali tik administratoriai.</p>'),
(7, 'Chat_limit', '5'),
(8, 'News_limit', '5'),
(9, 'Stilius', 'synchronous'),
(10, 'Bandymai', '3'),
(11, 'fotodyd', '450'),
(12, 'minidyd', '150'),
(13, 'galbalsuot', '1'),
(14, 'fotoperpsl', '10'),
(15, 'galkom', '1'),
(16, 'pirminis', 'naujienos'),
(17, 'keshas', '0'),
(18, 'kmomentarai_sveciams', '0'),
(19, 'F_urls', '/'),
(20, 'galorder', 'data'),
(21, 'galorder_type', 'DESC'),
(22, 'Editor', 'tinymce'),
(23, 'hyphenator', '1'),
(24, 'Pastas', 'rimas9111@yahoo.com'),
(25, 'kalba', 'lt.php'),
(26, 'Admin_folder', 'tevai');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_page`
--

DROP TABLE IF EXISTS `yn_page`;
CREATE TABLE IF NOT EXISTS `yn_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pavadinimas` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `file` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `place` int(11) DEFAULT NULL,
  `show` enum('Y','N') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'Y',
  `teises` varchar(150) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  `parent` int(150) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_page`
--

INSERT INTO `yn_page` (`id`, `pavadinimas`, `lang`, `file`, `place`, `show`, `teises`, `parent`) VALUES
(1, 'Forumas', 'lt', 'frm.php', 3, 'Y', 'N;', 0),
(2, 'Naujienos', 'lt', 'naujienos.php', 1, 'Y', 'N;', 0),
(3, 'Apie', 'lt', 'apie.php', 5, 'Y', 'N;', 0),
(4, 'Registracija', 'lt', 'reg.php', 13, 'N', 'N;', 0),
(5, 'Slaptažodis', 'lt', 'slaptazodzio_priminimas.php', 12, 'N', 'N;', 0),
(6, 'Profilio redagavimas', 'lt', 'edit_user.php', 11, 'N', 'N;', 0),
(7, 'Paieška', 'lt', 'search.php', 6, 'Y', 'N;', 0),
(8, 'Kontaktai', 'lt', 'kontaktas.php', 6, 'Y', 'N;', 0),
(9, 'Prisijungę', 'lt', 'online.php', 7, 'Y', 'N;', 0),
(10, 'Archyvas', 'lt', 'deze.php', 8, 'N', 'N;', 0),
(11, 'Asmeniniai pranešimai', 'lt', 'pm.php', 0, 'N', 'N;', 0),
(12, 'Profilis', 'lt', 'view_user.php', 9, 'N', 'N;', 0),
(13, 'Nariai', 'lt', 'nariai.php', 10, 'Y', 'N;', 0),
(14, 'Galerija', 'lt', 'galerija.php', 4, 'Y', 'N;', 0),
(15, 'Straipsniai', 'lt', 'straipsnis.php', 2, 'Y', 'N;', 0);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_panel`
--

DROP TABLE IF EXISTS `yn_panel`;
CREATE TABLE IF NOT EXISTS `yn_panel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `panel` varchar(100) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `file` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `place` int(11) DEFAULT NULL,
  `align` enum('R','L','C') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'C',
  `rodyti` varchar(4) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `show` enum('Y','N') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'Y',
  `teises` varchar(150) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'N;',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_panel`
--

INSERT INTO `yn_panel` (`id`, `panel`, `lang`, `file`, `place`, `align`, `rodyti`, `show`, `teises`) VALUES
(1, 'Kas naujo?', 'lt', 'kas_naujo.php', 1, 'R', 'Taip', 'Y', 'N;'),
(2, 'Narys', 'lt', 'vartotojas.php', 2, 'R', 'Taip', 'Y', 'N;'),
(3, 'Rėksnių dėžė', 'lt', 'reksniu_deze.php', 3, 'R', 'Taip', 'Y', 'N;'),
(4, 'Kalendorius', 'lt', 'kalendorius.php', 0, 'L', 'Taip', 'Y', 'N;'),
(5, 'Meniu', 'lt', 'meniu.php', 1, 'L', 'Taip', 'Y', 'N;');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_poll_answers`
--

DROP TABLE IF EXISTS `yn_poll_answers`;
CREATE TABLE IF NOT EXISTS `yn_poll_answers` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `question_id` int(255) NOT NULL DEFAULT '0',
  `answer` text CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_poll_questions`
--

DROP TABLE IF EXISTS `yn_poll_questions`;
CREATE TABLE IF NOT EXISTS `yn_poll_questions` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `question` text CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  `radio` int(1) NOT NULL DEFAULT '0',
  `shown` int(1) NOT NULL DEFAULT '0',
  `only_guests` int(1) NOT NULL,
  `author_id` int(11) NOT NULL DEFAULT '1',
  `author_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'Admin',
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_poll_votes`
--

DROP TABLE IF EXISTS `yn_poll_votes`;
CREATE TABLE IF NOT EXISTS `yn_poll_votes` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `question_id` int(255) NOT NULL DEFAULT '0',
  `answer_id` int(255) NOT NULL DEFAULT '0',
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_private_msg`
--

DROP TABLE IF EXISTS `yn_private_msg`;
CREATE TABLE IF NOT EXISTS `yn_private_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `to` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `title` varchar(100) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '...',
  `msg` text COLLATE utf8_lithuanian_ci,
  `read` set('YES','NO') COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NO',
  `date` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_ratings`
--

DROP TABLE IF EXISTS `yn_ratings`;
CREATE TABLE IF NOT EXISTS `yn_ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_id` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `rating_num` int(11) DEFAULT NULL,
  `IP` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `psl` varchar(255) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_salis`
--

DROP TABLE IF EXISTS `yn_salis`;
CREATE TABLE IF NOT EXISTS `yn_salis` (
  `iso` char(2) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '',
  `name` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `printable_name` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `iso3` char(3) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`iso`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_salis`
--

INSERT INTO `yn_salis` (`iso`, `name`, `printable_name`, `iso3`, `numcode`) VALUES
('LT', 'LITHUANIA', 'Lithuania', 'LTU', 440),
('RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643),
('US', 'UNITED STATES', 'United States', 'USA', 840);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_siuntiniai`
--

DROP TABLE IF EXISTS `yn_siuntiniai`;
CREATE TABLE IF NOT EXISTS `yn_siuntiniai` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `paspaudimai` decimal(11,0) NOT NULL DEFAULT '0',
  `pavadinimas` char(100) COLLATE utf8_lithuanian_ci DEFAULT 'Be pavadinimo',
  `file` char(100) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'none.png',
  `foto` text COLLATE utf8_lithuanian_ci,
  `apie` longtext COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `autorius` int(6) NOT NULL DEFAULT '0',
  `data` int(10) DEFAULT NULL,
  `categorija` int(3) DEFAULT '1',
  `teises` varchar(2) COLLATE utf8_lithuanian_ci DEFAULT 'N;',
  `rodoma` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  PRIMARY KEY (`ID`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_straipsniai`
--

DROP TABLE IF EXISTS `yn_straipsniai`;
CREATE TABLE IF NOT EXISTS `yn_straipsniai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `pav` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `t_text` text COLLATE utf8_lithuanian_ci,
  `f_text` longtext COLLATE utf8_lithuanian_ci,
  `lang` varchar(3) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  `date` int(11) DEFAULT NULL,
  `autorius` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `autorius_id` int(11) DEFAULT NULL,
  `vote` int(11) DEFAULT NULL,
  `click` int(11) DEFAULT NULL,
  `kom` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'ne',
  `rodoma` varchar(4) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'NE',
  `kat` int(125) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_s_punktai`
--

DROP TABLE IF EXISTS `yn_s_punktai`;
CREATE TABLE IF NOT EXISTS `yn_s_punktai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pav` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_s_punktai`
--

INSERT INTO `yn_s_punktai` (`id`, `pav`, `sid`) VALUES
(1, 'Atviras Kodas', 1);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `yn_users`
--

DROP TABLE IF EXISTS `yn_users`;
CREATE TABLE IF NOT EXISTS `yn_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `nick` varchar(15) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `levelis` int(2) NOT NULL DEFAULT '3',
  `pass` varchar(32) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `slaptas` char(32) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `icq` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `msn` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `skype` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `yahoo` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `aim` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `url` varchar(50) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `salis` varchar(3) COLLATE utf8_lithuanian_ci DEFAULT 'LT',
  `miestas` varchar(20) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `vardas` varchar(15) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `pavarde` varchar(25) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `gim_data` date DEFAULT NULL,
  `parasas` text COLLATE utf8_lithuanian_ci,
  `forum_temos` int(11) NOT NULL DEFAULT '0',
  `forum_atsakyta` int(11) NOT NULL DEFAULT '0',
  `taskai` decimal(11,0) NOT NULL DEFAULT '0',
  `balsai` int(11) NOT NULL DEFAULT '0',
  `balsavo` text COLLATE utf8_lithuanian_ci,
  `pm_viso` int(11) NOT NULL DEFAULT '50',
  `reg_data` int(10) DEFAULT NULL,
  `login_data` int(10) DEFAULT NULL,
  `login_before` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nick` (`nick`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `yn_users`
--

INSERT INTO `yn_users` (`id`, `ip`, `nick`, `levelis`, `pass`, `email`, `slaptas`, `icq`, `msn`, `skype`, `yahoo`, `aim`, `url`, `salis`, `miestas`, `vardas`, `pavarde`, `gim_data`, `parasas`, `forum_temos`, `forum_atsakyta`, `taskai`, `balsai`, `balsavo`, `pm_viso`, `reg_data`, `login_data`, `login_before`) VALUES
(1, '::1', 'rimas', 1, 'cbb143e7fd549cc5480f6475d5c861de', 'rimas9111@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'LT', NULL, NULL, NULL, NULL, 'Svetainės administratorius', 0, 0, '0', 0, NULL, 500, 1540386774, NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
