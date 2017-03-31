<?php
namespace Dream\Controller;
use Think\Controller;

class IndexController extends Controller {

	public function _before(){
	}

    public function index(){
		$account = D('Account');
		$data = $account->where("username='FODY'")->select();
        $this->show(print_r($data));
    }

	public function error(){
		$this->display();
	}

	public function player_online_count(){
		$data = array( 
			"labels" => array("02-01", "02-02", "02-03", "02-04", "02-05", "02-06"),
			"data" => array(array(1000, 1200, 1300, 2000, 2200, 1800),),
			"series" => array("玩家"),
		);
		//echo json_encode($data);
		header('Access-Control-Allow-Origin:*');
		$this->ajaxReturn($data);
	}

	public function accounts(){
		$account = D('Account');
		//$fields = $account->getDbFields();
		$data = $account->limit(8)->select();
		header('Access-Control-Allow-Origin:*');
        $this->ajaxReturn($data);
	}

	public function test(){
		$this->show("hello!");
	}
}
