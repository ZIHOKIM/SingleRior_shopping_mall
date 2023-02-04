package com.E1I4.project.member.model.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailSendService {
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber; 
	
	// 회원가입 인증 난수
	public void randomNumber() {
		Random r = new Random();
		int randomNo = r.nextInt(999999);
		System.out.println("인증번호 : " + randomNo);
		authNumber = randomNo;
	}
	
	// 회원가입 본인 인증
	public String sendEmail(String email) {
		randomNumber();
		String setFrom = "singlerior8080@gmail.com"; 
		String toMail = email;
		String title = "SingleRior 회원 가입 인증 이메일 입니다."; 
		String content = 
				"SingleRior를 방문해주셔서 감사합니다." + "<br><br>" +  "인증 번호는 " + authNumber + "입니다." +  "<br>" +  "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; 
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}
	
	// 아이디 찾기
	public void findId(String email, String id) {

		String setFrom = "singlerior"; 
		String toMail = email;
		String title = "싱글리어 아이디 찾기입니다."; 
		String content = "SingleRior를 방문해주셔서 감사합니다." + "<br><br>" +  "회원님의 아이디는 " + id + "입니다." +  "<br>" + "해당 아이디로 로그인해주세요.";
		mailSend(setFrom, toMail, title, content);
		
	}
	
	
	public String getTempPassword(){
        char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        String str = "";

        int idx = 0;
        for (int i = 0; i < 10; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
        }
        
        return str;
    }
	
	public String findPwd(String email) {
		
		String str = getTempPassword();
		System.out.println("임시비밀번호: " +str);
		
		String setFrom = "singlerior8080@gmail.com"; 
		String toMail = email;
		String title = "싱글리어에서 임시 비밀번호를 발급해드립니다.";
		String content = "SingleRior를 방문해주셔서 감사합니다." +  "<br><br>" +  "회원님의 새로운 비밀번호는 " + str + " 입니다." +  "<br>" +  "해당 비밀번호로 로그인 하신 후, 반드시 비밀번호를 다시 변경해주세요. ";
		mailSend(setFrom, toMail, title, content);
		return str;
	}
	
	public void mailSend(String setFrom, String toMail, String title, String content) { 
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
