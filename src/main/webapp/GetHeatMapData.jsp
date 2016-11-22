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
    String mcc = request.getParameter("mcc");
    int absolute_hour =
        Integer.parseInt(request.getParameter("absolute_hour"));
    int day = absolute_hour / 24 + 1;
    int hour = absolute_hour % 24;
    String dataDir;
    String cmti_usa_dir = "/Volumes/DataDisk/processed/";
    if (new File(cmti_usa_dir).exists()) {
        dataDir = cmti_usa_dir;
    } else {
        dataDir = "put in cmi dir";
    }
    String heatmap = String.format(dataDir + "2016100%d%02d.%s.heatmap", day , hour,  mcc);
    BufferedReader reader = new BufferedReader(new FileReader(heatmap));
    System.out.println(heatmap);
    StringBuilder sb = new StringBuilder();
    String line;
    while((line = reader.readLine())!= null){
        if(sb.length() != 0)
            sb.append(",");
        sb.append(line);
    }
    out.println(sb.toString());
%>