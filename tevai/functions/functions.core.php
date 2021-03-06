<?php
//medzio darymo f-ja
function build_tree( $data, $id = 0, $active_class = 'active' ) {

	global $lang;
	if ( !empty( $data ) ) {
		$re = "";
		foreach ( $data[$id] as $row ) {
			if ( isset( $data[$row['id']] ) ) {
				$re .= "<li><a href=\"" . url( '?id,' . $row['id'] ) . "\" >" . $row['pavadinimas'] . "</a><span style=\"display: inline; width: 100px;margin:0; padding:0; height: 16px;\"><a href=\"" . url( '?id,999;a,' . getAdminPagesbyId('meniu') . ';d,' . $row['id'] ) . "\"  onClick=\"return confirm(\'" . $lang['admin']['delete'] . "?\')\"><img src=\"" . ROOT . "images/icons/cross.png\" title=\"" . $lang['admin']['delete'] . "\"  /></a>
<a href=\"" . url( '?id,999;a,' . getAdminPagesbyId('meniu') . ';r,' . $row['id'] ) . "\"><img src=\"" . ROOT . "images/icons/wrench.png\" title=\"" . $lang['admin']['edit'] . "\"/></a>
<a href=\"" . url( '?id,999;a,' . getAdminPagesbyId('meniu') . ';e,' . $row['id'] ) . "\"><img src=\"" . ROOT . "images/icons/pencil.png\" title=\"" . $lang['admin']['page_text'] . "\" /></a></span><ul>";
				$re .= build_tree( $data, $row['id'], $active_class );
				$re .= "</ul></li>";
			} else {
				$re .= "<li><a href=\"" . url( '?id,' . $row['id'] ) . "\" >" . $row['pavadinimas'] . "</a><span style=\"display: inline; width: 100px; margin:0; padding:0; height: 16px;\">
<a href=\"" . url( '?id,999;a,' . getAdminPagesbyId('meniu') . ';d,' . $row['id'] ) . "\" onClick=\"return confirm(\'" . $lang['admin']['delete'] . "?\')\"><img src=\"" . ROOT . "images/icons/cross.png\" title=\"" . $lang['admin']['delete'] . "\"/></a>
<a href=\"" . url( '?id,999;a,' . getAdminPagesbyId('meniu') . ';r,' . $row['id'] ) . "\"><img src=\"" . ROOT . "images/icons/wrench.png\" title=\"" . $lang['admin']['edit'] . "\" /></a>
<a href=\"" . url( '?id,999;a,' . getAdminPagesbyId('meniu') . ';e,' . $row['id'] ) . "\" ><img src=\"" . ROOT . "images/icons/pencil.png\" title=\"" . $lang['admin']['page_text'] . "\" /></a></span>
</li>";
			}
		}
		return $re;
	}
}

function editor( $tipas = 'jquery', $dydis = 'standartinis', $id = FALSE, $value = '' ) {

	global $conf, $lang;

	if ( !$id ) {
		$id = md5( uniqid() );
	}

	if ( is_array( $id ) ) {
		foreach ( $id as $key => $val ) {
			$arr[$val] = "'$key'";
		}
		$areos = implode( $arr, "," );
	} else {
		$areos = "'$id'";
	}

	$root = ROOT;
	$return = '';

	if ( $conf['Editor'] == 'textarea' ) {
		
		if ( is_array( $id ) ) {
			foreach ( $id as $key => $val ) {
				$return .= <<<HTML

	<textarea id="{$key}" name="{$key}" rows="1" class="form-control no-resize auto-growth">{$value[$key]}</textarea>
HTML;
			}
		} else {
			$return .= <<<HTML

<textarea id="{$id}" name="{$id}" rows="1" class="form-control no-resize auto-growth">{$value}</textarea>
HTML;

		}
	} elseif ( $conf['Editor'] == 'tinymce' ) {
		$dir    = adresas();
		$return .= <<<HTML
      <!-- Load TinyMCE -->
<script src="{$dir}htmlarea/tinymce/tinymce.js" type="text/javascript"></script>
<script type="text/javascript">
	//TinyMCE
    tinymce.init({
        selector: "textarea.tinymce",
        theme: "modern",
        height: 300,
        plugins: [
            'advlist autolink lists link image charmap print preview hr anchor pagebreak',
            'searchreplace wordcount visualblocks visualchars code fullscreen',
            'insertdatetime media nonbreaking save table contextmenu directionality',
            'emoticons template paste textcolor colorpicker textpattern imagetools'
        ],
        toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
        toolbar2: 'print preview media | forecolor backcolor emoticons',
		image_advtab: true,
		// images_upload_url: 'postAcceptor.php', - images local upload
    });

</script>
<!-- /TinyMCE -->
HTML;
		if ( is_array( $id ) ) {
			foreach ( $id as $key => $val ) {

				$return .= <<< HTML
<textarea id="{$key}" name="{$key}" class="tinymce">{$value[$key]}</textarea>
HTML;
			}
		} else {
			$return .= <<< HTML
<textarea id="{$id}" name="{$id}" class="tinymce">{$value}</textarea>
HTML;

		}
		
	} elseif ( $conf['Editor'] == 'ckeditor' ) {
		$dir = adresas();

		$return .= <<<HTML
	<script type="text/javascript" src="{$dir}htmlarea/ckeditor/ckeditor.js"></script>
	<script type="text/javascript">
		//CKEditor
		CKEDITOR.replaceClass = 'ckeditor';
		CKEDITOR.config.height = 300;
		CKEDITOR.config.extraPlugins = 'uploadimage';
	</script>
HTML;

		if ( is_array( $id ) ) {
			foreach ( $id as $key => $val ) {

				$return .= <<< HTML
<textarea id="{$key}" name="{$key}" class="ckeditor">{$value[$key]}</textarea>
HTML;
			}
		} else {
			$return .= <<< HTML
<textarea id="{$id}" name="{$id}" class="ckeditor">{$value}</textarea>
HTML;

		}
	}
	
	return $return;
}

function defaultHead() 
{
	global $conf;

	?>
	<base href="<?php echo adresas(); ?>" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><?php echo input(strip_tags($conf['Pavadinimas']) . ' - Admin'); ?></title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="robots" content="index,follow" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- favicon -->
	<link rel="apple-touch-icon" sizes="180x180" href="/images/favicon/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/images/favicon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/images/favicon/favicon-16x16.png">
	<link rel="manifest" href="/images/favicon/site.webmanifest">
	<link rel="mask-icon" href="/images/favicon/safari-pinned-tab.svg" color="#db7300">
	<meta name="msapplication-TileColor" content="#ff440e">
	<meta name="theme-color" content="#ffffff">
	<?php
}

function adminPages() 
{
	global $url, $lang, $conf, $buttons, $timeout, $prisijungimas_prie_mysql;

	if($versionData = checkVersion()) {
		notifyUpdate($versionData);
	}	

	$fileName = (isset($url['a']) && ! empty(getAllAdminPages($url['a'])) ? getAllAdminPages($url['a']) : null);

	if (! empty($fileName) && file_exists(ROOT . $fileName) && isset($_SESSION[SLAPTAS]['username']) && $_SESSION[SLAPTAS]['level'] == 1 && defined( "OK" ) ) {
		if (count($_POST) > 0 && $conf['keshas'] == 1) {
			notifyMsg(
				[
					'type'		=> 'warning',
					'message' 	=> $lang['system']['cache_info']
				]
			);
		}
		
		include_once ROOT . $fileName;

	} elseif (isset($url['m'])) {

		switch ($url['m']) {
			case 1:
				$page = 'uncache.php';
				break;
			case 2:
				$page = 'pokalbiai.php';
				break;
			case 3:
				$page = 'antivirus.php';
				break;
			case 4:
				$page = 'search.php';
				break;
			case 'upgrade':
				$page = 'upgrade.php';
				break;
		}

		include_once 'pages/' . $page;
	} else {
		include_once 'pages/dashboard.php';
	}
}

function getAdminExtensionsMenu($page = null) 
{
	global $adminExtensionsMenu;

	$menu = applyFilters('adminExtensionsMenu', $adminExtensionsMenu);

	return ! empty($page) ? $menu[$page] : $menu;
}

function getAllAdminPages($page = null)
{
	$adminMenu 				= getAdminPages();
	$adminExtensionsMenu 	= getAdminExtensionsMenu();

	$allPages = array_merge($adminMenu, $adminExtensionsMenu);

	if(! empty($page)) {
		return ! empty($allPages[$page]) ? $allPages[$page] : null;
	}
	
	return $allPages;
}

function getAdminPages($page = null) 
{
	global $adminMenu;

	$menu = $adminMenu; //todo: add hooks

	return ! empty($page) ? $menu[$page] : $menu;
}
//todo: optimise it
function getAdminPagesbyId($id = null, $key = null) 
{

	$menu = getAllAdminPages();
	$idArray = [];

	foreach ($menu as $name => $file) {
		$newKey = basename($file, '.php');

		$idArray[$newKey] = [
			'file'	=> $file,
			'name'	=> $name,
		];
	}

	$key = ! empty($key) ? $key : 'name';

	return ! empty($id) ? $idArray[$id][$key] : $menu;
}

function getFeedArray($feedUrl) 
{
     
    $content = file_get_contents($feedUrl);
	$x = simplexml_load_string($content, null, LIBXML_NOCDATA);
	
    return $x->channel;
}

//atvaizduojam blokus
function dragItem($id, $content, $subMenu = null)
{
	return '<li class="dd-item dd3-item" data-id="' . $id . '">
	<div class="dd-handle dd3-handle"></div>
	<div class="dd3-content">
		' . $content . '
	</div>
	' . (! empty($subMenu) ? $subMenu : '') . '
	</li>';
}

//filtering
function tableFilter($formData, $data, $formId = '')
{
	global $lang;

	$newFormData['#'] = '<input type="checkbox" id="visi" name="visi" onclick="checkedAll(\'' . $formId . '\');" class="filled-in"><label for="visi"></label>';

	foreach($formData as $key => $value) {
		$input = '<div class="form-group">';
		$input .= '<div class="form-line">';
		$input .= '<input type="text" name="' . $key . '" value="' . (isset($data[$key]) ? $data[$key] : '') . '" class="form-control">';
		$input .= '</div>';
		$input .= '</div>';

		$newFormData[$value] = $input;
	}

	$newFormData[$lang['admin']['action']] = '<button type="submit" class="btn btn-primary waves-effect">' . $lang['admin']['filtering'] . '</button>';

	return $newFormData;
}

function deleteRedirectSession()
{
	unset($_SESSION[SLAPTAS]['redirect']);

}

function buttons($id = null)
{
	global $buttons;

	$buttons = applyFilters('adminButtons', $buttons);

	if(! empty($id)) {
		return isset($buttons[$id]) && ! empty($buttons[$id]) ? $buttons[$id] : null;
	} 
	
	return $buttons;
}

function icons($group, $icon)
{
	global $icons;

	$icons = applyFilters('adminMenuIcons', $icons);
	
	return ! empty($icons[$group][$icon]) ? $icons[$group][$icon] : null;
}

function iconsMenu($icon)
{
	global $icons;

	$iconsMenu = $icons['menu'];
	$iconsMenu = applyFilters('adminMenuIcons', $iconsMenu);
	
	return ! empty($iconsMenu[$icon]) ? $iconsMenu[$icon] : null;
}