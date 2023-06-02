package com.big.utils;

import org.testng.IRetryAnalyzer;
import org.testng.ITestResult;

import com.aventstack.extentreports.Status;
public class TestNgRetryFailedTest implements IRetryAnalyzer {
    private int count = 0;
    private static int maxTry = 1;
    @Override
    public boolean retry(ITestResult iTestResult) {
        if (!iTestResult.isSuccess()) {                      
            if (count < maxTry) {                            
                count++;                                     
                iTestResult.setStatus(ITestResult.FAILURE);  
                return true;                                 
            } else {
                iTestResult.setStatus(ITestResult.FAILURE);  
            }
        } else {
            iTestResult.setStatus(ITestResult.SUCCESS);     
        }
        return false;
    }
    
 }
