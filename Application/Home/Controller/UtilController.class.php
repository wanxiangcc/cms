<?php

namespace Home\Controller;

use Common\Controller\HomeBaseController;

class UtilController extends HomeBaseController {
	public function randcode($type = 'login', $font_size = 15, $length = 4) {
		/**
		 * 可以对生成的验证码设置相关的参数，以达到不同的显示效果。 这些参数包括：
		 * expire 验证码的有效期（秒）
		 * useImgBg 是否使用背景图片 默认为false
		 * fontSize 验证码字体大小（像素） 默认为25
		 * useCurve 是否使用混淆曲线 默认为true
		 * useNoise 是否添加杂点 默认为true
		 * imageW 验证码宽度 设置为0为自动计算
		 * imageH 验证码高度 设置为0为自动计算
		 * length 验证码位数
		 * fontttf 指定验证码字体 默认为随机获取
		 * useZh 是否使用中文验证码
		 * bg 验证码背景颜色 rgb数组设置，例如 array(243, 251, 254)
		 * seKey 验证码的加密密钥
		 * codeSet 验证码字符集合 3.2.1 新增
		 * zhSet 验证码字符集合（中文） 3.2.1 新增
		 */
		$Verify = new \Think\Verify ();
		$Verify->fontSize = $font_size;
		$Verify->length = $length;
		$Verify->imageW = I ( 'get.w' ) ? I ( 'get.w' ) : 0;
		$Verify->imageH = I ( 'get.h' ) ? I ( 'get.h' ) : 0;
		// $Verify->useImgBg = true; // 开启验证码背景图片功能 随机使用 ThinkPHP/Library/Think/Verify/bgs 目录下面的图片
		$Verify->useNoise = false;
		$Verify->codeSet = '0123456789'; // 指定验证码字符
		$Verify->fontttf = '5.ttf'; // 验证码字体使用 ThinkPHP/Library/Think/Verify/ttfs/5.ttf
		$Verify->entry ( $type ); // 传入参数表示指定验证码
	}
	public function check_randcode($type = 'login', $code = '') {
		$verify = new \Think\Verify ();
		$result = $verify->check ( $code, $type );
		$this->ajaxReturn ( $result ? 1 : 0 );
	}
}