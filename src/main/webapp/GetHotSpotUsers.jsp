<%@page import="java.io.*"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.lang.Thread"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>当前移动热点用户</title>
    </head>
    <body>
    <script>
        function getUserTrace() {
          var e = document.getElementById("hotspots");
          var imsi = e.options[e.selectedIndex].text;
          var url = "DisplayFootPrint.jsp?imsi=" + imsi;
          window.location.href = url;
        }
    </script>
    <h1>当前移动热点用户及其轨迹展示</h1>
        <%
            BufferedReader reader = new BufferedReader(new FileReader("/Users/jianli/Downloads/cmidata/xdr_http/raw/hotspot-imsis.csv"));
            StringBuilder sb = new StringBuilder();
            sb.append("<select id='hotspots' name='hotspots'>");
            String line;
            Random r = new Random(100);
            int index = 1;
            while((line = reader.readLine())!= null){
                if(r.nextInt() > 50){
                    String s = "<option value=\"" + index + "\">" + line + "</option>";
                    sb.append(s);
                    index++;
                }
            }
            sb.append("</select>");
            sb.append("<input type='button' onclick='getUserTrace()' value='显示用户轨迹'>");

            out.println(sb.toString());
            System.out.println(sb.toString());

        %>
    </body>
</html>