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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%
            try {
              String line;

               String dataDir, jarLocation, java;
               String cmti_usa_dir = "/Volumes/DataDisk/processed/";
               if (new File(cmti_usa_dir).exists()) {
                    java = " /usr/bin/java -Dfile.encoding=UTF-8 ";
                    dataDir = cmti_usa_dir;
                   jarLocation = " /Users/zhiminhe/IdeaProjects/XdrHttp/target/XdrHttp-1.0-SNAPSHOT.jar ";
               } else { // cmi, please modify the parameters below
                    java = "C:\\Java\\jdk1.8.0_111\\bin\\java -Dfile.encoding=UTF-8";
                    dataDir = " C:\\Software\\processed\\";
                    jarLocation = " C:\\Software\\CMIDemo\\src\\main\\webapp\\WEB-INF\\lib\\XdrHttp-1.0-SNAPSHOT.jar ";
               }
              String input = String.format(dataDir + request.getParameter("date") + "%02d" + ".csv",
                Integer.parseInt(request.getParameter("hour")));

              if (new File(input).exists()) {
                  String execStr = java + " -cp " + jarLocation + " Demo "
                   + input + " " + request.getParameter("lat") + " " + request.getParameter("lng") + " "
                   + request.getParameter("radius") + " " + request.getParameter("mcc");
                  // out.println(execStr);
                  Process p = Runtime.getRuntime().exec(execStr);
                  p.waitFor();
                  BufferedReader bri = new BufferedReader
                                  (new InputStreamReader(p.getInputStream()));
                  while ((line = bri.readLine()) != null) {
                    if (line.trim().length() > 0) { // skip empty lines. not sure whey they are there.
                        out.println(line);
                    }
                  }
                 bri.close();
              } else {
                out.println("Error: Data File Does Not Exist");
              }
            }
            catch (Exception err) {
              err.printStackTrace();
            }
        %>