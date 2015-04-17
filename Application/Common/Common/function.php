<?php
/**
 * 邮件发送函数
 * @param unknown $to
 * @param unknown $subject
 * @param unknown $content
 * @return boolean
 */
function send_email($to, $subject, $content) {
	vendor ( 'PHPMailer.PHPMailerAutoload' );
	
	$mail = new PHPMailer (); // 实例化
	$mail->IsSMTP (); // 启用SMTP
	$mail->Host = C ( 'MAIL_HOST' ); // smtp服务器的名称（这里以126邮箱为例）
	$mail->SMTPAuth = C ( 'MAIL_SMTPAUTH' ); // 启用smtp认证
	$mail->Username = C ( 'MAIL_USERNAME' ); // 你的邮箱名
	$mail->Password = C ( 'MAIL_PASSWORD' ); // 邮箱密码
	$mail->From = C ( 'MAIL_FROM' ); // 发件人地址（也就是你的邮箱地址）
	$mail->FromName = C ( 'MAIL_FROMNAME' ); // 发件人姓名
	$mail->SMTPDebug = 0;
	$mail->Timeout = 15;
	$mail->AddAddress ( $to, "name" );
	$mail->WordWrap = 50; // 设置每行字符长度
	$mail->IsHTML ( C ( 'MAIL_ISHTML' ) ); // 是否HTML格式邮件
	$mail->CharSet = C ( 'MAIL_CHARSET' ); // 设置邮件编码
	$mail->Subject = $subject; // 邮件主题
	$mail->Body = $content; // 邮件内容
	$mail->AltBody = ""; // 邮件正文不支持HTML的备用显示
	if (! $mail->Send ()) {
		Think\Log::write ( 'Mailer Error: ' . $mail->ErrorInfo, 'ERROR' );
		return false;
	} else {
		return true;
	}
}
function authcode($string, $operation = 'DECODE', $key = '', $expiry = 0) {
	$ckey_length = 4;
	
	$key = md5 ( $key ? $key : C ( "AUTHCODE" ) );
	$keya = md5 ( substr ( $key, 0, 16 ) );
	$keyb = md5 ( substr ( $key, 16, 16 ) );
	$keyc = $ckey_length ? ($operation == 'DECODE' ? substr ( $string, 0, $ckey_length ) : substr ( md5 ( microtime () ), - $ckey_length )) : '';
	
	$cryptkey = $keya . md5 ( $keya . $keyc );
	$key_length = strlen ( $cryptkey );
	
	$string = $operation == 'DECODE' ? base64_decode ( substr ( $string, $ckey_length ) ) : sprintf ( '%010d', $expiry ? $expiry + time () : 0 ) . substr ( md5 ( $string . $keyb ), 0, 16 ) . $string;
	$string_length = strlen ( $string );
	
	$result = '';
	$box = range ( 0, 255 );
	
	$rndkey = array ();
	for($i = 0; $i <= 255; $i ++) {
		$rndkey [$i] = ord ( $cryptkey [$i % $key_length] );
	}
	
	for($j = $i = 0; $i < 256; $i ++) {
		$j = ($j + $box [$i] + $rndkey [$i]) % 256;
		$tmp = $box [$i];
		$box [$i] = $box [$j];
		$box [$j] = $tmp;
	}
	
	for($a = $j = $i = 0; $i < $string_length; $i ++) {
		$a = ($a + 1) % 256;
		$j = ($j + $box [$a]) % 256;
		$tmp = $box [$a];
		$box [$a] = $box [$j];
		$box [$j] = $tmp;
		$result .= chr ( ord ( $string [$i] ) ^ ($box [($box [$a] + $box [$j]) % 256]) );
	}
	
	if ($operation == 'DECODE') {
		if ((substr ( $result, 0, 10 ) == 0 || substr ( $result, 0, 10 ) - time () > 0) && substr ( $result, 10, 16 ) == substr ( md5 ( substr ( $result, 26 ) . $keyb ), 0, 16 )) {
			return substr ( $result, 26 );
		} else {
			return '';
		}
	} else {
		return $keyc . str_replace ( '=', '', base64_encode ( $result ) );
	}
}
/**
 * 加密字符串
 * 
 * @param unknown $string        	
 * @return string
 */
function authencode($string) {
	return authcode ( $string, "ENCODE" );
}
/**
 * 获取相对地址
 * 
 * @param unknown $url        	
 * @return string|mixed
 */
function get_relative_url($url) {
	if (strpos ( $url, "http" ) === 0) {
		$url = str_replace ( array ("https://","http://" ), "", $url );
		
		$pos = strpos ( $url, "/" );
		if ($pos === false) {
			return "";
		} else {
			$url = substr ( $url, $pos + 1 );
			$root = preg_replace ( "/^\//", "", __ROOT__ );
			$root = str_replace ( "/", "\/", $root );
			$url = preg_replace ( "/^" . $root . "\//", "", $url );
			return $url;
		}
	}
	return $url;
}
