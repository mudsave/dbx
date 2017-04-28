<?php
namespace Dream\Controller;
use Think\Controller;

class LoginController extends Controller {

	/*
		rt[0] = 1;
		rt[1] = "url";
	*/
	public function signin()
	{
        $user_name = I('param.username', '');
        $pass_word = I('param.passwd', '');
        $verify_code = I('param.code', '');
        $verify = new \Think\Verify();
        if(! $verify->check($verify_code, ''))
        {
            $this->ajaxReturn(array(0, '验证码不正确!'));
        }
        if($user_name == "admin" && $pass_word == "admin")
        {
            $this->ajaxReturn(array(1, "/app/index.html"));
        }
        else
        {
            $this->ajaxReturn(array(0, "密码不对或用户不存在!"));
        }
	}

	public function verify_code()
	{
		$config = array(
			'fontSize' => 23,
			'useCurve' => false,
			'useNoise' => false,
			'imageW' => 150,
			'imageH' => 50,
			'length' => 4
		);
		$Verify = new \Think\Verify($config);
		$Verify->entry();
	}

	public function verify()
	{
		$code = I('param.code', 0);
		$verify = new \Think\Verify();
		$rt = $verify->check($code, '');
        $rt = $rt ? 1 : 0;
		$this->ajaxReturn(array($rt));
	}

	public function session()
	{
		$value = session();
		var_dump($value);
	}

	public function test()
	{
		vendor('jsonRPC.jsonRPCClient');
		$client = new \jsonRPCClient('http://172.16.2.218/php/index.php?m=home&c=test');
		$result = $client->test();
		$this->show(print_r($result));
	}
}
