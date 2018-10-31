<!DOCTYPE HTML>
<!--
	Synchronous by TEMPLATED
    templated.co @templatedco
    Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
	<head>
		<?php header_info(); ?>
		
		<link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,900' rel='stylesheet' type='text/css'>
		<link rel="stylesheet" href="stiliai/<?php echo input(strip_tags($conf['Stilius'])); ?>/css/skel-noscript.css" />
		<link rel="stylesheet" href="stiliai/<?php echo input(strip_tags($conf['Stilius'])); ?>/css/style.css" />
		<link rel="stylesheet" href="stiliai/<?php echo input(strip_tags($conf['Stilius'])); ?>/css/style-desktop.css" />
	</head>
	<body class="homepage">
		<div id="wrapper">
			
			<!-- Header -->
			<div id="header">
				<div class="container"> 
					
					<!-- Logo -->
					<div id="logo">
					<h1><a href="<?php echo adresas(); ?>">
						<?php echo input( strip_tags( $conf['Pavadinimas'] )); ?>
					</a></h1>
					<span>
						<?php echo $conf['Apie']; ?>
					</span>
				</div>
					
					<!-- Nav -->
				<nav id="nav">
					<ul>
						<?php
							$limit = 6; //Kiek nuorodų rodome
							$menuSql  = mysql_query1( "SELECT * FROM `" . LENTELES_PRIESAGA . "page` WHERE `parent` = 0 AND `show` = 'Y' AND `lang` = " . escape(lang()) . " ORDER BY `place` ASC LIMIT " . $limit );
						?>
						<?php foreach ($menuSql as $menuRow) { ?>
							<?php if (teises( $menuRow['teises'], $_SESSION[SLAPTAS]['level'])){ ?>
								<li>
									<a href="<?php echo url('?id,' . (int)$menuRow['id']); ?>">
										<?php echo input($menuRow['pavadinimas']); ?>
									</a>
								</li>
							<?php } ?>
						<?php } ?>
					</ul>
				</nav>
			</div>
		</div>
			<!-- /Header -->
			
			<div id="page">
				<div class="container">
					<div class="row">
						<div class="3u">
							<?php include ( "priedai/kaires_blokai.php" ); ?>
						</div>
						<div class="6u skel-cell-important">
							<?php
								if ( isset( $strError ) && !empty( $strError ) ) {
									klaida( "Klaida", $strError );
								}
								
								include ( "priedai/centro_blokai.php" );
								include ( $page . ".php" );
							?>
						</div>
						<div class="3u">
							<?php include ( "priedai/desines_blokai.php" ); ?>
						</div>
					</div>

				</div>	
			</div>

			<!-- Copyright -->
			<div id="copyright">
				<div class="container">
					Design: <a href="http://templated.co">TEMPLATED</a> Images: <a href="http://unsplash.com">Unsplash</a> (<a href="http://unsplash.com/cc0">CC0</a>)
				</div>
			</div>
			
		</div>
	</body>
</html>