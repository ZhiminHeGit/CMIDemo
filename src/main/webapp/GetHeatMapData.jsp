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
    String date = request.getParameter("date");
    int hour = Integer.parseInt(request.getParameter("hour"));
    String dataDir;
    String cmti_usa_dir = "/Volumes/DataDisk/processed/";
    if (new File(cmti_usa_dir).exists()) {
        dataDir = cmti_usa_dir;
    } else { // cmi, please modify the parameters below
        dataDir = "C:\\Software\\processed\\";
    }
    String heatmap = String.format(dataDir + date + "%02d" + "." + mcc + ".heatmap", hour);
    if (new File(heatmap).exists()) {
        BufferedReader reader = new BufferedReader(new FileReader(heatmap));
        System.out.println(heatmap);
        StringBuilder sb = new StringBuilder();
        String line;
        while((line = reader.readLine())!= null){
            if(sb.length() != 0)
                sb.append(",");
            sb.append(line);
        }
        reader.close();
        out.println(sb.toString());
        reader.close();
    } else {
        out.println("Error: Heatmap Data not exist");
    }



%>
