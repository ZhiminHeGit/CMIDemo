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
              String execStr = "/usr/bin/java -cp /Users/zhiminhe/IdeaProjects/XdrHttp/target/XdrHttp-1.0-SNAPSHOT.jar Demo " +
               request.getParameter("lat") + " " + request.getParameter("lng") + " " + request.getParameter("radius");
              Process p = Runtime.getRuntime().exec(execStr);
              p.waitFor();
              BufferedReader bri = new BufferedReader
                              (new InputStreamReader(p.getInputStream()));
              while ((line = bri.readLine()) != null) {
                if (line.length() > 5) { // skip empty lines. not sure whey they are there.
                    out.println(line);
                }
              }
            }
            catch (Exception err) {
              err.printStackTrace();
            }
        %>