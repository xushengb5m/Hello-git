package com.b5m.cpsx.service.login;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;

import com.b5m.cpsx.commons.constant.CacheConstant;
import com.b5m.cpsx.model.Resource;
import com.b5m.cpsx.service.IBaseCommonService;

/**
 * 系统service初始化
 * 
 * @author johnson
 * 
 */
@Service("initDmpService")
public class InitServiceImpl implements InitService, ServletContextAware {

	static private Logger logger = LoggerFactory
			.getLogger(InitServiceImpl.class);

	@Autowired
	private IBaseCommonService baseCommonService;
	
	private ServletContext sc;

	//加载可用菜单
			public void loadMenu(List<Integer> roleId) {

				List<Object> menus = new LinkedList<Object>();
				Map<String, List<Resource>> menuMap = new HashMap<String, List<Resource>>();
				List<Resource> topMenu = new LinkedList<Resource>();
				
				//boolean needorder = false;//先不做排序
				try {
					menus = baseCommonService.selectList("cpsxResourceMapper.selectResourceList",roleId);
				} catch (Exception e) {
					e.printStackTrace();
					logger.error("查询CPSX系统顶部菜单出错", e);
				}

				for (Object item : menus) {
					Resource c =(Resource)item;
					String key = String.valueOf(c.getTopid());
					if (!menuMap.containsKey(key)) {
						menuMap.put(key, new LinkedList<Resource>());
					}

					menuMap.get(key).add(c);

					if (c.getTopid() == 0) {
						topMenu.add(c);
					}
				}

				Collections.sort(topMenu, new Comparator<Resource>() {
					public int compare(Resource o1, Resource o2) {
						return o1.getPosorder() < o2.getPosorder() ? -1 : 1;
					}
				});

			/*	for (Iterator<Resource> iter = topMenu.iterator(); iter.hasNext();) {
					Resource item = iter.next();
					String tmpKey = String.valueOf(item.getId());
					if ((menuMap.get(tmpKey) == null || menuMap.get(tmpKey).size() == 0)) {
						iter.remove();
					}
				}*/
				if (menuMap.size() > 0) {
					sc.setAttribute(CacheConstant.CPSX_MENU + roleId, menuMap);
					sc.setAttribute(CacheConstant.CPSX_MENU_TOP, topMenu);
				}
			}


			public void setServletContext(ServletContext servletContext) {
				this.sc = servletContext;
			}
}
