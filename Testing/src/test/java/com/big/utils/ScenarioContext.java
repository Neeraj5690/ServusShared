package com.big.utils;

import java.util.HashMap;
import java.util.Map;


public class ScenarioContext {

	protected Map<String, Object> scenarioContext;
	
	public ScenarioContext() {
		scenarioContext = new HashMap<String, Object>();
	}
	public void setContext(Variables key, Object value) {
		scenarioContext.put(key.toString(), value);
	}
	
	public Object getContext(Variables key) {
		return scenarioContext.get(key.toString());
	}
}
