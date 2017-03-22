package com.b5m.cpsx.ctrl.login;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.b5m.cpsx.commons.constant.CacheConstant;
import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.CpsxRole;
import com.b5m.cpsx.model.Resource;
import com.b5m.cpsx.service.login.IRoleResourceService;

@Controller
@RequestMapping("/admin/role")
public class RoleResourceController extends BaseController{

	private static Log logger = LogFactory.getLog(RoleResourceController.class);
	
	@Autowired
	private IRoleResourceService roleResourceService;

	/** 资源角色管理页面 **/
	@RequestMapping("/roleResourceView.do")
	public String roleResourceManager(Model model) {
		try {
			//查询所有resources集合
			List<Object> resources =  baseCommonService.selectListAll("cpsxResourceMapper.selectAllResourceList");
			model.addAttribute("resources", resources);
			return "admin/resourcesView";
		} catch (Exception e) {
			logger.error("/admin/role/roleResourceView.do", e);
			return "redirect:/500.jsp";
		}
	}

	/** 获得资源的树形结构 **/
	@RequestMapping("/getResource.do")
	@ResponseBody
	public List<Resource> roleResourceView(
			HttpServletRequest request, Model model) {
		try {
			List<Object> list =  baseCommonService.selectListAll("cpsxResourceMapper.selectAllResourceList");
			List<Resource> resources = new ArrayList<Resource>();
			if(list.size()>0){
				for(Object obj:list){
					Resource resource =(Resource)obj;
					resource.setText(resource.getResourceName()); //填充树形结构的资源名称
					resources.add(resource);
				}
			}
			List<Resource> resourcesResult = new ArrayList<Resource>();
			Map<Integer, Resource> resourceIdMap = new HashMap<Integer, Resource>();
			for (Resource dmpResource : resources) {
				resourceIdMap.put(dmpResource.getId(), dmpResource);
			}

			for (Resource dmpResource : resources) {
				Integer parentId = dmpResource.getTopid();
				if (resourceIdMap.containsKey(parentId)) {
					Resource temp = resourceIdMap.get(parentId);
					temp.getChildren().add(dmpResource);
				} else {
					resourcesResult.add(dmpResource);
				}
			}
			String selectedResourceIds = request
					.getParameter("selectedResourceIds");
			if (StringUtils.isNotBlank(selectedResourceIds)) {
				selectedResourceIds = selectedResourceIds.trim();
				String[] resourceIdArray = selectedResourceIds.split(",");
				for (Resource resource : resourcesResult) {
					List<Resource> children = resource.getChildren();
					if (children.size() > 0) {
						for (Resource child : children) {
							Long id = Long.valueOf(child.getId());
							for (String resourceid : resourceIdArray) {
								if (id.equals(Long.valueOf(resourceid))) {
									resource.setDefinedState(true);
									resource.setState("open");
								}
							}
						}
					}
				}
			}

			return resourcesResult;
		} catch (Exception e) {
			logger.error("/admin/role/getResource.do", e);
			return null;
		}
	}

	/** 编辑资源 **/
	@RequestMapping("/editResource.do")
	public String editResource(Resource dmpResource) {
		try {
			baseCommonService.update("cpsxResourceMapper.updateResource",dmpResource);
			return "redirect:/admin/role/roleResourceView.do";
		} catch (Exception e) {
			logger.error("/admin/role/editResource.do", e);
			return "redirect:/500.jsp";
		}
	}

	/** 添加资源 **/
	@RequestMapping("/addResource.do")
	public String addResource(Resource dmpResource) {
		try {
			baseCommonService.insert("cpsxResourceMapper.insertOneResource", dmpResource);
			return "redirect:/admin/role/roleResourceView.do";
		} catch (Exception e) {
			logger.error("/admin/role/addResource.do", e);
			return "redirect:/500.jsp";
		}
	}

	/** 删除资源 **/
	@RequestMapping("/deleteResource.do")
	public String deleteResource(Resource dmpResource, Model model) {
		try {
			String delErrorReason = "";
			long count = (Long) baseCommonService.selectOne("cpsxResourceMapper.existByResourceId",
					new Long(dmpResource.getId()));
			if (count>0) {
				delErrorReason += "此资源已经被角色关联无法删除";
			}
			
			long isHasChildren = (Long)baseCommonService.selectOne("cpsxResourceMapper.isHasChildrenById", 
					new Long(dmpResource.getId()));
			if (isHasChildren>0) {
				if (delErrorReason.length() > 0) {
					delErrorReason += ",";
				}
				delErrorReason += "此资源存在子资源无法删除";
			}
			if (delErrorReason.length() > 0) {
				model.addAttribute("delErrorReason", delErrorReason);
				return "admin/resourceManagerView";
			}
			baseCommonService.delete("cpsxResourceMapper.deleteOneResource", dmpResource.getId());
			return "redirect:/admin/role/roleResourceView.do";
		} catch (Exception e) {
			logger.error("/admin/role/deleteResource.do", e);
			return "redirect:/500.jsp";
		}
	}

	/** 添加角色页面 **/
	@RequestMapping("/addRoleView.do")
	public String addRoleView() {
		return "admin/createRole";
	}

	/** 添加角色 **/
	@RequestMapping("/addRole.do")
	public String addRole(CpsxRole role, String resourceIds) {
		try {
			String[] resourceIdArray = resourceIds.split(",");
			baseCommonService.insert("cpsxRoleMapper.insertOneRole", role);
			@SuppressWarnings("rawtypes")
			List<Map> params = new ArrayList<Map>();
			for (int i = 0; i < resourceIdArray.length; i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("roleId", role.getId());
				map.put("resourceIdArray", resourceIdArray[i]);
				params.add(map);
			}
			roleResourceService.updateRoleResource(role, params);
			return "redirect:/admin/role/listRole.do";
		} catch (Exception e) {
			logger.error("/admin/role/addRole.do", e);
			return "redirect:/500.jsp";
		}
	}

	/** 角色列表 **/
	@RequestMapping("/listRole.do")
	public String listRole(Model model) {
		try {
			List<Object> roles = baseCommonService.selectListAll("cpsxRoleMapper.selectAllRoles");
			model.addAttribute("roles", roles);
			return "admin/roleList";
		} catch (Exception e) {
			logger.error("/admin/role/listRole.do", e);
			return "redirect:/500.jsp";
		}
	}

	/** 编辑角色页面 **/
	@RequestMapping("/updateRoleView.do")
	public String updateRoleView(Long id, Model model) {
		try {
			CpsxRole role = (CpsxRole)baseCommonService.selectOne("cpsxRoleMapper.selectRoleById", id.intValue());
			List<Object> resourcesObjs = baseCommonService.selectList("cpsxRoleMapper.selectResourcesByRole", id.intValue());
			
			StringBuffer resourceIdBuffer = new StringBuffer("");
			for(Object res : resourcesObjs){
				Resource resource = (Resource)res;
				resourceIdBuffer.append(resource.getId());
				resourceIdBuffer.append(",");
			}
			if (resourceIdBuffer.length() > 0) {
				resourceIdBuffer.deleteCharAt(resourceIdBuffer.length() - 1);
			}
			model.addAttribute("role", role);
			model.addAttribute("resourceIds", resourceIdBuffer.toString());
			return "admin/editRole";
		} catch (Exception e) {
			logger.error("/admin/role/updateRole.do", e);
			return "redirect:/500.jsp";
		}
	}

	/** 编辑角色 **/
	@RequestMapping("updateRole.do")
	public String updateRole(String resourceIds, CpsxRole role) {
		try{
				String[] resourceIdArray = resourceIds.split(",");
				@SuppressWarnings("rawtypes")
				List<Map> params = new ArrayList<Map>();
				for (int i = 0; i < resourceIdArray.length; i++) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("roleId", role.getId());
					map.put("resourceIdArray", resourceIdArray[i]);
					params.add(map);
				}
				int suc =roleResourceService.updateRoleResource(role,params);
				return "redirect:/admin/role/listRole.do";
		}catch (Exception e) {
			logger.error("/admin/role/updateRole.do", e);
			return "redirect:/500.jsp";
		}
	}
}
