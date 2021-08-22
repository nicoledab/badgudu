package user.dto;

import java.sql.Timestamp;

public class noticeDTO 
{
	private int num;				// 글번호
	private String writer;			// 작성자
	private String subject;			// 제목
	private String content;			// 내용
	private String save;			// 첨부파일
	private Timestamp reg;			// 작성날짜
	private int readcount;			// 조회수
	
	public int getReadcount() {		return readcount;	}
	public void setReadcount(int readcount) {		this.readcount = readcount;	}
	
	public int getNum() {		return num;	}
	public void setNum(int num) {		this.num = num;	}
	
	public String getWriter() {		return writer;	}
	public void setWriter(String writer) {		this.writer = writer;	}
	
	public String getSubject() {		return subject;	}
	public void setSubject(String subject) {		this.subject = subject;	}
	
	public String getContent() {		return content;	}
	public void setContent(String content) {		this.content = content;	}
	
	public String getSave() {		return save;	}
	public void setSave(String save) {		this.save = save;	}
	
	public Timestamp getReg() {		return reg;	}
	public void setReg(Timestamp reg) {		this.reg = reg;	}
}
