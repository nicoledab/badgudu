package user.dto;

import java.sql.Timestamp;

public class noticeDTO 
{
	private int num;				// �۹�ȣ
	private String writer;			// �ۼ���
	private String subject;			// ����
	private String content;			// ����
	private String save;			// ÷������
	private Timestamp reg;			// �ۼ���¥
	private int readcount;			// ��ȸ��
	
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
