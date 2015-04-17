<?php

namespace Common\Controller;

use Think\Controller;

/**
 * Appframe项目公共Controller
 */
class AppframeController extends Controller {
	public function _initialize() {
		// 消除所有的magic_quotes_gpc转义
		// Input::noGPC();
		// 跳转时间
		$this->assign ( "waitSecond", 3 );
		// $this->assign("__token__", $this->getToken());
		$time = time ();
		$this->assign ( "js_debug", APP_DEBUG ? "?v=$time" : "" );
		if (APP_DEBUG) {
			// sp_clear_cache();
		}
	}
	
	// 获取表单令牌
	protected function getToken() {
		$tokenName = C ( 'TOKEN_NAME' );
		// 标识当前页面唯一性
		$tokenKey = md5 ( I ( 'server.REQUEST_URI' ) );
		$tokenAray = session ( $tokenName );
		// 获取令牌
		$tokenValue = $tokenAray [$tokenKey];
		return $tokenKey . '_' . $tokenValue;
	}
	
	// 空操作
	public function _empty() {
		$this->error ( '该页面不存在！' );
	}
	
	/**
	 * 检查操作频率
	 *
	 * @param int $duration
	 *        	距离最后一次操作的时长
	 */
	protected function check_last_action($duration) {
		$action = MODULE_NAME . "-" . CONTROLLER_NAME . "-" . ACTION_NAME;
		$time = time ();
		$session_action = session ( 'last_action.action' );
		if (! empty ( $session_action ) && $action == $session_action) {
			$mduration = $time - session ( 'last_action.time' );
			if ($duration > $mduration) {
				$this->error ( "您的操作太过频繁，请稍后再试~~~" );
			} else {
				session ( 'last_action.time', $time );
			}
		} else {
			session ( 'last_action.action', $action );
			session ( 'last_action.time', $time );
		}
	}
}

