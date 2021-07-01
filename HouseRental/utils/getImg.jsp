<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page language="java" import="java.net.*,java.io.*"%>
<%!
public static String GetURLstr(String strUrl)
{
 InputStream in = null;
 OutputStream out = null;
 String strdata = "";
 try
 {
  URL url = new URL(strUrl); // 创建 URL
  in = url.openStream(); // 打开到这个URL的流
  out = System.out;
  // 复制字节到输出流
  byte[] buffer = new byte[96000];
  int bytes_read;
  while ((bytes_read = in.read(buffer)) != -1)
  {
   String reads = new String(buffer, 0, bytes_read, "UTF-8");
   //System.out.print(reads);
   strdata = strdata + reads;
   // out.write(buffer, 0, bytes_read);
  }
  in.close();
  out.close();
  return strdata;
 }
 catch (Exception e)
 {
  System.err.println(e);
  System.err.println("Usage: java GetURL <URL> [<filename>]");
  return strdata;
 }
}
%>
<%
//解决乱码问题
request.setCharacterEncoding("UTF-8"); 
//out.print(GetURLstr("http://jsp.yaoyiwangluo.com/1.jsp"));
String str_code = "";
String pagezhi = "";
String zhi = "";
str_code = request.getParameter("access_token");
pagezhi = request.getParameter("page");
zhi = request.getParameter("scene");
//out.print(str_code);

//https://api.weixin.qq.com/sns/jscode2session?appid=APPID&secret=SECRET&js_code=JSCODE&grant_type=authorization_code
String str_token = "";
str_token = str_token + "https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=";
str_token = str_token + str_code ;
str_token = str_token + "&scene=" + zhi ;
str_token = str_token + "&page=" + pagezhi ;

String neirong_token = "";
neirong_token = GetURLstr(str_token);
out.print(neirong_token);
%>