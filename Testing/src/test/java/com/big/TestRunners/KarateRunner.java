package com.big.TestRunners;

import org.junit.runner.RunWith;

import static org.junit.Assert.*;
import static org.testng.Assert.assertEquals;

import org.junit.Test;
//import features.APIfeatures.ReportHook;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
//@RunWith(Karate.class)
//@KarateOptions(features = "classpath:com/big/features/APIfeatures/KarateUI.feature")
public class KarateRunner {
	@Test
    public void testParallel(){
       Results results = Runner.path("classpath:com/big/features")
                       //.hook(new ReportHook()) hidded by me hooks are used for extent reporting
    		   .parallel(1);

       assertEquals(0, results.getFailCount(), results.getErrorMessages());
   }
}
