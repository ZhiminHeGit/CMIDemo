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
            try {
              String line;

               String dataDir, jarLocation, java;
               String cmti_usa_dir = "/Volumes/DataDisk/processed/";
               if (new File(cmti_usa_dir).exists()) {
                    java = " /usr/bin/java -Dfile.encoding=UTF-8 ";
                    dataDir = cmti_usa_dir;
                    jarLocation = " /Users/zhiminhe/IdeaProjects/XdrHttp/target/XdrHttp-1.0-SNAPSHOT.jar ";
               } else { // cmi, please modify the parameters below
                    java = " put in cmi java location";
                    dataDir = "put in cmi dir";
                    jarLocation = "put in cmi jar location of backend (XdrHttp)";
               }
              String execStr = java + " -cp " + jarLocation + " Demo "
               + dataDir + " " + request.getParameter("lat") + " " + request.getParameter("lng") + " "
               + request.getParameter("radius") + " " +
               request.getParameter("absolute_hour");
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
            }
            catch (Exception err) {
              err.printStackTrace();
            }
        %>