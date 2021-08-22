<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>productRegFormPro.jsp</h1>

<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.io.File" %>
<%@ page import="admin.dto.ProductDTO" %>
<%@ page import="admin.dao.ProductDAO" %>


<%
	request.setCharacterEncoding("UTF-8"); 
	String savePath = request.getRealPath("productImg"); //save폴더 저장
	int maxSize = 1024*1024*30; //30MB
	String enc = "UTF-8"; //한글파일명 인코딩
	DefaultFileRenamePolicy drp = new DefaultFileRenamePolicy(); //덮어씌우기방지
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, enc, drp);
	
	Enumeration enu = mr.getFileNames();
	String originName="";
	while(enu.hasMoreElements()){
		String name = (String)enu.nextElement();
		String type=mr.getContentType(name);
		if(type != null){
			String [] t = type.split("/");
			if(t[0].equals("image")) {
				out.println("<h1>업로드 성공</h1>");
			}else{
				out.println("<h1>이미지가 아닙니다.");
				File f = mr.getFile(name);
				f.delete();
			}	
		}
	}
	
	String color="";
	for (String c : mr.getParameterValues("cl")){
		color += c+" ";
	}
	String size="";
	for (String s : mr.getParameterValues("sz")){
		size += s+" ";
	}
	String qty="";
	for(String q : mr.getParameterValues("qty")){
		qty += q+" ";
	}

	String display = mr.getParameter("display");
	int pdCategory = Integer.parseInt(mr.getParameter("pdCategory"));
	String productName = mr.getParameter("productName");
	String pdExplain = mr.getParameter("pdExplain");
	String pdDetailExplain = mr.getParameter("pdDetailExplain");
	int supplyPrice = Integer.parseInt(mr.getParameter("supplyPrice"));
	int sellingPrice = Integer.parseInt(mr.getParameter("sellingPrice"));
	String [] co = color.split(" ");
	String [] si = size.split(" ");
	String [] qt = qty.split(" ");
	String productImg1 = mr.getFilesystemName("productImg1");
	String productImg2 = mr.getFilesystemName("productImg2");
	String productImg3 = mr.getFilesystemName("productImg3");
	String productDetailImg1 = mr.getFilesystemName("productDetailImg1");
	String productDetailImg2 = mr.getFilesystemName("productDetailImg2");
	
	
	
	ProductDTO dto = new ProductDTO();
	dto.setDisplay(display);
	dto.setPdCategory(pdCategory);
	dto.setProductName(productName);
	dto.setPdExplain(pdExplain);
	dto.setPdDetailExplain(pdDetailExplain);
	dto.setSupplyPrice(supplyPrice);
	dto.setSellingPrice(sellingPrice);
	dto.setCl(co);
	dto.setSz(si);
	dto.setQty(qt);
	dto.setProductImg1(productImg1);
	dto.setProductImg2(productImg2);
	dto.setProductImg3(productImg3);
	dto.setProductDetailImg1(productDetailImg1);
	dto.setProductDetailImg2(productDetailImg2);
	

	ProductDAO dao = new ProductDAO();
	dao.productInsert(dto);
	dao.stockInsert(dto);
	dao.imgInsert(dto);
%>

	<script>
		alert("상품등록이 완료되었습니다.");
		location.href = "productListBoard.jsp";
	</script>

