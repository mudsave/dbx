<?php
namespace Dream\Controller;
use Think\Controller;

class IndexController extends Controller {

    public function index(){
		$account = D('Account');
		$data = $account->where("username='FODY'")->select();
        $this->show(print_r($data));
    }

	public function player_online_count(){
		$data = array(
			"labels" => array("02-01", "02-02", "02-03", "02-04", "02-05", "02-06"),
			"data" => array(array(1000, 1200, 1300, 2000, 2200, 1800),),
			"series" => array("玩家"),
		);
		$this->ajaxReturn($data);
	}

	public function accounts(){
		$account = D('Account');
		$data = $account->limit(8)->select();
        $this->ajaxReturn($data);
	}

	public function test(){
		$u = new \Dream\Common\Utils;
		$u->test_util();
		\Dream\Common\test_co();
		$this->show("hello!");
	}
	//得到在所有的线玩家
	public function get_online_info(){
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/get_online_info");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		$this->show($rt);
		curl_close($ch);
	}
	// 得到活动信息
	public function get_act_info()
	{
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/get_act_info");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		$this->show($rt);
		curl_close($ch);
	}

	// 开启活动
	public function start_act()
	{
		$activityid = I('param.activityid', -1);
		if($activityid == false && $activityid == -1)
		{
			$rt['result'] = 0;
			$this->ajaxReturn($rt);
			return;
		}
		// $activityid = $_GET['activityid'];
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/start_act?activityid=$activityid");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		$this->show($rt, 'utf-8', 'text/json');
		curl_close($ch);
	}

	// 关闭活动
	public function close_act()
	{
		$activityid = I('param.activityid', -1);
		if($activityid == false && $activityid == -1)
		{
			$rt['result'] = 0;
			$this->ajaxReturn($rt);
			return;
		}
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/close_act?activityid=$activityid");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		$this->show($rt);
		curl_close($ch);
	}
	//公告
	public function broadcast()
	{
		$content = $_GET['content'] ;
		$period = $_GET['period'];
		$times = $_GET['times'];
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/broadcast?content=$content&period=$period&times=$times");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		$this->show($rt, 'utf-8', 'text/json');
		curl_close($ch);
	}
	//发送邮件
	public function sendmail()
	{
		$content = $_GET['content'];
		$ids = 	$_GET['ids'];
		$items = $_GET['items'];
		$theme = $_GET['theme'];
		$money = "1000";
		$subMoney = "1000";
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/sendmail?ids=$ids&theme=$theme&content=$content&items=$items&money=$money&subMoney=$subMoney");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		$this->show($rt, 'utf-8', 'text/json');
		curl_close($ch);
	}
	
}
