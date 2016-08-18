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
            String latitudeStr = request.getParameter("lat");
            System.out.println(new java.util.Date() + " lat: " + latitudeStr);
            String longitudeStr = request.getParameter("lng");
            System.out.println("lng: " + longitudeStr);
            String radiusStr = request.getParameter("radius");
            System.out.println("radius: " + radiusStr);
            Random random = new Random();
            String outputFile = "/tmp/stations" + random.nextLong() + ".csv";

            try {
              String line;
              String execStr = "/usr/bin/java -jar /root/FindBaseStations.jar /Users/jianli/Downloads/cmidata/xdr_http/raw/cell_towers_select.csv " + outputFile + " TAB " + latitudeStr + " " + longitudeStr + " " + radiusStr;

              System.out.println("Will execute: " + execStr);
              Process p = Runtime.getRuntime().exec(execStr);
              BufferedReader bri = new BufferedReader
                (new InputStreamReader(p.getInputStream()));
              BufferedReader bre = new BufferedReader
                (new InputStreamReader(p.getErrorStream()));
              while ((line = bri.readLine()) != null) {
                System.out.println(line);
              }
              bri.close();
              while ((line = bre.readLine()) != null) {
                System.out.println(line);
              }
              bre.close();
              p.waitFor();
              System.out.println("Done.");
            }
            catch (Exception err) {
              err.printStackTrace();
            }

            BufferedReader reader = new BufferedReader(new FileReader(outputFile));
            StringBuilder sb = new StringBuilder();

            String line;
            int count = 0;
            List<String> stationList = new ArrayList<String>();
            while((line = reader.readLine())!= null){
                if(sb.length() != 0)
                    sb.append(",");
                sb.append(line);
            }

            out.println(sb.toString());
            System.out.println(sb.toString());

        %>