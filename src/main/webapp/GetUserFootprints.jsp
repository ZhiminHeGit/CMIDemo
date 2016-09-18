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
<%@page contentType="html/text" pageEncoding="UTF-8"%>
        <%
            String userStr = request.getParameter("imsi");
            String outputFile = "/Users/jianli/Downloads/cmidata/xdr_http/user-trace-with-gps.csv";

            BufferedReader reader = new BufferedReader(new FileReader(outputFile));
            StringBuilder sb = new StringBuilder();

            String line;
            while((line = reader.readLine())!= null){
                String[] parts = line.split(",");
                if((userStr != null && parts[0].contains(userStr)) || userStr == null || userStr.isEmpty()) {
                if(sb.length() != 0)
                    sb.append(",");

                    if(parts.length == 12){

                        sb.append(parts[10]);
                        sb.append(",");
                        sb.append(parts[11]);
                    }
                }
            }

            out.println(sb.toString());
            System.out.println(sb.toString());

        %>