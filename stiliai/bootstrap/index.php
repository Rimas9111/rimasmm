<!DOCTYPE html>
<html lang="en">
<head>
    <?php header_info();?>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Bootstrap</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Arimo:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="stiliai/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="stiliai/<?php echo input(strip_tags($conf['Stilius'])); ?>/stiliai/bootstrap/default.css" />
    <script src="stiliai/bootstrap/bootstrapJS.js" async></script>
</head>
<body> 
<section class="container1"> 
    <div class="menu">
        <div class="menu-text">
        <nav id="nav">
        <ul>
            <?php
                $limit = 10; //Kiek nuorodų rodome
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
        <div class="burger">
        <i class="fas fa-bars"></i>
        </div>
    </div>
    <?php
        if ($page != 'puslapiai/naujienos') { 
    ?>
    <div class="middle">
        <?php 
            include "priedai/centro_blokai.php";
            include ( $page . ".php" ); 
        ?>
    </div>
    <?php
        } else {
    ?>

        <div class="container-middle">
            <h1>Stylish Portfolio</h1>
            <h4>A Free Bootstrap Theme by Start Bootstrap</h4>
            <button type="button" class="btn btn-custom buttonColor">Find Out More</button>
        </div>
    </section>
    <section class="container2">
        <div class="container-middle">
            <h1>Stylish Portfolio is the perfect theme for you next project!</h1>
            <h2>This theme featuret a flexible, UX friendly sidebar menu and stock photos from our friends Unsplash!</h2>
            <button type="button" class="btn btn-custom buttonColor">What We Offer</button>   
        </div>
    </section>
    <section class="container3">
        <div class="container">
            <div class="services-text">
                <h2>SERVICES</h2>
                <h1>What We Offer</h1>
            </div>
            <div class="services-list">
                <div class="row">
                    <?php 
                    $str = mysql_query1("SELECT * FROM `yn_straipsniai` ORDER BY data DESC LIMIT 4;");
                    foreach ($str as $key) {
                    ?>
                        <article class="col-sm-3">
                            <div class="icon">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <h1> <?php echo $key['pav']; ?> </h1>
                            <h2> <?php echo $key['t_text']; ?> </h2>
                        </article>

                    <?php } ?>
                </div>
            </div>
        </div>
    </section>
    <section class="container-fluid2">
        <div class="container-middle2">
            <h1>Welcome to your next website</h1>
            <button type="button" class="btn btn-custom buttonColor">Download Now!</button>
        </div>
    </section>
    <section class="container4">
    <div class="container-middle2">
            <div class="services-text">
                <h2>PORTFOLIO</h2>
                <h1>Recent Projects</h1>
            </div>
    </div>
    <div class="container">
        <div class="row">
            <?php 
                $news = mysql_query1("SELECT * FROM `yn_naujienos` ORDER BY data DESC LIMIT 4;");
                foreach ($news as $key) {
            ?>
                <article class="col-md-6 cont-portfolio1">
                    <div class="p-text">
                        <h6> <?php echo $key['pavadinimas']; ?> </h6>
                        <h5> <?php echo $key['naujiena']; ?> </h5>
                    </div>
                </article>
            <?php } ?>
        </div>
    </div>
    </section>
    <section class="container3">
    <div class="container-fluid">
        <h3>The buttons below are impossible to resist...</h3>
        <button type="button" class="btn btn-custom buttonColor2">Click Me!</button>
        <button type="button" class="btn btn-custom buttonColor2">Look At Me!</button>
    </div>
    </section>
    <section>
    <div style="width: 100%"><iframe width="100%" height="600" src="https://maps.google.com/maps?width=100%&amp;height=600&amp;hl=en&amp;q=vilnius%20gediminas%20castle+(My%20Business%20Name)&amp;ie=UTF8&amp;t=&amp;z=14&amp;iwloc=B&amp;output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"><a href="https://www.maps.ie/create-google-map/"></a></iframe></div><br/>
    </section>
    <section class="container5">
    <!-- <div class="container"> -->
        <div class="bottom">
            <a href="" class="icon2"><i class="fab fa-facebook-f foot-icon"></i></a>
            <a href="" class="icon2"><i class="fab fa-twitter foot-icon"></i></a>
            <a href="" class="icon2"><i class="fab fa-github foot-icon"></i></a>
        </div>
    <!-- </div> -->
       <div class="copyright">Copyright <i class="far fa-copyright"></i> Your Website 2018</div>
</section>
    <?php } ?>
</body>
</html>