package com.yff.entity;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用返回对象
 */
public class Msg {
    //返回的响应码,100:成功,200:失败
    private int code;
    //返回的消息
    private String message;
    //返回客户的数据
    private Map<String,Object> data = new HashMap<>();

    public Msg() {

    }

    public Msg(int code,String message) {
        this.code = code;
        this.message = message;
    }

    public static Msg success() {
        Msg msg = new Msg(100,"处理成功!!!");
        return msg;
    }

    public static Msg fail() {
        Msg msg = new Msg(200,"处理失败!!!");
        return msg;
    }

    public Msg put(String key,Object value) {
        this.data.put(key,value);
        return this;
    }

    public Msg putAll(Map<String,Object> map) {
        if(map != null) {
            this.data.putAll(map);
        }
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }
}
