<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Found User Details</title>
    </head>
    <body>
        <%
            String jspPath = "/root/";
            String fileName = "hk_visitors.csv";
            String txtFilePath = jspPath + fileName;
            BufferedReader reader = new BufferedReader(new FileReader(txtFilePath));

            out.println("<table border=\"1\">");
            String line;

            while((line = reader.readLine())!= null){
                String[] parts = line.split(",");
                out.println("<tr>");
                for(int i = 0; i < parts.length - 1; i++){
                    out.println("<td>" + parts[i] + "</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>");
        %>

    </body>
</html>