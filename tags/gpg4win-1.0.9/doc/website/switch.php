<?PHP
switch ($_SERVER["HTTP_HOST"]) {
 case "www.gpg4win.de":
   $target = "index-de.html";
   break;
 default:
   $target = "index.html";
 }
readfile($target);
?>
