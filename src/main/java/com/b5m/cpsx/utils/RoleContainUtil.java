package com.b5m.cpsx.utils;

import java.util.List;

public class RoleContainUtil {
	
	public static boolean listContains(List<Integer> ren, int tar) {
		for(int i=0;i<ren.size();i++){
			if(ren.get(i)==tar){
				return true;
			}
		}
		return false;
	}
}
