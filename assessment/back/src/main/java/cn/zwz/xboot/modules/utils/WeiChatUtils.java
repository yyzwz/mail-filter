package cn.zwz.xboot.modules.utils;

import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.DingRosterUser;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.xxpt.gateway.shared.client.http.ExecutableClient;
import com.alibaba.xxpt.gateway.shared.client.http.GetClient;
import com.alibaba.xxpt.gateway.shared.client.http.PostClient;
import com.google.gson.JsonObject;
import lombok.Data;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.net.ssl.*;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

public class WeiChatUtils implements X509TrustManager {

    public static String getToken(){
        ExecutableClient executableClient =ExecutableClient.getInstance();
        executableClient.setAccessKey("CJKH-2vV9AaHI0xyyALw1qxmYJVNBv");
        executableClient.setSecretKey("2w052keMJaxc4vR9NRXEJFNsSi4hqTh03C7a82wd");
        executableClient.setDomainName("openplatform.dg-work.cn");
        executableClient.setProtocal("https");
        executableClient.init();
        String api = "/gettoken.json";
        GetClient getClient = executableClient.newGetClient(api);
        getClient.addParameter("appkey", "CJKH-2vV9AaHI0xyyALw1qxmYJVNBv");
        getClient.addParameter("appsecret", "2w052keMJaxc4vR9NRXEJFNsSi4hqTh03C7a82wd");
        String apiResult = getClient.get();
        JSONObject json1 = JSONObject.parseObject(apiResult);
        JSONObject json2 = json1.getJSONObject("content");
        JSONObject json3 = json2.getJSONObject("data");
        String accessToken = json3.getString("accessToken");
        return accessToken;
    }
    // https://artskyhome.com:8080/xboot/a7SManger/getAll






    @Override
    public void checkClientTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {

    }

    @Override
    public void checkServerTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {

    }

    @Override
    public X509Certificate[] getAcceptedIssuers() {
        return null;
    }

    /*
     * 处理https GET/POST请求
     * 请求地址、请求方法、参数
     * */
    public static String httpsRequest(String requestUrl,String requestMethod,String outputStr){
        StringBuffer buffer=null;
        try{
            //创建SSLContext
            SSLContext sslContext=SSLContext.getInstance("SSL");
            TrustManager[] tm={new WeiChatUtils()};
            //初始化
            sslContext.init(null, tm, new java.security.SecureRandom());;
            //获取SSLSocketFactory对象
            SSLSocketFactory ssf=sslContext.getSocketFactory();
            URL url=new URL(requestUrl);
            HttpsURLConnection conn=(HttpsURLConnection)url.openConnection();
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod(requestMethod);
            //设置当前实例使用的SSLSoctetFactory
            conn.setSSLSocketFactory(ssf);
            conn.connect();
            //往服务器端写内容
            if(null!=outputStr){
                OutputStream os=conn.getOutputStream();
                os.write(outputStr.getBytes("utf-8"));
                os.close();
            }

            //读取服务器端返回的内容
            InputStream is=conn.getInputStream();
            InputStreamReader isr=new InputStreamReader(is,"utf-8");
            BufferedReader br=new BufferedReader(isr);
            buffer=new StringBuffer();
            String line=null;
            while((line=br.readLine())!=null){
                buffer.append(line);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return buffer.toString();
    }

    /**
     * 处理一卡通的请求
     * @param requestUrl
     * @param requestMethod
     * @param outputStr
     * @return
     */
    public static String httpsCardsRequest(String requestUrl,String requestMethod,String outputStr){
        StringBuffer buffer=null;
        try{
            //创建SSLContext
            SSLContext sslContext=SSLContext.getInstance("SSL");
            TrustManager[] tm={new WeiChatUtils()};
            //初始化
            sslContext.init(null, tm, new java.security.SecureRandom());;
            //获取SSLSocketFactory对象
            SSLSocketFactory ssf=sslContext.getSocketFactory();
            URL url=new URL(requestUrl);
            HttpsURLConnection conn=(HttpsURLConnection)url.openConnection();
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestProperty("Content-type", "application/json");
            conn.setRequestMethod(requestMethod);
            //设置当前实例使用的SSLSoctetFactory
            conn.setSSLSocketFactory(ssf);
            conn.connect();
            //往服务器端写内容
            if(null!=outputStr){
                OutputStream os=conn.getOutputStream();
                os.write(outputStr.getBytes("utf-8"));
                os.close();
            }

            //读取服务器端返回的内容
            InputStream is=conn.getInputStream();
            InputStreamReader isr=new InputStreamReader(is,"utf-8");
            BufferedReader br=new BufferedReader(isr);
            buffer=new StringBuffer();
            String line=null;
            while((line=br.readLine())!=null){
                buffer.append(line);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return buffer.toString();
    }
}
