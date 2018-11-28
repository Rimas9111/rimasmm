-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 2018 m. Lap 28 d. 13:51
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
-- Sukurta duomenų struktūra lentelei `2r_admin_chat`
--

DROP TABLE IF EXISTS `2r_admin_chat`;
CREATE TABLE IF NOT EXISTS `2r_admin_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin` varchar(25) COLLATE utf8_lithuanian_ci NOT NULL,
  `msg` longtext COLLATE utf8_lithuanian_ci NOT NULL,
  `date` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_chat_box`
--

DROP TABLE IF EXISTS `2r_chat_box`;
CREATE TABLE IF NOT EXISTS `2r_chat_box` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nikas` varchar(150) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `msg` varchar(250) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `niko_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `2r_chat_box`
--

INSERT INTO `2r_chat_box` (`id`, `nikas`, `msg`, `time`, `niko_id`) VALUES
(1, 'Sistema', 'Labas, Pasauli :)', '2012-09-09 13:48:22', 1);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_duk`
--

DROP TABLE IF EXISTS `2r_duk`;
CREATE TABLE IF NOT EXISTS `2r_duk` (
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
-- Sukurta duomenų struktūra lentelei `2r_d_forumai`
--

DROP TABLE IF EXISTS `2r_d_forumai`;
CREATE TABLE IF NOT EXISTS `2r_d_forumai` (
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
-- Sukurta duomenų struktūra lentelei `2r_d_straipsniai`
--

DROP TABLE IF EXISTS `2r_d_straipsniai`;
CREATE TABLE IF NOT EXISTS `2r_d_straipsniai` (
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
-- Sukurta duomenų struktūra lentelei `2r_d_temos`
--

DROP TABLE IF EXISTS `2r_d_temos`;
CREATE TABLE IF NOT EXISTS `2r_d_temos` (
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
-- Sukurta duomenų struktūra lentelei `2r_d_zinute`
--

DROP TABLE IF EXISTS `2r_d_zinute`;
CREATE TABLE IF NOT EXISTS `2r_d_zinute` (
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
-- Sukurta duomenų struktūra lentelei `2r_galerija`
--

DROP TABLE IF EXISTS `2r_galerija`;
CREATE TABLE IF NOT EXISTS `2r_galerija` (
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
-- Sukurta duomenų struktūra lentelei `2r_grupes`
--

DROP TABLE IF EXISTS `2r_grupes`;
CREATE TABLE IF NOT EXISTS `2r_grupes` (
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
-- Sukurta duomenų struktūra lentelei `2r_kas_prisijunges`
--

DROP TABLE IF EXISTS `2r_kas_prisijunges`;
CREATE TABLE IF NOT EXISTS `2r_kas_prisijunges` (
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
-- Sukurta duomenų kopija lentelei `2r_kas_prisijunges`
--

INSERT INTO `2r_kas_prisijunges` (`id`, `uid`, `timestamp`, `ip`, `file`, `user`, `agent`, `ref`, `clicks`) VALUES
(1, 'FzZmnskuQ5', 1542724647, '::1', '', 'rimas', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36', 'Direct Link', 1),
(1, 'EmQx8ou9MO', 1542724688, '::1', 'install/klaida.php', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36\'', 'http://localhost/rimasmm2/', 42),
(1, 'OnFjXvR0zH', 1542724686, '::1', '', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36\'', 'Direct Link', 12),
(1, 'RpgnBZbtiu', 1542810488, '::1', 'themes/material/plugins/bootstrap/css/bootstrap.css.map', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36\'', 'Direct Link', 21),
(1, '45mUyprsxq', 1542724639, '::1', '', 'rimas', 'User-Agent: \'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36\'', 'Direct Link', 53);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_knyga`
--

DROP TABLE IF EXISTS `2r_knyga`;
CREATE TABLE IF NOT EXISTS `2r_knyga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nikas` varchar(150) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `msg` varchar(250) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `msg` (`msg`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_kom`
--

DROP TABLE IF EXISTS `2r_kom`;
CREATE TABLE IF NOT EXISTS `2r_kom` (
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
-- Sukurta duomenų struktūra lentelei `2r_logai`
--

DROP TABLE IF EXISTS `2r_logai`;
CREATE TABLE IF NOT EXISTS `2r_logai` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `action` text COLLATE utf8_lithuanian_ci,
  `time` int(10) DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_naujienos`
--

DROP TABLE IF EXISTS `2r_naujienos`;
CREATE TABLE IF NOT EXISTS `2r_naujienos` (
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `2r_naujienos`
--

INSERT INTO `2r_naujienos` (`id`, `pavadinimas`, `kategorija`, `naujiena`, `daugiau`, `lang`, `data`, `autorius`, `kom`, `rodoma`, `sticky`) VALUES
(1, 'Sveikiname įdiegus MightMedia TVS v.1.46', 0, '<p>Jūs sėkmingai įdiegėte <a href=\"http://www.mightmedia.lt\" target=\"_blank\">MightMedia TVS</a> . Jos autoriai <a href=\"http://code.google.com/p/coders/\" target=\"_blank\"><strong>CodeRS</strong></a> . Pra&scaron;ome nepasisavinti autorinių teisių, prie&scaron;ingu atveju jūs pažeisite GNU teises. ', ' Kiekvienam puslapyje privalomas užra&scaron;as apačioje &quot;<a href=\"http://www.mightmedia.lt/\" target=\"_blank\">MightMedia</a>&quot; su nuoroda į <a href=\"http://www.mightmedia.lt/\" target=\"_blank\">http://www.mightmedia.lt</a></p>\r\n', 'lt', 1346622467, 'Sistema', 'taip', 'TAIP', 0),
(2, 'Naujiena', 0, '<p>Įžanga naujiena</p>\r\n', '', 'lt', 1542720737, 'rimas', 'taip', '1', 0);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_newsgetters`
--

DROP TABLE IF EXISTS `2r_newsgetters`;
CREATE TABLE IF NOT EXISTS `2r_newsgetters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(250) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_nuorodos`
--

DROP TABLE IF EXISTS `2r_nuorodos`;
CREATE TABLE IF NOT EXISTS `2r_nuorodos` (
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
-- Sukurta duomenų struktūra lentelei `2r_nustatymai`
--

DROP TABLE IF EXISTS `2r_nustatymai`;
CREATE TABLE IF NOT EXISTS `2r_nustatymai` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `val` text COLLATE utf8_lithuanian_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `2r_nustatymai`
--

INSERT INTO `2r_nustatymai` (`id`, `key`, `val`) VALUES
(1, 'Pavadinimas', 'MightMedia TVS'),
(2, 'Apie', 'Trumpai apie svetainę'),
(3, 'Keywords', 'TVS, mightmedia, coders'),
(4, 'Copyright', '<a href=\"http://www.mightmedia.lt\" target=\"_blank\">MightMedia TVS</a>'),
(5, 'Palaikymas', '1'),
(6, 'Maintenance', 'Atsiprašome<br /> Svetainė šiuo metu yra tvarkoma.<br /> Prisijungti gali tik administratoriai.'),
(7, 'Chat_limit', '5'),
(8, 'News_limit', '5'),
(9, 'Stilius', 'bootstrap'),
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
(22, 'Editor', 'ckeditor'),
(23, 'hyphenator', '1'),
(24, 'Pastas', 'rimas9111@yahoo.com'),
(25, 'kalba', 'lt.php'),
(26, 'Admin_folder', 'tevai');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_page`
--

DROP TABLE IF EXISTS `2r_page`;
CREATE TABLE IF NOT EXISTS `2r_page` (
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
-- Sukurta duomenų kopija lentelei `2r_page`
--

INSERT INTO `2r_page` (`id`, `pavadinimas`, `lang`, `file`, `place`, `show`, `teises`, `parent`) VALUES
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
-- Sukurta duomenų struktūra lentelei `2r_panel`
--

DROP TABLE IF EXISTS `2r_panel`;
CREATE TABLE IF NOT EXISTS `2r_panel` (
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
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `2r_panel`
--

INSERT INTO `2r_panel` (`id`, `panel`, `lang`, `file`, `place`, `align`, `rodyti`, `show`, `teises`) VALUES
(6, 'apklausa', 'lt', 'apklausa.php', 0, 'L', 'Ne', 'N', 'i:0;'),
(7, 'kalendorius', 'lt', 'kalendorius.php', 0, 'R', 'Ne', 'N', 'i:0;');

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_poll_answers`
--

DROP TABLE IF EXISTS `2r_poll_answers`;
CREATE TABLE IF NOT EXISTS `2r_poll_answers` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `question_id` int(255) NOT NULL DEFAULT '0',
  `answer` text CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL,
  `lang` varchar(3) CHARACTER SET utf8 COLLATE utf8_lithuanian_ci NOT NULL DEFAULT 'lt' COMMENT 'Language',
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_poll_questions`
--

DROP TABLE IF EXISTS `2r_poll_questions`;
CREATE TABLE IF NOT EXISTS `2r_poll_questions` (
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
-- Sukurta duomenų struktūra lentelei `2r_poll_votes`
--

DROP TABLE IF EXISTS `2r_poll_votes`;
CREATE TABLE IF NOT EXISTS `2r_poll_votes` (
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
-- Sukurta duomenų struktūra lentelei `2r_private_msg`
--

DROP TABLE IF EXISTS `2r_private_msg`;
CREATE TABLE IF NOT EXISTS `2r_private_msg` (
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
-- Sukurta duomenų struktūra lentelei `2r_ratings`
--

DROP TABLE IF EXISTS `2r_ratings`;
CREATE TABLE IF NOT EXISTS `2r_ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating_id` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `rating_num` int(11) DEFAULT NULL,
  `IP` varchar(45) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `psl` varchar(255) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_salis`
--

DROP TABLE IF EXISTS `2r_salis`;
CREATE TABLE IF NOT EXISTS `2r_salis` (
  `iso` char(2) COLLATE utf8_lithuanian_ci NOT NULL DEFAULT '',
  `name` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `printable_name` varchar(80) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `iso3` char(3) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`iso`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `2r_salis`
--

INSERT INTO `2r_salis` (`iso`, `name`, `printable_name`, `iso3`, `numcode`) VALUES
('LT', 'LITHUANIA', 'Lithuania', 'LTU', 440),
('RU', 'RUSSIAN FEDERATION', 'Russian Federation', 'RUS', 643),
('US', 'UNITED STATES', 'United States', 'USA', 840);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_siuntiniai`
--

DROP TABLE IF EXISTS `2r_siuntiniai`;
CREATE TABLE IF NOT EXISTS `2r_siuntiniai` (
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
-- Sukurta duomenų struktūra lentelei `2r_straipsniai`
--

DROP TABLE IF EXISTS `2r_straipsniai`;
CREATE TABLE IF NOT EXISTS `2r_straipsniai` (
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
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `2r_straipsniai`
--

INSERT INTO `2r_straipsniai` (`id`, `pid`, `pav`, `t_text`, `f_text`, `lang`, `date`, `autorius`, `autorius_id`, `vote`, `click`, `kom`, `rodoma`, `kat`) VALUES
(1, NULL, 'Straipsnis', '<p><strong>Straipsnis</strong>&nbsp;&ndash; analitinis&nbsp;<a href=\"https://lt.wikipedia.org/wiki/%C5%BDurnalistika\">žurnalistikos</a>&nbsp;žanras, kuriam būdinga rei&scaron;kinių, problemų analizė, nuoseklus, loginis minties plėtojimas, visuomenės gyvenimo dėsningumų atskleidimas. Kartais atvirai i&scaron;sakoma autoriaus nuomonė. Daromos įtikinamos i&scaron;vados. Ra&scaron;ant i&scaron;skiriami trys etapai: temos pasirinkimas, temos pateikimas ir literatūrinis apdorojimas.</p>\r\n', '', 'lt', 1542719821, 'rimas', 1, NULL, NULL, 'taip', 'TAIP', 0);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_s_punktai`
--

DROP TABLE IF EXISTS `2r_s_punktai`;
CREATE TABLE IF NOT EXISTS `2r_s_punktai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pav` varchar(255) COLLATE utf8_lithuanian_ci DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Sukurta duomenų kopija lentelei `2r_s_punktai`
--

INSERT INTO `2r_s_punktai` (`id`, `pav`, `sid`) VALUES
(1, 'Atviras Kodas', 1);

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `2r_users`
--

DROP TABLE IF EXISTS `2r_users`;
CREATE TABLE IF NOT EXISTS `2r_users` (
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
-- Sukurta duomenų kopija lentelei `2r_users`
--

INSERT INTO `2r_users` (`id`, `ip`, `nick`, `levelis`, `pass`, `email`, `slaptas`, `icq`, `msn`, `skype`, `yahoo`, `aim`, `url`, `salis`, `miestas`, `vardas`, `pavarde`, `gim_data`, `parasas`, `forum_temos`, `forum_atsakyta`, `taskai`, `balsai`, `balsavo`, `pm_viso`, `reg_data`, `login_data`, `login_before`) VALUES
(1, '::1', 'rimas', 1, 'cbb143e7fd549cc5480f6475d5c861de', 'rimas9111@yahoo.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'LT', NULL, NULL, NULL, NULL, 'Svetainės administratorius', 0, 0, '0', 0, NULL, 500, 1541512347, NULL, NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
