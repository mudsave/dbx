<?php

function html_op()
{
	$str = <<<'EOD'
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="utf-8">
  <title>TEST</title>
<head>
<body>
EOD;
	echo $str;
}

function html_end()
{
	$str = <<<'EOD'
</body>
</html>
EOD;
	echo $str;
}

function db_encoding_convert(&$record_set, $column)
{
	foreach($record_set as $i=>$row)
	{
		$tmp = $row[$column];
		$encode = mb_detect_encoding($tmp, array('ASCII','GB2312','UTF-8'));
		if($encode == 'EUC-CN')
		{
			$tmp = mb_convert_encoding($tmp, 'UTF-8', $encode);
			$record_set[$i][$column] = $tmp;
		}
	}
}

function convert_to_utf8(&$str)
{
	$encode = mb_detect_encoding($str, array('ASCII','GB2312','UTF-8'));
	if ($encode == 'EUC-CN')
	{
		$str = mb_convert_encoding($str, 'UTF-8', $encode);
	}
}

function convert_to_gbk(&$str)
{
	$encode = mb_detect_encoding($str, array('ASCII','UTF-8'));
	if ($encode == 'UTF-8')
	{
		$str = mb_convert_encoding($str, 'GB2312', $encode);
	}
}