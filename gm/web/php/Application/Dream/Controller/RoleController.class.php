<?php
namespace Dream\Controller;
use Think\Controller;

class RoleController extends Controller {

	public function get_roles(){
		$p = I('param.page', 0);
		$ps = I('param.page_size', 10);
		$roles = M('Role');
		$count = $roles->count();
		$data = $roles->field('ID,Name')->order('ID')->page($p.','.$ps)->select();
		db_encoding_convert($data, 'name');
		$rt = array();
		$rt['page_size'] = $ps;
		$rt['page_no'] = $p;
		$rt['msg'] = $data;
		$this->ajaxReturn($rt);
	}

	public function get_role_info(){
		$rt = array();
		$role_id = I('param.role_id', -1);
		if($role_id == false && $role_id == -1)
		{
			$rt['result'] = 0;
			$this->ajaxReturn($rt);
			return;
		}
		$role = M('Role');
		$data = $role->where('ID = '.$role_id)->field('ID, Name, Sex, Level, School, MapID, PosX, PosY, Money')->select();
		if(count($data) == 0)
		{
			$rt['result'] = 0;
		}
		else
		{
			db_encoding_convert($data, 'name');
			$rt['result'] = 1;
			$rt['msg'] = $data;
		}
		$this->ajaxReturn($rt, 'JSON');
	}
	
	//查询在线玩家消息
	public function get_role_info_by_dbid()
	{
		$DBID = I('param.id', -1);
		if($DBID == false && $DBID == -1)
		{
			$rt['result'] = 0;
			$this->ajaxReturn($rt);
			return;
		}
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/get_online_role_info_by_dbid?DBID=$DBID");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		convert_to_utf8($rt);
		$d = json_decode($rt, true, 10);
		// print_r($d['result']);
		if ($d['result'] > 0)
		{
			$this->show($rt, 'utf-8', 'text/json');
		} else 
		{
			$dbrt = array();
			$role = M('Role');
			$data = $role->where('ID = '.$DBID)->field('ID, Name, Sex, Level, School, MapID, PosX, PosY, Money, SubMoney')->select();
			// print_r($data);
			if(count($data) == 0)
			{
				$dbrt['result'] = 0;
			}
			else
			{
				$data[0][onlinestate] = 0;
				db_encoding_convert($data, 'name');
				$dbrt['result'] = 1;
				$dbrt['msg'] = $data[0];
			}
			$this->ajaxReturn($dbrt, 'JSON');
		}
		curl_close($ch);
	}
	
	public function get_role_info_by_name(){
		$roleName = I('param.name', -1);
		if($roleName == false && $roleName == -1)
		{
			$rt['result'] = 0;
			$this->ajaxReturn($rt);
			return;
		}
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/get_online_role_info_by_name?roleName=$roleName");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		convert_to_utf8($rt);
		$d = json_decode($rt, true, 10);
		// print_r($d['result']);
		if ($d['result'] > 0)
		{
			$this->show($rt, 'utf-8', 'text/json');
		} else 
		{
			$dbrt = array();
			$role = M('Role');
			convert_to_gbk($roleName);
			$data = $role->where('Name = '.$roleName)->field('ID, Name, Sex, Level, School, MapID, PosX, PosY, Money, SubMoney')->select();
		
			// print_r($data);
			if(count($data) == 0)
			{
				$dbrt['result'] = 0;
			}
			else
			{	
				db_encoding_convert($data, 'name');
				$dbrt['result'] = 1;
				$data[0][onlinestate] = 0;
				$dbrt['msg'] = $data[0];
			}
			$this->ajaxReturn($dbrt, 'JSON');
		}
		curl_close($ch);
	}
	//复位
	public function reset_postion()
	{
		$DBID = I('param.id', -1);
		$mapID = I('param.mapID', -1);
		if($DBID == false && $DBID == -1)
		{
			$rt['result'] = 0;
			$this->ajaxReturn($rt);
			return;
		}
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/reset_postion?DBID=$DBID&mapID=$mapID");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		convert_to_utf8($rt);
		$msg = json_decode($rt, true, 10);
		// print_r($msg);
		if ($msg['result'] > 0)
		{
			$this->show($rt, 'utf-8', 'text/json');
		} else 
		{
			$info = $msg['msg'];
			// print_r($info);
			$dbrt = array();
			$role = M('Role');
			$role->MapID = $info['mapID'];
			$role->PosX = $info['posX'];
			$role->PosY = $info['posY'];
			$role->where('ID = '.$DBID)->save(); // 根据条件保存修改的数据
			$data = $role->where('ID = '.$DBID)->field('ID, Name, Sex, Level, School, MapID, PosX, PosY, Money, SubMoney')->select();
			// print_r($data);
			if(count($data) == 0)
			{
				$dbrt['result'] = 0;
			}
			else
			{
				db_encoding_convert($data, 'name');
				$dbrt['result'] = 1;
				$dbrt['msg'] = $data[0];
			}
			$this->ajaxReturn($dbrt, 'JSON');
		}
		curl_close($ch);
	}
	//改变玩家位置
	public function set_role_postion()
	{
		$DBID = I('param.id', -1);
		if($DBID == false && $DBID == -1)
		{
			$rt['result'] = 0;
			$this->ajaxReturn($rt);
			return;
		}
		
		$mapID = I('param.mapid', -1);
		$posX = I('param.posx', -1);
		$posY = I('param.posy', -1);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/set_role_postion?DBID=$DBID&mapID=$mapID&posX=$posX&posY=$posY");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		convert_to_utf8($rt);
		$msg = json_decode($rt, true, 10);
		print("xccccc");
		print_r($msg);
		print("xccccc");
		if ($msg['result'] == 1)
		{
			$this->show($rt, 'utf-8', 'text/json');
		} else 
		{
			$info = $msg['msg'];
			$dbrt = array();
			$role = M('Role');
			if ($msg['result'] < 1) 
			{
				
				$role->MapID = $mapID;
				$role->PosX = $posX;
				$role->PosY = $posY;
				$role->where('ID = '.$DBID)->save(); // 根据条件保存修改的数据
			}
			$data = $role->where('ID = '.$DBID)->field('ID, Name, Sex, Level, School, MapID, PosX, PosY, Money, SubMoney')->select();
			// print_r($data);
			if(count($data) == 0)
			{
				$dbrt['result'] = 0;
			}
			else
			{
				db_encoding_convert($data, 'name');
				$dbrt['result'] = 1;
				$dbrt['msg'] = $data[0];
			}
			$this->ajaxReturn($dbrt, 'JSON');
		}
		curl_close($ch);
	}
	// 踢玩家下线
	public function kick_player()
	{
		$DBID = I('param.id', -1);
		if($DBID == false && $DBID == -1)
		{
			$rt['result'] = 0;
			$this->ajaxReturn($rt);
			return;
		}
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, "http://172.16.2.217:5588/kick_player?DBID=$DBID");
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		$rt = curl_exec($ch);
		// echo $rt;
		$this->show($rt, 'utf-8', 'text/json');
		curl_close($ch);
	}
	
}
