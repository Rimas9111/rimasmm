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
						<section id="box1">
								<header>
									<h2>Straipsniai</h2>
								</header>
								<ul class="style3">
									<li class="first">
										<p class="date"><a href="#">11.01</a></p>
										<p><a href="#">Donec leo, vivamus fermentum nibh in augue praesent urna congue rutrum.</a></p>
									</li>
									<li>
										<p class="date"><a href="#">11.06</a></p>
										<p><a href="#">Donec leo, vivamus fermentum nibh in augue praesent urna congue rutrum.</a> </p>
									</li>
								</ul>
							</section>
						</div>
						<div class="6u skel-cell-important">
							<section>
								<header>
									<h2>LOREM IPSUM DOLOR</h2>
								</header>
								<div> <a href="#" class="image full"><img src="images/pics02.jpg" alt=""></a> </div>
								<p>This is Synchronous, a responsive HTML5 site template freebie by TEMPLATED. Released for free under the Creative Commons Attribution license, so use it for whatever (personal or commercial) – just give us credit! Check out more of our stuff at our site or follow us on Twitter.
									Aliquam erat volutpat. Pellentesque tristique ante ut risus. Quisque dictum. Integer nisl risus, sagittis convallis, rutrum id, elementum congue, nibh. Suspendisse dictum porta lectus. Donec placerat odio vel elit. Nullam ante orci, pellentesque eget, tempus quis, ultrices in, est. Curabitur sit amet nulla. Nam in massa. Sed vel tellus. Curabitur sem urna, consequat vel, suscipit in, mattis placerat, nulla. Sed ac leo.
									Sed etiam vestibulum velit mollis pretium suscipit, justo nulla blandit libero, in blandit augue justo quis nisl. Fusce mattis viverra elit. Fusce quis tortor. Consectetuer adipiscing elit. Nam pede erat, porta eu, lobortis eget lorem ipsum dolor.</p>
							</section>
						</div>
						<div class="3u">
							<section>
								<header>
									<h2>Text</h2>
								</header>
								<ul class="style1">
									<li class="first"><a href="#">Maecenas luctus lectus at sapien</a></li>
									<li><a href="#">Etiam rhoncus volutpat erat</a></li>
									<li><a href="#">Donec dictum metus in sapien</a></li>
								</ul>
							</section>
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