package com.b5m.cpsx.model;

public class ControllerMessage {
	private boolean statue=true;
	private String message;
	private Object data;

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public ControllerMessage(boolean statue, String message) {
		super();
		this.statue = statue;
		this.message = message;
	}
	public ControllerMessage(boolean statue, String message ,Object data) {
		super();
		this.statue = statue;
		this.message = message;
		this.data=data;
	}

	public ControllerMessage() {
		super();
	}

	public boolean isStatue() {
		return statue;
	}

	public void setStatue(boolean statue) {
		this.statue = statue;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	
}
