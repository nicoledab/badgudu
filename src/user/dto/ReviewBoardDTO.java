package user.dto;

import java.sql.Timestamp;

public class ReviewBoardDTO {
 private int num;
 private String writer;
 private String subject;
 private String content;
 private String save;
 private Timestamp reg_date;
 private int readcount;
 
 private int status;
 private int ref_step;
 
 
 
 


public int getStatus() {
	return status;
}
public void setStatus(int status) {
	this.status = status;
}
public int getRef_step() {
	return ref_step;
}
public void setRef_step(int ref_step) {
	this.ref_step = ref_step;
}
public int getNum() {
	return num;
}
public void setNum(int num) {
	this.num = num;
}
public String getWriter() {
	return writer;
}
public void setWriter(String writer) {
	this.writer = writer;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}


public String getSave() {
	return save;
}
public void setSave(String save) {
	this.save = save;
}

public Timestamp getReg_date() {
	return reg_date;
}
public void setReg_date(Timestamp reg_date) {
	this.reg_date = reg_date;
}
public int getReadcount() {
	return readcount;
}
public void setReadcount(int readcount) {
	this.readcount = readcount;
}
public String getIp() {
	return ip;
}
public void setIp(String ip) {
	this.ip = ip;
}
public int getRef() {
	return ref;
}
public void setRef(int ref) {
	this.ref = ref;
}
public int getRe_step() {
	return re_step;
}
public void setRe_step(int re_step) {
	this.re_step = re_step;
}
public int getRe_level() {
	return re_level;
}
public void setRe_level(int re_level) {
	this.re_level = re_level;
}
private String ip;
 private int ref;
 private int re_step;	
 private int re_level;
	
}



