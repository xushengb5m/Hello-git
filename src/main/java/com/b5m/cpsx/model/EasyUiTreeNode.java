package com.b5m.cpsx.model;

import java.util.ArrayList;
import java.util.List;

/**
 * @author chenhao jquery easyuitree的节点公共类
 */
public class EasyUiTreeNode<T> {

	private String text;
	private List<T> children = new ArrayList<T>();
	private String state;
	private boolean definedState = false;

	public boolean isDefinedState() {
		return definedState;
	}

	public void setDefinedState(boolean definedState) {
		this.definedState = definedState;
	}

	public String getState() {
		if (!this.definedState) {
			if (children.size() > 0) {
				this.state = "closed";
			} else {
				this.state = "open";
			}
		}
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public List<T> getChildren() {
		return children;
	}

	public void setChildren(List<T> children) {
		this.children = children;
	}
}
