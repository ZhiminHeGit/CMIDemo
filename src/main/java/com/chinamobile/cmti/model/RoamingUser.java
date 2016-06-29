package com.chinamobile.cmti.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class RoamingUser implements Serializable {

    private static final long serialVersionUID = 1L;
    private static final char COMMA = ',';
    private static final String DATE_FORMAT_NO_TIME = "yyyyMMdd";
    private static final SimpleDateFormat SIMPLE_DATE_FORMAT_NO_TIME = new SimpleDateFormat(DATE_FORMAT_NO_TIME);

    private long phoneNumber, imsi;
    private int mnc, mcc;
    private String ruleName;
    private Date visitdate;

    public RoamingUser(long phoneNumber, long imsi, int mnc, int mcc, String ruleName, Date visitdate) {
        this.phoneNumber = phoneNumber;
        this.imsi = imsi;
        this.mnc = mnc;
        this.mcc = mcc;
        this.ruleName = ruleName;
        this.visitdate = visitdate;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public long getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(long phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public long getImsi() {
        return imsi;
    }

    public void setImsi(long imsi) {
        this.imsi = imsi;
    }

    public int getMnc() {
        return mnc;
    }

    public void setMnc(int mnc) {
        this.mnc = mnc;
    }

    public int getMcc() {
        return mcc;
    }

    public void setMcc(int mcc) {
        this.mcc = mcc;
    }

    public String getRuleName() {
        return ruleName;
    }

    public void setRuleName(String ruleName) {
        this.ruleName = ruleName;
    }

    public Date getVisitdate() {
        return visitdate;
    }

    public void setVisitdate(Date visitdate) {
        this.visitdate = visitdate;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(phoneNumber);
        sb.append(COMMA);
        sb.append(imsi);
        sb.append(SIMPLE_DATE_FORMAT_NO_TIME.format(getVisitdate()));
        sb.append(COMMA);
        sb.append(mnc);
        sb.append(COMMA);
        sb.append(mcc);
        sb.append(COMMA);
        sb.append(ruleName);

        return sb.toString();
    }

}
