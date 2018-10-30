<!DOCTYPE HTML>
<!--
	Iridium by TEMPLATED
    templated.co @templatedco
    Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
-->
<html>
<head>
        <?php header_info(); ?>
        <link href='http://fonts.googleapis.com/css?family=Arimo:400,700' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="stiliai/<?php echo input(strip_tags($conf['Stilius'])); ?>/css/skel-noscript.css" />
        <link rel="stylesheet" href="stiliai/<?php echo input(strip_tags($conf['Stilius'])); ?>/css/style.css" />
        <link rel="stylesheet" href="stiliai/<?php echo input(strip_tags($conf['Stilius'])); ?>/css/style-desktop.css" />
    </head>
	<body class="homepage">

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

		<!-- Main -->
		<div id="main">
			<div class="container">
				<div class="row"> 
					
					<!-- Content -->
					<div id="content" class="8u skel-cell-important">
						<?php
							if ( isset( $strError ) && !empty( $strError ) ) {
								klaida( "Klaida", $strError );
							}
							
							include ( "priedai/centro_blokai.php" );
							include ( $page . ".php" );
						?>
					</div>
					
					<!-- Sidebar -->
					<div id="sidebar" class="4u">
						<?php include ( "priedai/desines_blokai.php" ); ?>
					</div>
				</div>
			</div>
		</div>

		<!-- Copyright -->
		<div id="copyright">
			<div class="container">
				<?php copyright( $conf['Copyright'] );?>
				Design: <a href="http://templated.co">TEMPLATED</a> Images: <a href="http://unsplash.com">Unsplash</a> (<a href="http://unsplash.com/cc0">CC0</a>)
			</div>
		</div>
		
	</body>
</html>