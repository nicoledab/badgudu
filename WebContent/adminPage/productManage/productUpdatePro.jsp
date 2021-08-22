<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.io.File" %>
<%@ page import="admin.dto.UpdateDTO" %>
<%@ page import="admin.dao.ProductDAO2" %>

<!-- ���� -->
<%
   request.setCharacterEncoding("UTF-8"); 
   String savePath = request.getRealPath("productImg"); //save���� ����
   int maxSize = 1024*1024*30; //30MB
   String enc = "UTF-8"; //�ѱ����ϸ� ���ڵ�
   DefaultFileRenamePolicy drp = new DefaultFileRenamePolicy(); //���������
   MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, enc, drp);
   
   Enumeration enu = mr.getFileNames();
   String originName="";
   while(enu.hasMoreElements()){
      String name = (String)enu.nextElement();
      String type=mr.getContentType(name);
      if(type != null){
         String [] t = type.split("/");
         if(t[0].equals("image")) {
            out.println("<h1>���ε� ����</h1>");
         }else{
            out.println("<h1>�̹����� �ƴմϴ�.");
            File f = mr.getFile(name);
            f.delete();
         }   
      }
   }
   
   String colorOri="";
   for(String c : mr.getParameterValues("colorOrigin")){
	   colorOri += c+" ";
   }
   
   String sizeOri="";
   for(String s : mr.getParameterValues("sizeOrigin")){
	   sizeOri += s+" ";
   }
   String qtyOri="";
   for(String q : mr.getParameterValues("qtyOrigin")){
	   qtyOri += q+" ";
   }
  
   
   String productImg1 = mr.getFilesystemName("productImg1");
   String productImg2 = mr.getFilesystemName("productImg2");
   String productImg3 = mr.getFilesystemName("productImg3");
   String productDetailImg1 = mr.getFilesystemName("productDetailImg1");
   String productDetailImg2 = mr.getFilesystemName("productDetailImg2");
   
  
   
   
   
	// �Ķ���� ���� ������ ��: ���� ���ε� �ؼ�

   int pdCode = Integer.parseInt(mr.getParameter("pdCode")); // pdCode

   String display = mr.getParameter("display");
   int pdCategory = Integer.parseInt(mr.getParameter("pdCategory"));
   String productName = mr.getParameter("productName");
   String pdExplain = mr.getParameter("pdExplain");
   String pdDetailExplain = mr.getParameter("pdDetailExplain");
   int supplyPrice = Integer.parseInt(mr.getParameter("supplyPrice"));
   int sellingPrice = Integer.parseInt(mr.getParameter("sellingPrice"));
   int sale = Integer.parseInt(mr.getParameter("sale"));
   int event = Integer.parseInt(mr.getParameter("event"));
   
   //���� �ɼ�
   String [] colorOrigin = colorOri.split(" ");
   String [] sizeOrigin = sizeOri.split(" ");
   String [] qtyOrigin = qtyOri.split(" ");
   
   // �Ķ���ͷ� ���� �� dto�� ����
   UpdateDTO dto = new UpdateDTO();
   dto.setPdCode(pdCode);

   //product
   dto.setDisplay(display);
   dto.setPdCategory(pdCategory);
   dto.setProductName(productName);
   dto.setPdExplain(pdExplain);
   dto.setPdDetailExplain(pdDetailExplain);
   dto.setSupplyPrice(supplyPrice);
   dto.setSellingPrice(sellingPrice);
   dto.setProductqty(qtyOri);
   dto.setColor1(colorOri);
   dto.setSize1(sizeOri);
   dto.setSale(sale);
   dto.setEvent(event);
   
   //stock update
   dto.setColorOrigin(colorOrigin);
   dto.setSizeOrigin(sizeOrigin);
   dto.setQtyOrigin(qtyOrigin);
   


   ProductDAO2 dao = new ProductDAO2();
   dao.productUpdate(dto);
   dao.stockUpdate(dto);
   
   //�̹��� ������Ʈ ���� ��� ó��
if (productImg1 == null && productImg2==null && productImg3 == null && productDetailImg1 == null && productDetailImg2 == null){
		
   } else{
	   if(mr.getFilesystemName("productImg1")==null){
		   productImg1 = mr.getParameter("pdimg1");
	   }else {
		   productImg1 = mr.getFilesystemName("productImg1");
	   }
	   if(mr.getFilesystemName("productImg2")==null){
		   productImg2 = mr.getParameter("pdimg2");
	   }else {
		   productImg2 = mr.getFilesystemName("productImg2");
	   }
	   if(mr.getFilesystemName("productImg3")==null){
		   productImg3 = mr.getParameter("pdimg3");
	   }else {
		   productImg3 = mr.getFilesystemName("productImg3");
	   }
	   if(mr.getFilesystemName("productDetailImg1")==null){
		   productDetailImg1 = mr.getParameter("pddtimg1");
	   }else{
		   productDetailImg1 = mr.getFilesystemName("productDetailImg1");
	   }
	   if(mr.getFilesystemName("productDetailImg2")==null){
		   productDetailImg2 = mr.getParameter("pddtimg2");
	   }else{
		   productDetailImg2 = mr.getFilesystemName("productDetailImg2");
	   }
	   //image update
	   dto.setProductImg1(productImg1);
	   dto.setProductImg2(productImg2);
	   dto.setProductImg3(productImg3);
	   dto.setProductDetailImg1(productDetailImg1);
	   dto.setProductDetailImg2(productDetailImg2);
	   dao.imageUpdate(dto);
   }
   
   
   
   //��ǰ�ɼ��߰�
   if(mr.getParameterValues("cl")==null||mr.getParameterValues("sz")==null||mr.getParameterValues("qty")==null){
	   %>�߰��ɼ� ����<%
   }else{
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
	   	
	  	String [] co = color.split(" ");
	    String [] si = size.split(" ");
	    String [] qt = qty.split(" ");
	    
	  	dto.setCl(co);
	    dto.setSz(si);
	    dto.setQty(qt);
	    dao.stockAdd(dto);
	    dao.productUp(dto);
   }
	   
   
   
   
//   dao.productInsert(dto);
//   dao.stockInsert(dto);
//   dao.imgInsert(dto);
%>

	<script>
		alert("�����Ǿ����ϴ�.");
		location="productListBoard.jsp?";
	</script>
