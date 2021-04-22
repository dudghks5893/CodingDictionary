package my.util.mail;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailSend {

	private static class SMTPAuthenticator extends Authenticator {
		public PasswordAuthentication getPasswordAuthentication() {
			//네이버 아이디 , 비밀번호
			return new PasswordAuthentication("아이디", "비밀번호");
		}
	}
	
	public static void send(String title, String content, String toEmail) {
		Properties p = new Properties();
		p.put("mail.smtp.host", "smtp.naver.com");
		p.put("mail.smtp.user", "dudghks2814"); 
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true); 
			MimeMessage msg = new MimeMessage(session);
			String message = content;
			msg.setSubject(title);
			//InternetAddress(메일주소, 보내는사람 이름, 문자셋)
			Address fromAddr = new InternetAddress("dudghks2814@naver.com"); 
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(toEmail); 
			msg.addRecipient(Message.RecipientType.TO, toAddr);
			msg.setContent(message, "text/html;charset=KSC5601");
			Transport.send(msg);
			
		} catch (Exception e) { 
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		String title = "JSPStudy에서 새롭게 YouTube 채널 및 모바일웹 포토블로그";
		String content = "<h3>JSPStudy에서 새롭게 YouTube 채널을 시작합니다.</h3>";
		content += "<a href='https://www.youtube.com/channel/UCVrhnbfe78ODeQglXtT1Elw'>";
		content += "<h3>1.JSPStudy 운영자가 직접관리하는 YouTube</h3></a>";
		content += "<img src='http://jspstudy.co.kr/main/images/youtube.jpg'>";
		content += "<br><br>";
		content += "<a href='http://jspstudy.co.kr/main/main.jsp?PATH=/admin/adminRead.jsp?a_num=165&m_num=7&keyField=a_division1&keyWord=notice'>";
		content += "<h3>2.JSP & Servlet 웹 프로그래밍 입문 교재 소스, PPT, 프로그램</h3></a>";
		content += "<img src='http://jspstudy.co.kr/main/images/jsp_bookimg.jpg'>";
		content += "<br><br>";
		content += "<a href='http://jspstudy.co.kr/board/file/etc_03.pdf'>";
		content += "<h3>3.모바일 웹페이지 포토블로그 PDF</h3></a>";
		content += "<img src='http://jspstudy.co.kr/main/images/etc03_1.jpg'>";
		content += "<img src='http://jspstudy.co.kr/main/images/etc03_2.jpg'>";
		content += "<img src='http://jspstudy.co.kr/main/images/etc03_3.jpg'>";
		content += "<img src='http://jspstudy.co.kr/main/images/etc03_4.jpg'>";
		content += "<br><br>";
		content += "<a href='http://JSPStudy.co.kr'><h2>http://JSPStudy.co.kr</h2></a>";
		
		send(title, content, "dudghks5893@naver.com");
		System.out.println("성공~~~~");
	}
}











