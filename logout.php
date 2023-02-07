<?php
session_start();
session_destroy();
header("Location: index.php");

$percent = 0;
$percent = $percent + 10;
echo '<div class="progress">
<div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:'.$percent.'%">
'.$percent.'%
</div>
</div>';

?>