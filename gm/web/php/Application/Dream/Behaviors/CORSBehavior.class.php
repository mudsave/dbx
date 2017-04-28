<?php
namespace Dream\Behaviors;

class CORSBehavior
{
	public function run(&$param){
		header('Access-Control-Allow-Origin:*');
	}
}