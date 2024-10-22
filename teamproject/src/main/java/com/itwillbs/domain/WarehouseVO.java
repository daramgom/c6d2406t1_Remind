package com.itwillbs.domain; // 이 클래스가 속한 패키지

import java.util.List; // List 사용을 위해 import

// WarehouseVO 클래스는 창고 정보를 저장하는 Value Object입니다.
public class WarehouseVO {
    // 창고 번호 (고유 식별자)
    private int wh_number; // 창고 번호

    // 창고 이름
    private String wh_name; // 창고 이름

    // 창고 위치
    private String wh_location; // 창고 위치

    // 창고 등록 사용자
    private String wh_reguser; // 창고 등록 사용자

    // 창고 수정 사용자
    private String wh_updateuser; // 창고 수정 사용자

    // 창고 담당자
    private String wh_admin; // 창고 담당자

    // 제품 ID
    private String prod_id; // 제품 ID

    // 제품 이름
    private String prod_name; // 제품 이름

    // 제품 수량
    private int prod_qty; // 제품 수량

    // 삭제 상태
    private String is_deleted; // 삭제 상태 ('01' 또는 '02')

    // 위도
    private double latitude; // 위도

    // 경도
    private double longitude; // 경도

    // Getter 및 Setter 메서드

    public int getWh_number() {
        return wh_number;
    }

    public void setWh_number(int wh_number) {
        this.wh_number = wh_number;
    }

    public String getWh_name() {
        return wh_name;
    }

    public void setWh_name(String wh_name) {
        this.wh_name = wh_name;
    }

    public String getWh_location() {
        return wh_location;
    }

    public void setWh_location(String wh_location) {
        this.wh_location = wh_location;
    }

    public String getWh_reguser() {
        return wh_reguser;
    }

    public void setWh_reguser(String wh_reguser) {
        this.wh_reguser = wh_reguser;
    }

    public String getWh_updateuser() {
        return wh_updateuser;
    }

    public void setWh_updateuser(String wh_updateuser) {
        this.wh_updateuser = wh_updateuser;
    }

    public String getWh_admin() {
        return wh_admin;
    }

    public void setWh_admin(String wh_admin) {
        this.wh_admin = wh_admin;
    }

    // 제품 ID를 반환하는 메서드
    public String getProd_id() {
        return prod_id;
    }

    // 제품 ID를 설정하는 메서드
    public void setProd_id(String prod_id) {
        this.prod_id = prod_id;
    }

    // 제품 이름을 반환하는 메서드
    public String getProd_name() {
        return prod_name;
    }

    // 제품 이름을 설정하는 메서드
    public void setProd_name(String prod_name) {
        this.prod_name = prod_name;
    }

    // 제품 수량을 반환하는 메서드
    public int getProd_qty() {
        return prod_qty;
    }

    // 제품 수량을 설정하는 메서드
    public void setProd_qty(int prod_qty) {
        this.prod_qty = prod_qty;
    }

    // 삭제 상태를 반환하는 메서드
    public String getIs_deleted() {
        return is_deleted;
    }

    // 삭제 상태를 설정하는 메서드
    public void setIs_deleted(String is_deleted) {
        this.is_deleted = is_deleted;
    }

    // 위도를 반환하는 메서드
    public double getLatitude() {
        return latitude;
    }

    // 위도를 설정하는 메서드
    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    // 경도를 반환하는 메서드
    public double getLongitude() {
        return longitude;
    }

    // 경도를 설정하는 메서드
    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}
