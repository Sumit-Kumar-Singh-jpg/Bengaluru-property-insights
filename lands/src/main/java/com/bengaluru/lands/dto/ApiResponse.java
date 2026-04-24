package com.bengaluru.lands.dto;

// Generic class - <T> means type parameter
public class ApiResponse<T> {
    public String message;
    public T data;
    
    public ApiResponse(String message, T data) {
        this.message = message;
        this.data = data;
    }
}