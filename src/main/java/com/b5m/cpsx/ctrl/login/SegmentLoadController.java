package com.b5m.cpsx.ctrl.login;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.b5m.cpsx.ctrl.BaseController;

/**
 * 加载所有角色
 * @author lscm
 *
 */
@Controller
@RequestMapping("/segment/load")
public class SegmentLoadController extends BaseController {

	@RequestMapping("{tplurl}.do")
	public String getPageContent(@PathVariable("tplurl") String pathVariable,
			Model model) {
		List<Object> roles = baseCommonService.selectListAll("cpsxRoleMapper.selectAllRoles");
		model.addAttribute("roles", roles);
		return "segment/" + pathVariable;
	}

}
