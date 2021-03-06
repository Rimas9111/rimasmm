<?php

/**
 * @Projektas : MightMedia TVS
 * @Puslapis  : www.coders.lt
 * @$Author$
 * @copyright CodeRS ©2008
 * @license   GNU General Public License v2
 * @$Revision$
 * @$Date$
 * @var array $conf
 * @var array $lang
 * */

// Patikrinimui ar nesikreipiama tiesiogiai
if ( basename( $_SERVER['PHP_SELF'] ) == 'funkcijos.php' ) {
	ban( getip(), $lang['system']['forhacking'] );
}
// Nustatom maksimalu leidziama keliamu failu dydi
$max_upload   = (int)( ini_get( 'upload_max_filesize' ) );
$max_post     = (int)( ini_get( 'post_max_size' ) );
$memory_limit = (int)( ini_get( 'memory_limit' ) );
$upload_mb    = min( $max_upload, $max_post, $memory_limit );
define( "MFDYDIS", $upload_mb * 1024 * 1024 );
//ini_set("memory_limit", MFDYDIS);
define( "OK", TRUE );
define( 'ROOTAS', dirname( realpath( __FILE__ ) ) . '/../' );
//Isvalom POST'us nuo xss
if ( !empty( $_POST ) ) {
	include_once ( ROOTAS . 'priedai/safe_html.php' );
	foreach ( $_POST as $key => $value ) {
		if ( !is_array( $value ) ) {
			$post[$key] = safe_html( $value );
		} else {
			$post[$key] = $value;
		}
	}
	unset( $_POST );
	$_POST = $post;
}


/**
 * Adresa verčiam į masyvą
 *
 * @param string $params
 *
 * @return array
 */
if(! function_exists('url_arr')) {
	function url_arr($params) {

		global $conf;

		$str2 = array();
		
		if ( !isset( $params ) ) {
			$params = $_SERVER['QUERY_STRING'];
		}

		if ( strrchr( $params, '&' ) ) {
			$params = explode( "&", $params );
		} //Jeigu tai paprastas GET
		else {
			$params = explode( ( ( empty( $conf['F_urls'] ) || $conf['F_urls'] == '0' ) ? ';' : $conf['F_urls'] ), $params );
		}

		if ( isset( $params ) && is_array( $params ) && count( $params ) > 0 ) {
			foreach ( $params as $key => $value ) {
				if ( strrchr( $value, '=' ) ) {
					$str1 = explode( "=", $value );
				} else {
					$str1 = explode( ",", $value );
				}
				if ( isset( $str1[1] ) ) {
					if ( preg_match( '%/\*\*/|SERVER|SELECT|UNION|DELETE|UPDATE|INSERT%i', $str1[1] ) ) {
						echo "BAN";
						ban();
					}
					$str2[$str1[0]] = $str1[1];
				}
			}
		}

		return $str2;
	}
}

/**
 * Tikrina ar kintamasis teigiamas skaičius
 *
 * @param int $value
 *
 * @return int 1 arba NULL
 */
if(! function_exists('isNum')) {
	function isNum( $value ) {

		return @preg_match( "/^[0-9]+$/", $value ); //}
	}
}

/**
 * Sutvarko SQL užklausą
 *
 * @param string $sql
 *
 * @return string escaped
 */
if(! function_exists('escape')) {
	function escape( $sql ) {
		global $prisijungimas_prie_mysql;
		// Stripslashes
		if ( get_magic_quotes_gpc() ) {
			$sql = stripslashes( $sql );
		}
		// Jei ne skaičius
		if ( !isNum( $sql ) || $sql[0] == '0' ) {
			if ( !isNum( $sql ) ) {
				$sql = "'" . @mysqli_real_escape_string( $prisijungimas_prie_mysql, $sql ) . "'";
			}
		}

		return $sql;
	}
}

/**
 * Gražina kalbą
 *
 * @global array $conf
 * @return string
 */
if(! function_exists('lang')) {
	function lang() {

		if ( empty( $_SESSION[SLAPTAS]['lang'] ) ) {
			global $conf;
			$_SESSION[SLAPTAS]['lang'] = basename( $conf['kalba'], '.php' );
		}

		return $_SESSION[SLAPTAS]['lang'];
	}
}

/**
 * Sutvarkom tekstą saugiam atvaizdavimui
 * šito reikia jei nori gražinti į input'ą informaciją.
 * dažnai tai būna su visokiais \\\'? ir pan
 *
 * @param string $s
 *
 * @return string formated
 */
if(! function_exists('input')) {
	function input( $s ) {

		$s = htmlspecialchars( $s, ENT_QUOTES, "UTF-8" );

		return $s;
	}
}

/**
 * MySQL užklausoms
 *
 * @param string $query
 * @param int    $lifetime
 *
 * @return array
 */
if(! function_exists('mysql_query1')) {
	function mysql_query1( $query, $lifetime = 0 ) {

		global $mysql_num, $prisijungimas_prie_mysql, $conf;

		// Sugeneruojam kešo pavadinimą
		$keshas = realpath( dirname( __file__ ) . '/..' ) . '/sandeliukas/' . md5( $query ) . '.php'; //kešo failas
		$return = array();

		if ( !empty( $conf['keshas'] ) && $lifetime > 0 && !in_array( strtolower( substr( $query, 0, 6 ) ), array(
			'delete',
			'insert',
			'update'
		) )
		) {

			// Tikrinam ar kešavimas įjungtas ir ar kešas egzistuoja
			if ( is_file( $keshas ) && filemtime( $keshas ) > $_SERVER['REQUEST_TIME'] - $lifetime ) {
				// Užkraunam kešą
				include ( $keshas );
			} else {

				// Įrašom į kešo failą
				$mysql_num++;

				$sql = mysqli_query( $prisijungimas_prie_mysql, $query ); // or die(mysqli_error($prisijungimas_prie_mysql));
				if ( mysqli_error($prisijungimas_prie_mysql) ) {
					mysqli_query( $prisijungimas_prie_mysql, "INSERT INTO `" . LENTELES_PRIESAGA . "logai` (`action` ,`time` ,`ip`) VALUES (" . escape( "MySql error:  " . mysqli_error($prisijungimas_prie_mysql) . " query: " . $query ) . ",'" . time() . "', '" . escape( getip() ) . "');" );
				}
				// Jeigu užklausoje nurodyta, kad reikia tik vieno įrašo tai nesudarom masyvo.
				if ( substr( strtolower( $query ), -7 ) == 'limit 1' ) {
					$return = mysqli_fetch_assoc( $sql );
				} else {
					while ( $row = mysqli_fetch_assoc( $sql ) ) {
						$return[] = $row;
					}
				}

				$fh = fopen( $keshas, 'wb' ) or die( "Išvalyk <b>/sandeliukas</b> bylą" );

				// Reikia užrakinti failą, kad du kartus neįrašytų
				if ( flock( $fh, LOCK_EX ) ) { // užrakinam
					fwrite( $fh, '<?php $return = ' . var_export( $return, TRUE ) . '; ?>' );
					flock( $fh, LOCK_UN ); // atrakinam
				} else {
					echo "Negaliu užrakinti failo !";
				}

				// Baigiam failo įrašymą
				fclose( $fh );
			}

			return $return;
		} else {
			$mysql_num++;

			$sql = mysqli_query( $prisijungimas_prie_mysql, $query ); // or die(mysqli_error($prisijungimas_prie_mysql));
			if ( mysqli_error($prisijungimas_prie_mysql) ) {
				mysqli_query( $prisijungimas_prie_mysql, "INSERT INTO `" . LENTELES_PRIESAGA . "logai` (`action` ,`time` ,`ip`) VALUES (" . escape( "MySql error:  " . mysqli_error($prisijungimas_prie_mysql) . " query: " . $query ) . ",'" . time() . "', '" . escape( getip() ) . "');" );
			}
			if ( in_array( strtolower( substr( $query, 0, 6 ) ), array( 'delete', 'insert', 'update' ) ) ) {
				if ( in_array( strtolower( substr( $query, 0, 6 ) ), array( 'insert' ) ) ) {
					$return = mysqli_insert_id( $prisijungimas_prie_mysql );
				} else {
					$return = mysqli_affected_rows( $prisijungimas_prie_mysql );
				}
			} else {
				if ( substr( strtolower( $query ), -7 ) == 'limit 1' ) {
					$return = mysqli_fetch_assoc( $sql );
				} else {
					while ( $row = mysqli_fetch_assoc( $sql ) ) {
						$return[] = $row;
					}
				}
			}

		}

		return $return;
	}
}

/**
 * Slaptažodžio kodavimas
 *
 * @param $pass
 *
 * @return string
 */
if(! function_exists('koduoju')) {
	function koduoju( $pass ) {

		return md5( sha1( md5( $pass ) ) );
	}
}

/**
 * Meta tagai ir kita
 */
if(! function_exists('header_info')) {
	function header_info() {

		global $conf, $page_pavadinimas, $lang;
		echo '
		<base href="' . adresas() . '"></base>
		<meta name="generator" content="MightMedia TVS" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="content-language" content="' . lang() . '" />
		<meta name="description" content="' . input( strip_tags( $conf['Pavadinimas'] ) . ' - ' . trimlink( trim( str_replace( "\n\r", "", strip_tags( $conf['Apie'] ) ) ), 120 ) ) . '" />
		<meta name="keywords" content="' . input( strip_tags( $conf['Keywords'] ) ) . '" />
		<meta name="author" content="' . input( strip_tags( $conf['Copyright'] ) ) . '" />
		<link rel="stylesheet" type="text/css" href="stiliai/system.css" />
		<link rel="stylesheet" type="text/css" href="stiliai/rating.css" />
		<link rel="stylesheet" type="text/css" href="stiliai/' . input( strip_tags( $conf['Stilius'] ) ) . '/default.css" />
		<!-- favicon -->
		<link rel="apple-touch-icon" sizes="180x180" href="/images/favicon/apple-touch-icon.png">
		<link rel="icon" type="image/png" sizes="32x32" href="/images/favicon/favicon-32x32.png">
		<link rel="icon" type="image/png" sizes="16x16" href="/images/favicon/favicon-16x16.png">
		<link rel="manifest" href="/images/favicon/site.webmanifest">
		<link rel="mask-icon" href="/images/favicon/safari-pinned-tab.svg" color="#db7300">
		<meta name="msapplication-TileColor" content="#ff440e">
		<meta name="theme-color" content="#ffffff">
		
		<link rel="icon" href="stiliai/' . input( strip_tags( $conf['Stilius'] ) ) . '/favicon.ico" type="image/x-icon" />

		' . ( isset( $conf['puslapiai']['rss.php'] ) ? '<link rel="alternate" type="application/rss+xml" title="' . input( strip_tags( $conf['Pavadinimas'] ) ) . '" href="rss.php" />' : '' ) . '
		' . ( isset( $conf['puslapiai']['galerija.php'] ) ? '<link rel="alternate" href="gallery.php" type="application/rss+xml" title="" id="gallery" />' : '' ) . '
		
		<title>' . input( strip_tags( $conf['Pavadinimas'] ) . ' - ' . $page_pavadinimas ) . '</title>
		<script type="text/javascript" src="javascript/jquery/jquery-1.3.2.min.js"></script>
		<script type="text/javascript" src="javascript/pagrindinis.js"></script>
		<!-- Add jQuery library -->
		<script type="text/javascript" src="javascript/jquery/fancybox/jquery-1.7.2.min.js"></script>
		<!-- Add mousewheel plugin (this is optional) -->
		<script type="text/javascript" src="javascript/jquery/fancybox/jquery.mousewheel-3.0.6.pack.js"></script>
		<!-- Add fancyBox main JS and CSS files -->
		<script type="text/javascript" src="javascript/jquery/fancybox/jquery.fancybox.js?v=2.0.6"></script>
		<link rel="stylesheet" type="text/css" href="stiliai/jquery.fancybox.css?v=2.0.6" media="screen" />
		<script type="text/javascript">
			$(document).ready(function() {
				$(".fancybox").fancybox();
				// Remove padding, set opening and closing animations, close if clicked and disable overlay
				$(".fancybox-effects-d").fancybox({
					padding: 0,
					openEffect : "elastic",
					openSpeed  : 150,
					closeEffect : "elastic",
					closeSpeed  : 150,
					closeClick : true,
					helpers : {
						overlay : {
							css : {
								"background" : "#fff"
							}
						}
					}
				});
			});
		</script>
		<script type="text/javascript" src="javascript/jquery/rating.js"></script>
		<script type="text/javascript" src="javascript/jquery/tooltip.js"></script>
		<script type="text/javascript" src="javascript/jquery/jquery.hint.js"></script>


		<!--[if lt IE 7]>
		<script type="text/javascript" src="javascript/jquery/jquery.pngFix.pack.js"></script>
		<script type="text/javascript">$(document).ready(function(){$(document).pngFix();});</script>
		<script src="http://ie7-js.googlecode.com/svn/version/2.0(beta3)/IE7.js" type="text/javascript"></script>
		<![endif]-->
		
		<script type="text/javascript">
		//Active mygtukas
		$(function(){
		var path = location.pathname.substring(1);
		if ( path )
			$(\'ul li a[href$="\' + path + \'"]\').attr(\'class\', \'active\');
		});

		</script>';
		//<script type="text/javascript" src="javascript/jquery/jquery.tablesorter.js"></script>
	}
}

/**
 * Title gairės papildymui
 *
 * @param $add string
 */
if(! function_exists('addtotitle')) {
function addtotitle($add) {

	//$add = input($add);
	echo <<<HTML
		<script type="text/javascript">
		var cur_title = new String(document.title);
      document.title = cur_title+" - {$add}";
    </script>
HTML;
}
}

if(! function_exists('getUserMail')) {
	function getUserMail($id) {
		$sql = mysql_query1( "SELECT * FROM `" . LENTELES_PRIESAGA . "users` WHERE `id`=" . escape($id) . " LIMIT 1", 86400 );
	
		return $sql;
	}
}

/**
 * Grąžina vartotojo avatarą
 *
 * @param $mail string emeilas
 * @param $size int
 *
 * @return string formated html
 */
if(! function_exists('avatar')) {
	function avatar($mail, $size = 80) {
		global $conf;
		if ( file_exists( ROOT . 'images/avatars/' . md5( $mail ) . '.jpeg' ) ) {
			$result = '<img src="' . ROOT . 'images/avatars/' . md5( $mail ) . '.jpeg?' . time() . '" width="' . $size . '" height="' . $size . '" alt="avataras" />';
		} else {
			$avatardir = (
			file_exists( ROOT . 'stiliai/' . $conf['Stilius'] . '/no_avatar.png' )
				? 'stiliai/' . $conf['Stilius'] . '/no_avatar.png'
				: 'images/avatars/no_avatar.png'
			);
			$result    = '<img src="//www.gravatar.com/avatar/' . md5( strtolower( $mail ) ) . '?s=' . htmlentities( $size . '&r=any&default=' . urlencode( adresas() . $avatardir ) . '&time=' . time() ) . '"  width="' . $size . '" alt="avataras" />';
		}

		return $result;
	}
}
/**
 * Sutvarkom failo pavadinimą
 *
 * @param string $name
 *
 * @return string formated
 */
if(! function_exists('nice_name')) {
	function nice_name($name) {

		$name = ucfirst_utf8( $name );
		$name = basename( $name, '.php' );
		$name = str_replace( "_", " ", $name );

		return $name;
	}
}

/**
 * Patikrina ar vartotojas turi "admin" teises.
 * grąžina true arba false
 *
 * @param  string $failas
 *
 * @global array  $_SESSION
 * @return bool <type>
 */
if(! function_exists('ar_admin')) {
	function ar_admin($failas) {

		global $_SESSION;

		if ( ( is_array( unserialize( $_SESSION[SLAPTAS]['mod'] ) ) && in_array( $failas, unserialize( $_SESSION[SLAPTAS]['mod'] ) ) ) || $_SESSION[SLAPTAS]['level'] == 1 ) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}
/**
 * Pirma raidė didžioji (utf-8)
 *
 * @param string $str
 *
 * @return string
 */
if(! function_exists('ucfirst_utf8')) {
	function ucfirst_utf8($str) {

		if ( mb_check_encoding( $str, 'UTF-8' ) ) {
			$first = mb_substr( mb_strtoupper( $str, "utf-8" ), 0, 1, 'utf-8' );

			return $first . mb_substr( mb_strtolower( $str, "utf-8" ), 1, mb_strlen( $str ), 'utf-8' );
		} else {
			return $str;
		}
	}
}
/**
 * Sutrumpina stringa iki nurodyto ilgio (saugiai utf-8)
 *
 * @param string $str
 * @param int    $start ilgis
 *
 * @return string
 */
if(! function_exists('utf8_substr')) {
	function utf8_substr( $str, $start ) {

		preg_match_all( "/./u", $str, $ar );

		if ( func_num_args() >= 3 ) {
			$end = func_get_arg( 2 );

			return join( "", array_slice( $ar[0], $start, $end ) );
		} else {
			return join( "", array_slice( $ar[0], $start ) );
		}
	}
}

/**
 * Svetainės adresui gauti
 *
 * @return string
 */
if(! function_exists('adresas')) {
	function adresas() {
		if ( isset( $_SERVER['HTTP_HOST'] ) ) {
			$adresas = isset( $_SERVER['HTTPS'] ) && strtolower( $_SERVER['HTTPS'] ) !== 'off' ? 'https' : 'http';
			$adresas .= '://' . $_SERVER['HTTP_HOST'];
			$adresas .= str_replace( basename( $_SERVER['SCRIPT_NAME'] ), '', $_SERVER['SCRIPT_NAME'] );
		} else {
			$adresas = 'http://localhost/';
		}

		return $adresas;
	}
}
/**
 * Patikrina ar puslapis egzistuoja ir ar vartotojas turi teise ji matyti bei grazinam puslapio ID
 *
 * @param string $puslapis
 * @param bool   $extra
 *
 * @return bool|int
 */
if(! function_exists('puslapis')) {
	function puslapis($puslapis, $extra = false ) {

		global $conf;
		$teises = @unserialize( $conf['puslapiai'][$puslapis]['teises'] );
	
		//todo: optimize after v2
		$isFile 	= is_file($puslapis) || is_file(dirname( __FILE__ ) . '/../puslapiai/' . $puslapis);
		$pageName 	= basename($puslapis);

		if (isset($conf['puslapiai'][$pageName]['id']) && ! empty( $conf['puslapiai'][$pageName]['id']) && $isFile) {

			if ( $_SESSION[SLAPTAS]['level'] == 1 || ( is_array( $teises ) && in_array( $_SESSION[SLAPTAS]['level'], $teises ) ) || empty( $teises ) ) {

				if ($extra && isset($conf['puslapiai'][$pageName][$extra]) ) {
					return $conf['puslapiai'][$pageName][$extra];
				} else { //Jei reikalinga kita informacija apie puslapi - grazinam ja.
					return (int)$conf['puslapiai'][$pageName]['id'];
				}
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
}
/**
 * Gražina true arba false (nustatom vartotojo teises)
 *
 * @param array $mas serialize
 * @param int   $lvl
 *
 * @return true/false
 */
if(! function_exists('teises')) {
	function teises($mas, $lvl) {

		if ( !empty( $mas ) && !is_array( $mas ) ) {
			$mas = @unserialize( $mas );
		}
		if ( $lvl == 1 || ( is_array( $mas ) && in_array( $lvl, $mas ) ) || empty( $mas ) ) {
			return TRUE;
		} else {
			return FALSE;
		}
	}
}
/**
 * Uždrausti IP ant serverio
 *
 * @param string $ipas
 * @param string $kodel
 */
if(! function_exists('ban')) {
function ban( $ipas = '', $kodel = '' ) {

	global $lang, $_SERVER, $ip, $forwarded, $remoteaddress;
	if ( empty( $kodel ) ) {
		$kodel = $lang['system']['forhacking'] . ' - ' . input( str_replace( "\n", "", $_SERVER['QUERY_STRING'] ) );
	}
	if ( empty( $ipas ) ) {
		$ipas = getip();
	}
	$atidaryti = fopen( ROOTAS . ".htaccess", "a" );
	fwrite( $atidaryti, '# ' . $kodel . " \nSetEnvIf Remote_Addr \"^{$ipas}$\" draudziam\n" );
	fclose( $atidaryti );
	//@chmod(".htaccess", 0777);

	$forwarded     = ( isset( $forwarded ) ? $forwarded : 'N/A' );
	$remoteaddress = ( isset( $remoteaddress ) ? $remoteaddress : 'N/A' );
	$ip            = ( isset( $ip ) ? $ip : getip() );
	$referer       = ( isset( $_SERVER["HTTP_REFERER"] ) ? $_SERVER["HTTP_REFERER"] : 'N/A' );

	$message = <<< HTML
  FROM:{$referer}
  REQ:{$_SERVER['REQUEST_METHOD']}
  FILE:{$_SERVER['SCRIPT_FILENAME']}
  QUERY:{$_SERVER['QUERY_STRING']}
  IP:{$ip} - Forwarded = {$forwarded} - Remoteaddress = {$remoteaddress}
HTML;

	if ( $kodel == $lang['system']['forhacking'] ) {
		die( "<center><h1>{$lang['system']['nohacking']}!</h1><font color='red'><b>" . $kodel . " - {$lang['system']['forbidden']}<blink>!</blink></b></font><hr/></center>" );
	}
}
}

/**
 * Nurodytai eilutei iš failo trinti
 *
 * @global string $lang
 *
 * @param string  $fileName
 * @param int     $lineNum
 */
if(! function_exists('delLineFromFile')) {
	function delLineFromFile( $fileName, $lineNum ) {

		global $lang;
		// check the file exists
		if ( !is_writable( $fileName ) ) {
			// print an error
			klaida( $lang['system']['error'], $lang['system']['error'] );
			// exit the function
			exit;
		} else {
			// read the file into an array
			$arr = file( $fileName );
		}

		// the line to delete is the line number minus 1, because arrays begin at zero
		$lineToDelete = $lineNum - 1;

		// check if the line to delete is greater than the length of the file
		if ( $lineToDelete > sizeof( $arr ) ) {
			// print an error
			klaida( $lang['system']['error'], "{$lang['system']['error']} <b>[$lineNum]</b>." );
			// exit the function
			exit;
		}

		//remove the line
		unset( $arr["$lineToDelete"] );

		// open the file for reading
		if ( !$fp = fopen( $fileName, 'w+' ) ) {
			// print an error
			klaida( $lang['system']['error'], "{$lang['system']['error']} ($fileName)" );
			// exit the function
			exit;
		}

		// if $fp is valid
		if ( $fp ) {
			// write the array to the file
			foreach ( $arr as $line ) {
				fwrite( $fp, $line );
			}

			// close the file
			fclose( $fp );
		}

		//msg($lang['system']['done'],"IP {$lang['admin']['unbaned']}.");
	}
}

/**
 * Adreso apsauga
 *
 * @param string $url
 *
 * @return string
 */
if(! function_exists('cleanurl')) {
	function cleanurl($url) {

		$bad_entities  = array( '"', "'", "<", ">", "(", ")", '\\' );
		$safe_entities = array( "", "", "", "", "", "", "" );
		$url           = str_replace( $bad_entities, $safe_entities, $url );

		return $url;
	}
}

/**
 * Grąžiname failo plėtinį
 *
 * @param        $name
 * @param string $ext
 *
 * @return string
 */
if(! function_exists('strip_ext')) {
	function strip_ext( $name, $ext = '' ) {

		$ext = utf8_substr( $name, strlen( $ext ) - 4, 4 );
		if ( strpos( $ext, '.' ) === FALSE ) { // jeigu tai folderis
			return "    "; // grąžinam truputį tarpų kad rusiavimas butu ciki, susirūšiuoja - folderiai viršuje
		}

		return $ext; // jei tai failas grąžinam jo plėtinį
	}
}

// grąžina failus iš nurodytos direktorijos ir sukiša Ä¯ masyvą
if(! function_exists('getFiles')) {
	function getFiles($path, $denny = null, $defaultDir = null) {
		global $lang;

		if(empty($denny)) {
			$denny = '.htaccess|index.php|index.html|index.htm|index.php3|conf.php';
		}

		$denny     	= explode( '|', $denny );
		$path      	= urldecode( $path );
		$defaultDir = ! empty($defaultDir) ? $defaultDir : $defaultDir;
		$files     	= array();
		$fileNames 	= array();
		$i         	= 0;

		if ( is_dir( $path ) ) {
			if ( $dh = opendir( $path ) ) {
				while ( ( $file = readdir( $dh ) ) !== FALSE ) {
					if ( !in_array( $file, $denny ) ) {
						if ( ( $file == "." ) || ( $file == ".." ) ) {
							continue;
						}
						$fullpath = $path . "/" . $file;
						//$fkey = strtolower($file);
						$fkey = $file;
						while ( array_key_exists( $fkey, $fileNames ) ) {
							$fkey .= " ";
						}

						$a = stat($fullpath);
			
						$files[$fkey]['size'] = $a['size'];

						if ( $a['size'] == 0 ) {
							$files[$fkey]['sizetext'] = "-";
						} else if ( $a['size'] > 1024 && $a['size'] <= 1024 * 1024 ) {
							$files[$fkey]['sizetext'] = ( ceil( $a['size'] / 1024 * 100 ) / 100 ) . " K";
						} //patvarkom failo dydziu atvaizdavima
						else if ( $a['size'] > 1024 * 1024 ) {
							$files[$fkey]['sizetext'] = ( ceil( $a['size'] / ( 1024 * 1024 ) * 100 ) / 100 ) . " Mb";
						} else {
							$files[$fkey]['sizetext'] = $a['size'] . " bytes";
						}

						$files[$fkey]['name'] = $defaultDir . $file;
						$e                    = strip_ext( $file ); // $e failo pletinys - pvz: .gif
						$files[$fkey]['type'] = filetype( $fullpath ); // failo tipas, dir, file ir pan
						$k                    = $e . $file; // kad butu lengvau rusiuoti;
						$fileNames[$i++]      = $k;
					}
				}
				closedir( $dh );
			} else {
				die( klaida( $lang['system']['error'], "{$lang['system']['cantread']}:  $path" ) );
			}
		} else {
			die( klaida( $lang['system']['error'], "{$lang['system']['notdir']}:  $path" ) );
		}
		sort( $fileNames, SORT_STRING ); // surusiuojam
		$sortedFiles = array();
		$i           = 0;
		foreach ( $fileNames as $f ) {
			$f = utf8_substr( $f, 4, strlen( $f ) - 4 ); //sutvarko failo pletinius
			if ( $files[$f]['name'] != '' ) {
				$sortedFiles[$i++] = $files[$f];
			}
		}

		return $sortedFiles;
	}
}

//Grazina direktorijų sarašą
if(! function_exists('getDirs')) {
	function getDirs( $dir, $skip = '' ) {

		if ( $handle = opendir( $dir ) ) {
			while ( FALSE !== ( $file = readdir( $handle ) ) ) {
				if ( $file != "." && $file != ".." && $file != ".svn" && is_dir( $dir . $file ) && ( is_array( $skip ) ? !in_array( $file, $skip ) : TRUE ) && $skip != $file ) {
					$return[$file] = $file;
				}
			}
			closedir( $handle );
		}

		return $return;
	}
}


/**
 * HOOKS
 */
require 'class.hooks.php';

if(! function_exists('doAction')) {
	function doAction($tag, $value)
	{
		$hooks = Hooks::getInstance();

		return $hooks->do_action($tag, $value);
	}
}

if(! function_exists('addAction')) {
	function addAction($tag, $callback)
	{
		$hooks = Hooks::getInstance();

		return $hooks->add_action($tag, $callback);
	}
}

if(! function_exists('applyFilters')) {
	function applyFilters($tag, $value)
	{
		$hooks = Hooks::getInstance();

		return $hooks->apply_filters($tag, $value);
	}
}

// Tvarkom $_SERVER globalus.
$_SERVER['PHP_SELF']     = cleanurl( $_SERVER['PHP_SELF'] );
$_SERVER['QUERY_STRING'] = isset( $_SERVER['QUERY_STRING'] ) ? cleanurl( $_SERVER['QUERY_STRING'] ) : "";
$_SERVER['REQUEST_URI']  = isset( $_SERVER['REQUEST_URI'] ) ? cleanurl( $_SERVER['REQUEST_URI'] ) : "";
$PHP_SELF                = cleanurl( $_SERVER['PHP_SELF'] );

/**
 * Vartotojų lygiai
 *
 * @return array
 */
//TODO: rewrite this shit
unset($sql, $row);
if (basename($_SERVER['PHP_SELF']) != 'upgrade.php' && basename($_SERVER['PHP_SELF']) != 'setup.php') {
	$sql = mysql_query1("SELECT * FROM `" . LENTELES_PRIESAGA . "grupes` WHERE `kieno` = 'vartotojai' AND `lang`=" . escape(lang()) . " ORDER BY `id` DESC");

	if (count($sql) > 0) {
		foreach ($sql as $row) {
			$levels[(int)$row['id']] = array(
				'pavadinimas' => $row['pavadinimas'],
				'aprasymas'   => $row['aprasymas'],
				'pav'         => input( $row['pav'] )
			);
		}
	}
	$levels[1] = array(
		'pavadinimas' => $lang['system']['admin'],
		'aprasymas'   => $lang['system']['admin'],
		'pav'         => 'admin.png'
	);
	$levels[2] = array(
		'pavadinimas' => $lang['system']['user'],
		'aprasymas'   => $lang['system']['user'],
		'pav'         => 'user.png'
	);

	$conf['level'] = $levels;
	unset($levels, $sql, $row);

	/**
	 * Gaunam visus puslapius ir suformuojam masyvą
	 */
	$sql = mysql_query1( "SELECT * FROM `" . LENTELES_PRIESAGA . "page` WHERE `lang`=" . escape( lang() ) . " ORDER BY `place` ASC", 120 );
	foreach ($sql as $row) {
		$keyName 	= basename($row['file']);
		$niceName 	= (isset( $lang['pages'][$keyName]) ? $lang['pages'][$keyName] : nice_name($keyName));
		
		$conf['puslapiai'][$keyName] = [
			'id'          	=> $row['id'],
			'pavadinimas' 	=> input($row['pavadinimas']),
			'file'        	=> input($row['file']),
			'place'       	=> (int)$row['place'],
			'show'        	=> $row['show'],
			'teises'      	=> $row['teises'],
		];

		$conf['titles'][$row['id']]											= $niceName;
		$conf['titles_id'][strtolower(str_replace( ' ', '_', $niceName))] 	= $row['id'];
	}
	// Nieko geresnio nesugalvojau
	$dir                        = explode( '/', dirname( $_SERVER['PHP_SELF'] ) );
	$conf['titles']['999']      = $dir[count( $dir ) - 1] . '/admin';
	$conf['titles_id']['admin'] = 999;
	// Sutvarkom nuorodas
	if ( isset( $_SERVER['QUERY_STRING'] ) && !empty( $_SERVER['QUERY_STRING'] ) ) {
		$_GET = url_arr( cleanurl( $_SERVER['QUERY_STRING'] ) );
		if ( isset( $_GET['id'] ) ) {
			$element    = strtolower( $_GET['id'] );
			$_GET['id'] = ( ( isset( $conf['titles_id'][$element] ) && $conf['F_urls'] != '0' ) ? $conf['titles_id'][$element] : $_GET['id'] );
		}
		$url = $_GET;
	} else {
		$url = array();
	}
}

/////////////////////////////////////////////////////////
//////// URL APDOROJIMUI
////////////////////////////////////////////////////////

/**
 * "Friendly urls" apdorojimas
 *
 * @param $str
 *
 * @return string
 */
if(! function_exists('url')) {
	function url( $str ) {

		global $conf;

		if ( substr( $str, 0, 1 ) == '?' ) {
			$linkai    = explode( ';', $str );
			$start     = explode( ',', $linkai[0] );
			$linkai[0] = '';
			if ( !empty( $conf['F_urls'] ) && $conf['F_urls'] != '0' ) {

				// Žodinis linkas
				$url_title = !empty( $conf['titles'][$start[1]] ) ? $conf['titles'][$start[1]] : '';

				// Išmetam tarpus
				$url_title = str_replace( ' ', '_', $url_title );

				// Atskiriam atskirus getus pasirinktu simboliu
				$return = adresas() . ROOT . $url_title . implode( ( $conf['F_urls'] != '0' ? $conf['F_urls'] : ';' ), $linkai );
			} else {

				$return = adresas() . ( substr( $str, 4, 3 ) == '999' && ( empty( $conf['F_urls'] ) || $conf['F_urls'] == '0' ) ? 'main.php' : ( substr( $str, 0, 1 ) != '?' ? '' : ROOT ) ) . $str;
			}
		} else {

			$g = '?';
			foreach ( $_GET as $k => $v ) {

				$g .= "{$k},{$v};";
			}
			$return = url( $g . $str );
		}

		return $return;
	}
}
/**
 * Vartotojui atvaizduoti
 *
 * @param string $user    nickas
 * @param int    $id
 * @param int    $level   levelis
 * @param bool   $extra
 *
 * @return string
 */
if(! function_exists('user')) {
	function user( $user, $id = 0, $level = 0, $extra = FALSE ) {

		global $lang, $conf;
		if ( $user == '' || $user == $lang['system']['guest'] ) {

			return $lang['system']['guest'];
		} else {
			if ( isset( $conf['puslapiai']['pm.php'] ) && $id != 0 && isset( $_SESSION[SLAPTAS]['id'] ) && $id != $_SESSION[SLAPTAS]['id'] ) {
				$pm = "<a href=\"" . url( "?id," . $conf['puslapiai']['pm.php']['id'] . ";n,1;u," . str_replace( "=", "", base64_encode( $user ) ) ) . "\"><img src=\"" . ROOT . "images/pm/mail.png\"  style=\"vertical-align:middle\" alt=\"pm\" border=\"0\" /></a>";
			} else {
				$pm = '';
			}
			if ( isset( $conf['level'][$level]['pav'] ) ) {
				$img = '<img src="' . ROOT . 'images/icons/' . $conf['level'][$level]['pav'] . '" border="0" class="middle" alt="" /> ';
			} else {
				$img = '';
			}
			if ( isset( $conf['puslapiai']['view_user.php']['id'] ) && $id != 0 ) {
				return $img . '<a href="' . url( '?id,' . $conf['puslapiai']['view_user.php']['id'] . ';' . $user ) . '" title="' . input( $user ) . " " . $extra . '">' . trimlink( $user, 10 ) . '</a> ' . $pm;
			} else {
				return '<div style="display:inline;" title="' . input( $user ) . '" "' . $extra . '">' . $img . ' ' . trimlink( $user, 10 ) . ' ' . $pm . '</div>';
			}
		}
	}
}

/**
 * Sandeliukui valyti
 *
 * @param string $query
 */
if(! function_exists('delete_cache')) {
	function delete_cache($key) {

		$fileName = realpath(dirname(__FILE__) . '/..') . '/sandeliukas/' . md5($key) . '.php';
		if (is_file($fileName)) {
			unlink($fileName);
		}
	}
}

if(! function_exists('cachePutData')) {
	function cachePutData($key, $data, $lifeTime = []) {
		$path = realpath(dirname(__FILE__) . '/..') . '/sandeliukas/';
		$fileName = md5($key) . '.php';
		$filePath = $path . $fileName;
		
		if (is_file($filePath)) {
			unlink($filePath);
		}

		$fh = fopen($filePath, 'wb') or die("Išvalyk <b>/sandeliukas</b> bylą");

		//insert data life time
		$data['lifetime'] = $lifeTime;

		if(! is_string($data)) {
			$data = json_encode($data, JSON_UNESCAPED_UNICODE|JSON_PRETTY_PRINT);
		}

		// Reikia užrakinti failą, kad du kartus neįrašytų
		if (flock($fh, LOCK_EX)) { // užrakinam
			fwrite($fh, $data);
			flock($fh, LOCK_UN); // atrakinam
		} else {
			echo "Negaliu užrakinti failo !";
		}

		// Baigiam failo įrašymą
		fclose($fh);
	}
}

if(! function_exists('cacheGetData')) {
	function cacheGetData($key, $array = true) {
		$path = realpath(dirname(__FILE__) . '/..') . '/sandeliukas/';
		$fileName = $path . md5($key) . '.php';
		
		if (is_file($fileName)) {
			// Užkraunam kešą
			$content 	= file_get_contents($fileName);
			$data 		= json_decode($content, $array);

			if(filemtime($fileName) > time() - $data['lifetime']) {
				unset($data['lifetime']); //we don't need this in data after check

				return $data;
			}
		}

		return false;
	}
}

/**
 * Nuskaitom turinį iš adreso
 *
 * @param string $url
 *
 * @return string
 */
if(! function_exists('http_get')) {
	function http_get($url) {

		$request = fopen( $url, "rb" );
		$result  = "";
		while ( !feof( $request ) ) {
			$result .= fread( $request, 8192 );
		}
		fclose( $request );

		return $result;
	}
}
/**
 * Gaunam informaciją iš XML
 *
 * @param string $xml
 * @param string $tag
 *
 * @return string
 */
if(! function_exists('get_tag_contents')) {
	function get_tag_contents( $xml, $tag ) {

		$result = "";
		$s_tag  = "<$tag>";
		$s_offs = strpos( $xml, $s_tag );

		// Ieškome pabaigos gairės
		if ( $s_offs ) {
			$e_tag  = "</$tag>";
			$e_offs = strpos( $xml, $e_tag, $s_offs );

			// Jei radome gairės pradžią ir pabaigą ištraukiame turinį
			if ( $e_offs ) {
				$result = substr( $xml, $s_offs + strlen( $s_tag ), $e_offs - $s_offs - strlen( $e_tag ) + 1 );
			}
		}

		return $result;
	}
}
/**
 * Suskaičiuojam kiek nurodytoje lentelėje yra įrašų
 *
 * @param string $table
 * @param string $where
 * @param string $as
 *
 * @return int
 */
if(! function_exists('kiek')) {
	function kiek( $table, $where = '', $as = "viso" ) {

		$viso = mysql_query1( "SELECT count(*) AS `$as` FROM `" . LENTELES_PRIESAGA . $table . "` " . $where . " limit 1", 60 );

		return ( isset( $viso[$as] ) && $viso[$as] > 0 ? (int)$viso[$as] : (int)0 );
	}
}

/**
 * Puslapiavimui generuoti
 *
 * @param string   $start puslapis
 * @param int      $count limitas
 * @param int      $total viso
 * @param int      $range ruožas
 *
 * @return string
 */
if(! function_exists('puslapiai')) {
	function puslapiai( $start, $count, $total, $range = 0 ) {

		$res    = "";
		$pg_cnt = ceil( $total / $count );

		if ( $pg_cnt > 1 ) {
			$idx_back = $start - $count;
			$idx_next = $start + $count;
			$cur_page = ceil( ( $start + 1 ) / $count );
			$res .= "";
			$res .= "<div class=\"puslapiavimas\">\n";

			if ( $idx_back >= 0 ) {

				if ( $cur_page > ( $range + 1 ) ) {
					$res .= "<a href='" . url( "p,0" ) . "'><span class=\"nuoroda\">««</span></a>\n";
				}
				$res .= "<a href='" . url( "p,{$idx_back}" ) . "'><span class=\"nuoroda\">«</span></a>\n";
			}
			$idx_fst = max( $cur_page - $range, 1 );
			$idx_lst = min( $cur_page + $range, $pg_cnt );

			if ( $range == 0 ) {
				$idx_fst = 1;
				$idx_lst = $pg_cnt;
			}
			for ( $i = $idx_fst; $i <= $idx_lst; $i++ ) {
				$offset_page = ( $i - 1 ) * $count;

				if ( $i == $cur_page ) {
					$res .= "<span class=\"paspaustas\">{$i}</span>\n";
				} else {
					$res .= "<a href='" . url( "p,{$offset_page}" ) . "'><span class=\"nuoroda\">{$i}</span></a>\n";
				}
			}
			if ( $idx_next < $total ) {
				$res .= "<a href='" . url( "p,{$idx_next}" ) . "'><span class=\"nuoroda\">»</span></a>\n";

				if ( $cur_page < ( $pg_cnt - $range ) ) {
					$res .= "<a href='" . url( "p," . ( $pg_cnt - 1 ) * $count . "" ) . "'><span class=\"nuoroda\">»»</span></a>\n";
				}
			}
			$res .= "</div>\n";
		}

		return $res;
	}
}

/**
 * Grąžina lankytojo IP
 *
 * @return string
 */
if(! function_exists('getip')) {
	function getip() {

		$ip = (( !empty($_SERVER["HTTP_X_FORWARDED_FOR"]) )
			? $_SERVER["HTTP_X_FORWARDED_FOR"]
			: $_SERVER["REMOTE_ADDR"]
		);
		if (strstr( $ip, "," )) {
			$ip = explode( ',', $ip );
			$ip = reset($ip);
			$ip = trim($ip );
		}
		return $ip;
	}
}
/**
 * Atsitiktinės frazės generatorius
 *
 * @param int $i
 *
 * @return string
 */
if(! function_exists('random_name')) {
	function random_name( $i = 10 ) {

		$chars = "abcdefghijkmnopqrstuvwxyz023456789ABCDEFGHJKLMNOPQRSTUVWXYZ";
		srand( (double)microtime() * 1000000 );
		$name = '';

		while ( $i > 0 ) {
			$num  = rand() % strlen($chars);
			$tmp  = substr( $chars, $num, 1 );
			$name = $name . $tmp;
			$i--;
		}

		return $name;
	}
}

/**
 * Seo url TODO
 */
if(! function_exists('seo_url')) {
	function seo_url( $url, $id ) {

		// Sušveplinam
		$url = iconv( 'UTF-8', 'US-ASCII//TRANSLIT', $url );
		// Nuimam tarpus pradžioje bei pabaigoje
		$url = trim( $url );
		// Neaiškius simbolius pakeičiam brūkšniukais
		$url = preg_replace( '/[^A-z0-9-]/', '_', $url );
		// Išvalom besikartojančius brūkšniukus
		$url = preg_replace( '/-+/', "-", $url );
		// Verčiam viską į mažasias raides
		$url = strtolower( $url );

		return $url . $id;
	}
}
/**
 * Naršyklių peradresavimas
 *
 * @param string $location
 * @param string $type
 * @param array $sessions | null
 */
if(! function_exists('redirect')) {
	function redirect($location, $type = "header", $sessions = null) {

		if(! empty($sessions)) {
			$_SESSION[SLAPTAS]['redirect'] = $sessions;
		}

		if ( $type == "header" ) {
			header( "Location: " . $location );
			exit;
		} elseif ( $type == "meta" ) {
			echo "<meta http-equiv='Refresh' content='1;url=$location'>";
		} else {
			echo "<script type='text/javascript'>document.location.href='" . $location . "'</script>\n";
		}
	}
}
/**
 * Grąžina amžių, nurodžius datą
 *
 * @param string $data
 *
 * @return int
 */
if(! function_exists('amzius')) {
	function amzius( $data ) {

		if ( !isset( $data ) || $data == '' || $data == '0000-00-00' ) {
			return "- ";
		} else {
			$data   = explode( "-", $data );
			$amzius = time() - mktime( 0, 0, 0, $data['1'], $data['2'], $data['0'] );
			$amzius = date( "Y", $amzius ) - 1970;

			return $amzius;
		}
	}
}
/**
 * Užkoduoja problematiškus simbolius
 *
 * @param      $text
 * @param bool $striptags
 *
 * @return mixed
 * @url http://blog.bitflux.ch/wiki/
 */
if(! function_exists('descript')) {
	function descript( $text, $striptags = TRUE ) {

		$search   = array( "40", "41", "58", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122", "239" );
		$replace  = array( "(", ")", ":", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "" );
		$entities = count( $search );
		for ( $i = 0; $i < $entities; $i++ ) {
			$text = preg_replace( "#(&\#)(0*" . $search[$i] . "+);*#si", $replace[$i], $text );
		}
		$text = str_replace( chr( 32 ) . chr( 32 ), "&nbsp;", $text );
		$text = str_replace( chr( 9 ), "&nbsp; &nbsp; &nbsp; &nbsp;", $text );
		// the following is based on code from bitflux (http://blog.bitflux.ch/wiki/)
		// Kill hexadecimal characters completely
		$text = preg_replace( '#(&\#x)([0-9A-F]+);*#si', "", $text );
		// remove any attribute starting with "on" or xmlns
		$text = preg_replace( '#(<[^>]+[\\"\'\s])(onmouseover|onmousedown|onmouseup|onmouseout|onmousemove|onclick|ondblclick|onload|xmlns)[^>]*>#iU', ">", $text );
		// remove javascript: and vbscript: protocol
		$text = preg_replace( '#([a-z]*)=([\`\'\"]*)script:#iU', '$1=$2nojscript...', $text );
		$text = preg_replace( '#([a-z]*)=([\`\'\"]*)javascript:#iU', '$1=$2nojavascript...', $text );
		$text = preg_replace( '#([a-z]*)=([\'\"]*)vbscript:#iU', '$1=$2novbscript...', $text );
		//<span style="width: expression(alert('Ping!'));"></span> (only affects ie...)
		$text = preg_replace( '#(<[^>]+)style=([\`\'\"]*).*expression\([^>]*>#iU', "$1>", $text );
		$text = preg_replace( '#(<[^>]+)style=([\`\'\"]*).*behaviour\([^>]*>#iU', "$1>", $text );
		if ( $striptags ) {
			do {
				$thistext = $text;
				$text     = preg_replace( '#</*(applet|meta|xml|blink|link|style|script|iframe|frame|frameset|ilayer|layer|bgsound|title|base)[^>]*>#i', "", $text );
			} while ( $thistext != $text );
		}

		return $text;
	}
}
/**
 * Patikrina ar tai tikrai paveiksliukas
 *
 * @param string $img
 *
 * @return string
 */
if(! function_exists('isImage1')) {
	function isImage1( $img ) {

		//$img = $matches[1].str_replace(array("?","&","="),"",$matches[3]).$matches[4];
		//$img = $matches[1].$matches[3].$matches[4];
		if ( @getimagesize( $img ) ) {
			$res = "<img src='" . $img . "' style='border:0px;'>";
		} else {
			$res = "[img]" . $img . "[/img]";
		}

		return $res;
	}
}
/**
 * Sulaužo žodį jei jis per ilgas
 * laužo net jei žodis turi tarpus
 *
 * @param string  $text tekstas
 * @param int     $chars ilgis
 *
 * @return string
 */
if(! function_exists('wrap1')) {
	function wrap1( $text, $chars = 25 ) {

		$text = wordwrap( $text, $chars, "<br />\n", 1 );

		return $text;
	}
}
/**
 * Sulaužo per ilgus žodžius
 * tik jei jis yra be tarpų
 *
 * @param string  $string tekstas
 * @param int     $width ilgis
 * @param string  $break simbolis
 *
 * @return string
 */
if(! function_exists('wrap')) {
	function wrap( $string, $width, $break = "\n" ) {

		//Jei tvs be javascript naudosi, atkomentuok
		//$string = preg_replace('/([^\s]{' . $width . '})/i', "$1$break", $string);
		return $string;
	}
}

//tikrinam ar kintamasis sveikas skaicius ar normalus zodis
if(! function_exists('tikrinam')) {
	function tikrinam( $txt ) {

		return ( preg_match( "/^[0-9a-zA-Z]+$/", $txt ) );
	}
}
//bano galiojimo laikas. Rodo data iki kada +30 dienu
//echo "Galioja iki: ".galioja('12', '19', '2007');
//grazina: Galioja iki: 2008-01-17
if(! function_exists('galioja')) {
	function galioja( $menuo, $diena, $metai, $kiek_galioja = 30 ) {

		$nuo  = (int)( mktime( 0, 0, 0, $menuo, $diena, $metai ) - time( void ) / 86400 );
		$liko = $nuo + ( $kiek_galioja * 24 * 60 * 60 );

		return date( 'Y-m-d', $liko );
	}
}

if(! function_exists('liko')) {
	function liko( $diena, $menuo, $metai ) {

		$until      = mktime( 0, 0, 0, $menuo, $diena, $metai );
		$now        = time();
		$difference = $until - $now;
		$days       = floor( $difference / 86400 );
		$difference = $difference - ( $days * 86400 );
		$hours      = floor( $difference / 3600 );
		$difference = $difference - ( $hours * 3600 );
		$minutes    = floor( $difference / 60 );
		$difference = $difference - ( $minutes * 60 );
		$seconds    = $difference;

		return (int)$days + 1;
	}
}

//sutvarko url iki linko
if(! function_exists('linkas')) {
	function linkas( $str ) {
		$str = strtolower( strip_tags( $str ) );

		//return preg_replace_callback("#([\n ])([a-z]+?)://([a-z0-9\-\.,\?!%\*_\#:;~\\&$@\/=\+]+)#si", "linkai", $str);
		return preg_replace( "`((http)+(s)?:(//)|(www\.))((\w|\.|\-|_)+)(/)?(\S+)?`i", "<a href=\"\\0\" title=\"\\0\" target=\"_blank\" class=\"link\" >\\5\\6</a>", $str );
	}
}

/**
 * Suapavalinimas
 *
 * @param     $sk
 * @param int $kiek
 *
 * @return float
 */
if(! function_exists('apvalinti')) {
	function apvalinti( $sk, $kiek = 2 ) {

		if ( $kiek < 0 ) {
			$kiek = 0;
		}
		$mult = pow( 10, $kiek );

		return ceil( $sk * $mult ) / $mult;
	}
}

/**
 * Grąžina paveiksliuką "new" jei elementas naujas
 *
 * @param      $data
 * @param null $nick
 *
 * @return string
 */
if(! function_exists('naujas')) {
	function naujas( $data, $nick = NULL ) {

		global $lang;
		if ( isset( $_SESSION[SLAPTAS]['lankesi'] ) ) {
			return ( ( $data > $_SESSION[SLAPTAS]['lankesi'] ) ? '<img src="' . ROOT . 'images/icons/new.png" onload="$(this).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100);" alt="New" border="0" style="vertical-align: middle;" title="' . $lang['system']['new'] . '" />' : '' );
		} else {
			return '';
		}
	}
}
/**
 * Gražina išsireiškimą nusakantį įvykio laiką
 *
 * @param $ts string
 *
 * @return string
 */
if(! function_exists('kada')) {
	function kada( $ts ) {

		global $lang;
		if ( $ts == '' || $ts == "0000-00-00 00:00:00" ) {
			return '';
		}
		$mins  = floor( ( strtotime( date( "Y-m-d H:i:s" ) ) - strtotime( $ts ) ) / 60 );
		$hours = floor( $mins / 60 );
		$mins -= $hours * 60;
		$days = floor( $hours / 24 );
		$hours -= $days * 24;
		$weeks = floor( $days / 7 );
		$days -= $weeks * 7;
		$month = floor( $weeks / 4 );
		$days -= $month * 4;
		$year = floor( $month / 12 );
		$days -= $year * 12;
		if ( $year ) {
			return ( $year > 1 ? sprintf( $lang['system']['years'], $year ) : sprintf( $lang['system']['year'], $year ) );
		}
		if ( $month ) {
			return ( $month > 1 ? sprintf( $lang['system']['months'], $month ) : sprintf( $lang['system']['month'], $month ) );
		}
		if ( $weeks ) {
			return ( $weeks > 1 ? sprintf( $lang['system']['weeks'], $weeks ) : sprintf( $lang['system']['week'], $weeks ) );
		}
		if ( $days ) {
			return ( $days > 1 ? sprintf( $lang['system']['days'], $days ) : sprintf( $lang['system']['day'], $days ) );
		}
		if ( $hours ) {
			return ( $hours > 1 ? sprintf( $lang['system']['hours'], $hours ) : sprintf( $lang['system']['hour'], $hours ) );
		}
		if ( $mins ) {
			return ( $mins > 1 ? sprintf( $lang['system']['minutes'], $mins ) : sprintf( $lang['system']['minute'], $mins ) );
		}

		//return "&lt; 1 {$lang['system']['minute']} {$lang['system']['ago']}";
		return sprintf( $lang['system']['minute'], '&lt; 1' );
	}
}

/**
 * Verčiam baitus į žmonių kalbą
 *
 * @param     $size
 * @param int $digits
 *
 * @return string
 */
if(! function_exists('baitai')) {
	function baitai( $size, $digits = 2 ) {

		$kb = 1024;
		$mb = 1024 * $kb;
		$gb = 1024 * $mb;
		$tb = 1024 * $gb;
		if ( $size == 0 ) {
			return " Nulis";
		} elseif ( $size < $kb ) {
			return $size . " Baitai";
		} elseif ( $size < $mb ) {
			return round( $size / $kb, $digits ) . " Kb";
		} elseif ( $size < $gb ) {
			return round( $size / $mb, $digits ) . " Mb";
		} elseif ( $size < $tb ) {
			return round( $size / $gb, $digits ) . " Gb";
		} else {
			return round( $size / $tb, $digits ) . " Tb";
		}
	}
}
/**
 * Trim a line of text to a preferred length
 *
 * @param $text
 * @param $length
 *
 * @return mixed
 */
if(! function_exists('trimlink')) {
	function trimlink( $text, $length ) {

		$dec  = array( "\"", "'", "\\", '\"', "\'", "<", ">" );
		$enc  = array( "&quot;", "&#39;", "&#92;", "&quot;", "&#39;", "&lt;", "&gt;" );
		$text = str_replace( $enc, $dec, $text );
		if ( strlen( strip_tags( $text ) ) > $length ) {
			$text = utf8_substr( $text, 0, ( $length - 3 ) ) . "...";
		}
		$text = str_replace( $dec, $enc, $text );

		return $text;
	}
}

//Paskaiciuojam procentus
if(! function_exists('procentai')) {
	function procentai( $reikia, $yra, $zenklas = FALSE ) {

		$return = (int)round( ( 100 * $yra ) / $reikia );
		if ( $return > 100 && $zenklas ) {
			$return = "<img src='" . ROOT . "images/icons/accept.png' class='middle' alt='100%' title='100%' borders='0' />";
		} elseif ( $return > 0 && $zenklas ) {
			$return = "<img src='" . ROOT . "images/icons/cross.png' class='middle' alt='" . $return . "%' title='" . $reikia . "/" . $yra . " - " . $return . "%' borders='0' />";
		}

		return $return;
	}
}

//Insert SQL - supaprastina duomenų Ä¯terpimą, paduodam lentlÄ—s pavadinimą ir kitu argumentu asociatyvų masyvą
if(! function_exists('insert')) {
	function insert( $table, $array ) {

		return 'INSERT INTO `' . LENTELES_PRIESAGA . $table . '` (' . implode( ', ', array_keys( $array ) ) . ') VALUES (' . implode( ', ', array_map( 'escape', $array ) ) . ')';
	}
}

if(! function_exists('pic')) {
	function pic( $off_site, $size = FALSE, $url = 'images/nuorodu/', $sub = 'url' ) {

		$pic_name = md5( $off_site );
		$pic_name = $url . $sub . "_" . $pic_name . ".png";
		if ( !file_exists( $pic_name ) || ( time() - filemtime( $pic_name ) ) > 86400 ) { //9 valandos senumo
			clearstatcache();
			@unlink( $pic_name );
			if ( pic1( $off_site, $size, $url, $sub ) ) {
				return $pic_name;
			} else {
				clearstatcache();

				return $url . "noimage.jpg";
			}
		} else {
			clearstatcache();

			return $pic_name;
		}
	}
}

if(! function_exists('pic1')) {
	function pic1( $off_site, $size = FALSE, $url = 'images/nuorodu/', $sub = 'url' ) {

		$fp  = @fopen( $off_site, 'rb' );
		$buf = '';
		if ( $fp ) {
			stream_set_blocking( $fp, TRUE );
			stream_set_timeout( $fp, 2 );
			while ( !feof( $fp ) ) {
				$buf .= fgets( $fp, 4096 );
			}

			$data = $buf;

			//set new height
			$src = @imagecreatefromstring( $data );
			imagealphablending( $src, TRUE );

			if ( empty( $src ) ) {
				return FALSE;
			}
			if ( $size ) {
				$width        = @imagesx( $src );
				$height       = @imagesy( $src );
				$aspect_ratio = $width / $height;

				//start resizing
				if ( $width <= $size ) {
					$new_w = $width;
					$new_h = $height;
				} else {
					$new_w = $size;
					$new_h = @abs( $new_w / $aspect_ratio );
				}

				$img = @imagecreatetruecolor( $new_w, $new_h );

				//output image
				@imagecopyresampled( $img, $src, 0, 0, 0, 0, $new_w, $new_h, $width, $height );
			}
			$file = $url . $sub . "_" . md5( $off_site ) . ".png";

			// determine image type and send it to the browser
			imagesavealpha( $src, TRUE );
			@imagepng( ( !$img ? $src : $img ), $file );
			@imagedestroy( $img );
			unset( $buf );
			sleep( 2 );
		}
	}
}

/**
 * Sulietuvinimas mėnesio
 * echo menesis(12); //Gruodis
 *
 * @param INT $men
 *
 * @return string
 */
if(! function_exists('menesis')) {
	function menesis( $men ) {

		if ( is_int( $men ) ) {
			$ieskom = array( "12", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11" );
		} else {
			$ieskom = array(
				"December",
				"January",
				"February",
				"March",
				"April",
				"May",
				"June",
				"July",
				"August",
				"September",
				"October",
				"November"
			);
		}
		$keiciam = array(
			"Gruodis",
			"Sausis",
			"Vasaris",
			"Kovas",
			"Balandis",
			"Gegužė",
			"Birželis",
			"Liepa",
			"Rugpjūtis",
			"Rugsėjis",
			"Spalis",
			"Lapkritis"
		);

		return str_replace( $ieskom, $keiciam, $men );
	}
}

/**
 * El pašto validacija
 *
 * @param $email
 *
 * @return bool
 */
if(! function_exists('check_email')) {
	function check_email( $email ) {

		return preg_match( "/^([_a-zA-Z0-9-+]+)(\.[_a-zA-Z0-9-]+)*@([a-zA-Z0-9-]+)(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,6})$/", $email ) ? TRUE : FALSE;
	}
}

if(! function_exists('admin_login')) {
	function admin_login() {

		global $_SERVER, $admin_name, $admin_pass, $lang;
		if ( @$_SERVER['PHP_AUTH_USER'] != $admin_name || @$_SERVER['PHP_AUTH_PW'] != $admin_pass ) {
			header( "WWW-Authenticate: Basic realm='AdminAccess'" );
			header( "HTTP/1.0 401 Unauthorized" );
			header( "status: 401 Unauthorized" );
			mysql_query1( "INSERT INTO `" . LENTELES_PRIESAGA . "logai` (`action` ,`time` ,`ip`) VALUES (" . escape( "ADMIN pultas - Klaida loginantis: User: " . ( isset( $_SERVER['PHP_AUTH_USER'] ) ? $_SERVER['PHP_AUTH_USER'] : "N/A" ) . " Pass: " . ( isset( $_SERVER['PHP_AUTH_PW'] ) ? $_SERVER['PHP_AUTH_PW'] : "N/A" ) ) . ",NOW(), '" . escape( getip() ) . "');" );
			die( klaida( "{$lang['system']['forbidden']}!", "{$lang['system']['notadmin']}" ) );
		} else {
			unset( $admin_name, $admin_pass );

			return TRUE;
		}
	}
}

if(! function_exists('get_user_os')) {
	function get_user_os() {

		global $global_info, $HTTP_USER_AGENT, $HTTP_SERVER_VARS;
		if ( !empty( $global_info['user_os'] ) ) {
			return $global_info['user_os'];
		}
		if ( !empty( $HTTP_SERVER_VARS['HTTP_USER_AGENT'] ) ) {
			$HTTP_USER_AGENT = $HTTP_SERVER_VARS['HTTP_USER_AGENT'];
		} elseif ( getenv( "HTTP_USER_AGENT" ) ) {
			$HTTP_USER_AGENT = getenv( "HTTP_USER_AGENT" );
		} elseif ( empty( $HTTP_USER_AGENT ) ) {
			$HTTP_USER_AGENT = "";
		}
		if ( strpos( $HTTP_USER_AGENT, 'Windows' ) ) {
			$global_info['user_os'] = "WIN";
		} elseif ( strpos( $HTTP_USER_AGENT, 'Macintosh' ) ) {
			$global_info['user_os'] = "MAC";
		} elseif ( strpos( $HTTP_USER_AGENT, "Linux" ) ) {
			$global_info['user_os'] = "Linux";
		} else {
			$global_info['user_os'] = "OTHER";
		}

		return $global_info['user_os'];
	}
}

/**
 * Gražina patvirtinimo kodą
 *
 * @return HTML
 */
if(! function_exists('kodas')) {
function kodas() {

	global $lang;
	$return = <<<HTML
	<script type="text/javascript">
	var \$human = document.createElement('img');
	\$human.setAttribute('src','priedai/human.php');
	\$human.setAttribute('style','cursor: pointer');
	\$human.setAttribute('title','{$lang['system']['refresh']}');
	\$human.setAttribute('onclick','this.src="priedai/human.php?"+Math.random();');
	\$human.setAttribute('alt','code');
	\$human.setAttribute('id','captcha');

	$('#captcha_content').html(\$human);
	</script>
HTML;

	return "<p id='captcha_content'></p>$return";
}
}

/** Gražina versijos numerį */
if(! function_exists('versija')) {
	function versija() {
		$scid  	= file( ROOTAS . '/version.txt' );
		$values = array_values($scid);
		$scid 	= trim(array_shift($values));

		return apvalinti( ( intval( $scid ) / 5000 ) + '1.28', 2 );
	}
}

// compress HTML BLOGAS DUOMENŲ SUSPAUDIMO BŪDAS
//ob_start('sendcompressedcontent');

/**
 * Editorius skirtas vaizdžiai redaguoti html
 *
 * @example echo editorius('tiny_mce','mini');
 * @example echo editorius('spaw','standartinis',array('Glaustai'=>'Glaustai','Placiau'=>'Plačiau'),array('Glaustai'=>'Naujiena glaustai','Placiau'=>'Naujiena plačiau'));
 *
 * @param string $tipas
 * @param string $dydis
 * @param string $id
 * @param string $value
 *
 * @return string
 */
if(! function_exists('editorius')) {
function editorius( $tipas = 'rte', $dydis = 'standartinis', $id = FALSE, $value = '' ) {

	global $conf;
	if ( !$id ) {
		$id = md5( uniqid() );
	}

	$arr = array();
	if ( is_array( $id ) ) {
		foreach ( $id as $key => $val ) {
			$arr[$val] = "'$key'";
		}
		$areos = implode( $arr, "," );
	} else {
		$areos = "'$id'";
	}
	$root   = ROOT;
	$return = <<<HTML
<script type="text/javascript" src="{$root}javascript/htmlarea/nicedit/nicEdit.js"></script>
HTML;

	if ( is_array( $id ) ) {
		foreach ( $id as $key => $val ) {

			$return .= <<< HTML
			
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true, iconsPath : '{$root}javascript/htmlarea/nicedit/nicEditorIcons.gif', width: '100%'}).panelInstance('{$key}');
});
</script>
<textarea class="editorius" id="{$key}" name="{$key}">{$value[$key]}</textarea>
HTML;
		}
	} else {
		$return .= <<< HTML
<script type="text/javascript">
bkLib.onDomLoaded(function() {
	new nicEditor({fullPanel : true, iconsPath : '{$root}javascript/htmlarea/nicedit/nicEditorIcons.gif', width: '100%'}).panelInstance('{$id}');
});
</script>

<textarea class="editorius" id="{$id}" name="{$id}">{$value}</textarea>
HTML;
	}


	return $return;
}
}

if ( !function_exists( 'scandir' ) ) {
	function scandir( $directory, $sorting_order = 0 ) {

		$dh = opendir( $directory );
		while ( FALSE !== ( $filename = readdir( $dh ) ) ) {
			$files[] = $filename;
		}
		if ( $sorting_order == 0 ) {
			sort( $files );
		} else {
			rsort( $files );
		}

		return ( $files );
	}
}

if(! function_exists('build_menu')) {
	function build_menu( $data, $id = 0, $active_class = 'active' ) {

		if ( !empty( $data ) ) {
			$re = "";
			foreach ( $data[$id] as $row ) {
				if ( isset( $data[$row['id']] ) ) {
					$re .= "\n\t\t<li " . ( ( isset( $_GET['id'] ) && $_GET['id'] == $row['id'] ) ? 'class="' . $active_class . '"' : '' ) . "><a href=\"" . url( "?id,{$row['id']}" ) . "\">" . $row['pavadinimas'] . "</a>\n<ul>\n\t";
					$re .= build_menu( $data, $row['id'], $active_class );
					$re .= "\t</ul>\n\t</li>";
				} else {
					$re .= "\n\t\t<li " . ( ( isset( $_GET['id'] ) && $_GET['id'] == $row['id'] ) ? 'class="' . $active_class . '"' : '' ) . "><a href=\"" . url( "?id,{$row['id']}" ) . "\">" . $row['pavadinimas'] . "" . ( isset( $row['extra'] ) ? $row['extra'] : '' ) . "</a></li>";
				}
			}

			return $re;
		} else {
			return FALSE;
		}
	}
}
/**
 * Nuorodų tikrinimas
 *
 * @example if (checkUrl('http://delfi.lt')) echo 'ok'; else echo 'no';
 *
 * @param string $url
 *
 * @return true/false
 */
if(! function_exists('checkUrl')) {
	function checkUrl( $url ) {

		if ( $data = @get_headers( $url ) ) {
			preg_match( '/^HTTP\/1\.[01] (\d\d\d)/', implode( '', $data ), $matches );
			if ( $matches[1] == 200 ) {
				return TRUE;
			} else {
				return FALSE;
			}
		} else {
			return FALSE;
		}
	}
}

if(! function_exists('random')) {
	function random( $return = '' ) {

		$simboliai = "abcdefghijkmnopqrstuvwxyz0123456789";
		for ( $i = 1; $i < 3; ++$i ) {
			$num = rand() % 33;
			$return .= substr( $simboliai, $num, 1 );
		}

		return $return . '_';
	}
}

if(! function_exists('site_tree')) {
	function site_tree( $data, $id = 0, $active_class = 'active' ) {

		global $lang;
		
		if ( !empty( $data ) ) {
			$re = "";
			foreach ( $data[$id] as $row ) {
				if ( isset( $data[$row['id']] ) ) {
					if ( teises( $row['teises'], $_SESSION[SLAPTAS]['level'] ) ) {
						$re .= "<li><a href=\"" . url( '?id,' . $row['id'] ) . "\" >" . $row['pavadinimas'] . "</a><ul>";
						$re .= site_tree( $data, $row['id'], $active_class );
						$re .= "</ul></li>";
					}
				} else if ( teises( $row['teises'], $_SESSION[SLAPTAS]['level'] ) ) {
					$re .= "<li><a href=\"" . url( '?id,' . $row['id'] ) . "\" >" . $row['pavadinimas'] . "</a></li>";
				}
			}

			return $re;
		}
	}
}

//Siunciam nurodyta faila i narsykle. Pratestavau ant visu operaciniu ir narsykliu.
if(! function_exists('download')) {
	function download( $file, $filter = ".htaccess|.|..|remontas.php|index.php|configuration.php|conf.php" ) {

		global $sql, $lang;
		$filter = explode( "|", $filter );
		if ( !in_array( $file, $filter ) && is_file( $file ) ) {
			if ( strstr( $_SERVER['HTTP_USER_AGENT'], "MSIE" ) ) {
				$file = preg_replace( '/\./', '%2e', $file, substr_count( $file, '.' ) - 1 );
			}
			if ( is_file( $file ) ) {
				if ( connection_status() == 0 ) {
					if ( get_user_os() == "MAC" ) {
						header( "Content-Type: application/x-unknown\n" );
						header( "Content-Disposition: attachment; filename=\"" . basename( $file ) . "\"\n" );
					} elseif ( browser( htmlspecialchars( $_SERVER['HTTP_USER_AGENT'] ) ) == "IE" ) {
						$disposition = 'attachment'; //(!eregi("\.zip$", basename($file))) ? 'attachment' : 'inline';
						header( 'Content-Description: File Transfer' );
						header( 'Content-Type: application/force-download' );
						header( 'Content-Length: ' . (string)( filesize( $file ) ) );
						header( "Content-Disposition: $disposition; filename=\"" . basename( $file ) . "\"\n" );
						header( "Cache-Control: cache, must-revalidate" );
						header( 'Pragma: public' );
					} elseif ( browser( htmlspecialchars( $_SERVER['HTTP_USER_AGENT'] ) ) == "OPERA" ) {
						header( "Content-Disposition: attachment; filename=\"" . basename( $file ) . "\"\n" );
						header( "Content-Type: application/octetstream\n" );
					} else {
						header( "Content-Disposition: attachment; filename=\"" . basename( $file ) . "\"\n" );
						header( "Content-Type: application/octet-stream\n" );
					}
					header( "Content-Length: " . (string)( filesize( $file ) ) . "\n\n" );
					readfile( '' . $file . '' );
					exit;
				} else {
					header( "location: " . $_SERVER['PHP_SELF'] );
					exit;
				}
			} else {
				klaida( $lang['system']['error'], $lang['download']['notfound'] );
				header( "HTTP/1.0 404 Not Found" );
			}
		} else {
			header( "location: " . $sql['file'] );
		}
	}
}

if(! function_exists('svente')) {
	function svente( $array, $siandien = '', $return = '' ) {

		// Gauname šiandienos (mėnesis-diena)
		if ( !$siandien ) {
			$siandien = date( 'n-j' );
		}

		// Tikriname ar švenčių masyve nurodyta diena egzistuoja
		if ( array_key_exists( $siandien, $array ) ) {
			foreach ( $array[$siandien] as $key => $val ) {
				if ( empty( $return ) ) {
					$return .= $val;
				} //Jei išvedam šventę pirmą kartą
				else {
					$return .= ", <br />" . $val;
				} //Išvedame daugiau nei vieną šventę, atskiriame kableliais
			}
		}

		return $return;
	}
}

//class maxCalendar{
if(! function_exists('showCalendar')) {
	function showCalendar( $year = 0, $month = 0 ) {

		global $lang;
		/*$sventes = array( //Valstybinės šventės
		"1-1" => array("Naujieji metai", "Lietuvos vėliavos diena"),
		"1-13" => array("Laisvės gynėjų diena"),
		"2-16" => array("Lietuvos valstybės atkūrimo diena"),
		"3-11" => array("Lietuvos nepriklausomybės atkūrimo diena"),
		"5-1" => array("Tarptautinė darbo diena"),
		"5-4" => array("Motinos diena"),
		"6-24" => array("Rasos diena", "Jonininės"),
		"7-6" => array("Valstybės diena", "Lietuvos karaliaus Mindaugo karūnavimo diena"),
		"8-15" => array("Žolinės"),
		"11-1" => array("Visų šventųjų diena"),
		"12-25" => array("Kalėdos"),
		"12-26" => array("Kalėdos (antra diena)"), //Lietuvos Respublikos atmintinos dienos
		"8-23" => array("Juodojo kaspino diena", "Baltijos kelio diena"),
		"8-31" => array("Laisvės diena"),
		"9-1" => array("Mokslo ir žinių diena"),
		"9-8" => array("Šilinė (Švč. Mergelės Marijos gimimo diena)", "Vytauto Didžiojo karūnavimo diena"), //Kitos šventės
		"3-18" => array("FDisk gimtadienis")
		);*/
		$sventes = array();

		//Ieskom kieno gimtadieniai
		//$sql = "SELECT `id`,`nick`,`gim_data`,DATE_FORMAT(`gim_data`,'%e') AS `diena` FROM `" . LENTELES_PRIESAGA . "users` WHERE DATE_FORMAT(`gim_data`,'%c')=DATE_FORMAT(NOW(),'%c')";
		$sql = "SELECT `id`, `nick`, `gim_data`, DATE_FORMAT(`gim_data`,'%e') as `diena` FROM `" . LENTELES_PRIESAGA . "users` WHERE DATE_FORMAT(`gim_data`,'%c')=MONTH(NOW())";

		$sql = mysql_query1( $sql, 86400 );
		foreach ( $sql as $row ) {
			if ( $row['diena'] >= date( "j" ) ) {
				$sventes[date( 'n' ) . "-" . $row['diena']][] = "<b>" . $row['nick'] . "</b> {$lang['calendar']['birthday']}. " . ( ($row['diena'] < date('j')) ? (amzius( $row['gim_data'] ) + 1) : amzius($row['gim_data'])) . "m.";
				//$sventes[date( 'n' ) . "-" . $row['diena']][] = "<b>" . $row['nick'] . "</b> {$lang['calendar']['birthday']}. " . ( amzius( $row['gim_data'] ) + 1 ) . "m.";
			}
		}


		// Get today, reference day, first day and last day info
		if ( ( $year == 0 ) || ( $month == 0 ) ) {
			$referenceDay = getdate();

		} else {
			$referenceDay = getdate( mktime( 0, 0, 0, $month, 1, $year ) );
		}
		$firstDay              = getdate( mktime( 0, 0, 0, $referenceDay['mon'], 1, $referenceDay['year'] ) );
		$lastDay               = getdate( mktime( 0, 0, 0, $referenceDay['mon'] + 1, 0, $referenceDay['year'] ) );
		$today                 = getdate();
		$ieskom                = array(
			"December",
			"January",
			"February",
			"March",
			"April",
			"May",
			"June",
			"July",
			"August",
			"September",
			"October",
			"November"
		);
		$keiciam               = array(
			$lang['calendar']['December'],
			$lang['calendar']['January'],
			$lang['calendar']['February'],
			$lang['calendar']['March'],
			$lang['calendar']['April'],
			$lang['calendar']['May'],
			$lang['calendar']['June'],
			$lang['calendar']['July'],
			$lang['calendar']['August'],
			$lang['calendar']['September'],
			$lang['calendar']['October'],
			$lang['calendar']['November']
		);
		$referenceDay['month'] = str_replace( $ieskom, $keiciam, $referenceDay['month'] );
		$month                 = $referenceDay['mon'];
		$year                  = $referenceDay['year'];
		// Create a table with the necessary header informations
		$return = '<div class="kalendorius"><table width="100%" >
		<tr><th colspan="7">' . $referenceDay['month'] . ' - ' . $referenceDay['year'] . '</th></tr>
		<tr class="dienos"><td>' . $lang['calendar']['Mon'] . '</td><td>' . $lang['calendar']['Tue'] . '</td><td>' . $lang['calendar']['Wed'] . '</td><td>' . $lang['calendar']['Thu'] . '</td><td>' . $lang['calendar']['Fri'] . '</td><td>' . $lang['calendar']['Sat'] . '</td><td>' . $lang['calendar']['Sun'] . '</td></tr>';


		// Display the first calendar row with correct positioning
		$return .= '<tr>';
		if ( $firstDay['wday'] == 0 ) {
			$firstDay['wday'] = 7;
		}
		for ( $i = 1; $i < $firstDay['wday']; $i++ ) {
			$return .= '<td>&nbsp;</td>';
		}
		$actday = 0;
		for ( $i = $firstDay['wday']; $i <= 7; $i++ ) {
			$actday++;
			$svente = svente( $sventes, "" . $today['mon'] . "-" . $actday . "" );
			if ( ( $actday == $today['mday'] ) /*&& ($today['mon'] == $month)*/ ) {
				$class = "  class='siandien'";
			} else {
				$class = '';
			}
			if ( !empty( $svente ) ) {
				$return .= "<td$class ><div style='color:red' title=\"<b>{$lang['calendar']['this']}</b><br/>" . $svente . "<br/>\">$actday</div></td>";
			} else {
				$return .= "<td$class>" . ( $actday <= $today['mday'] && puslapis('kas_naujo.php') ? "<a href='" . url( "?id," . puslapis( 'kas_naujo.php' ) . ';d,' . mktime( 23, 59, 59, $month, $actday, $year ) ) . "'>$actday</a>" : $actday ) . "</td>";
			}
		}


		$return .= '</tr>';

		//Get how many complete weeks are in the actual month
		$fullWeeks = floor( ( $lastDay['mday'] - $actday ) / 7 );

		for ( $i = 0; $i < $fullWeeks; $i++ ) {
			$return .= '<tr>';
			for ( $j = 0; $j < 7; $j++ ) {
				$actday++;
				$svente = svente( $sventes, "" . $today['mon'] . "-" . $actday . "" );
				if ( ( $actday == $today['mday'] ) && ( $today['mon'] == $month ) ) {
					$class = "  class='siandien'";
				} else {
					$class = '';
				}
				if ( !empty( $svente ) ) {
					$return .= "<td$class ><div style='color:red' title=\"<b>{$lang['calendar']['this']}</b><br/>" . $svente . "<br/>\">$actday</div></td>";
				} else {
					$return .= "<td$class>" . ( $actday <= $today['mday'] && puslapis( 'kas_naujo.php' ) ? "<a href='" . url( "?id," . puslapis( 'kas_naujo.php' ) . ';d,' . mktime( 23, 59, 59, $month, $actday, $year ) ) . "'>$actday</a>" : $actday ) . "</td>";
				}
			}

			$return .= '</tr>';
		}

		//Now display the rest of the month
		if ( $actday < $lastDay['mday'] ) {
			$return .= '<tr>';

			for ( $i = 0; $i < 7; $i++ ) {
				$actday++;
				$svente = svente( $sventes, "" . $today['mon'] . "-" . $actday . "" );

				if ( ( $actday == $today['mday'] ) && ( $today['mon'] == $month ) ) {
					$class = "  class='siandien'";
				} else {
					$class = '';
				}

				if ( $actday <= $lastDay['mday'] ) {
					if ( !empty( $svente ) ) {
						$return .= "<td$class ><div style='color:red' title=\"<b>{$lang['calendar']['this']}</b><br/>" . $svente . "<br/>\">$actday</div></td>";
					} else {
						$return .= "<td$class>" . ( $actday <= $today['mday'] && puslapis( 'kas_naujo.php' ) ? "<a href='" . url( "?id," . puslapis( 'kas_naujo.php' ) . ';d,' . mktime( 23, 59, 59, $month, $actday, $year ) ) . "'>$actday</a>" : $actday ) . "</td>";
					}
				} else {
					$return .= '<td>&nbsp;</td>';
				}
			}


			$return .= '</tr>';
		}

		$return .= '</table></div>';

		return $return;
	}
}

if(! function_exists('postRemote')) {
	function postRemote($url, $data)
	{
		//open connection
		$ch = curl_init();

		$curlConfig = [
			CURLOPT_URL            => $url,
			CURLOPT_POST           => true,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_POSTFIELDS     => $data,
			// not secure stuff
			CURLOPT_SSL_VERIFYHOST => 0,
			CURLOPT_SSL_VERIFYPEER => 0
		];

		curl_setopt_array($ch, $curlConfig);

		if (! $result = curl_exec($ch)) {
			echo curl_error($ch);
		}
		//close connection
		curl_close($ch);

		return $result;
	}
}

if(! function_exists('checkVersion')) {
	function checkVersion()
	{
		if($existData = cacheGetData('versionCheck')) {
			return $existData;
		}

		$url = 'https://mightmedia.lt/api.php';
		$data = [
			'token' 	=> SLAPTAS,
			'version' 	=> versija(),
			'type'		=> 'versionCheck'
		];

		if($result = postRemote($url, $data)) {
			$response = json_decode($result, true);

			$time = (100 * 60 * 60);
			cachePutData('versionCheck', $response, $time);

			return $response;
		}

		return false;
	}
}

/**
 * TODO: add this somewhere else
 */
//getFiles
$extPath = ROOT . 'extensions/';
$extensions = getDirs($extPath);

if(! empty($extensions)) {
	foreach ($extensions as $extension) {
		$fileExt = $extPath . $extension . '/config.php';

		if(file_exists($fileExt)) {
			require_once $fileExt;
		}
	}
}