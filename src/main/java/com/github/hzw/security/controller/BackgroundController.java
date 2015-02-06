package com.github.hzw.security.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.UserLogin;
import com.github.hzw.security.service.AccountService;
import com.github.hzw.security.service.UserLoginService;
import com.github.hzw.util.Common;
import com.github.hzw.util.Md5Tool;


@Controller
@RequestMapping ("/")
public class BackgroundController
{
	@Autowired
	private AccountService accountService;
	@Autowired
	private AuthenticationManager myAuthenticationManager;
	
	@Inject
	private UserLoginService userLoginService;
	/**
	 * @return
	 */
	@RequestMapping ("login")
	public String login(Model model,HttpServletRequest request)
	{
		//重新登录时销毁该用户的Session
		Object o = request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
		if(null != o){
			request.getSession().removeAttribute("SPRING_SECURITY_CONTEXT");
		}
		return Common.BACKGROUND_PATH+"/framework/login";
	}
	
	@RequestMapping ("loginCheck")
	@ResponseBody
	public Map<String, Object> loginCheck(String username,String password){
		Map<String, Object> map = new HashMap<String, Object>();
			Account account = new Account();
			account.setAccountName(username);
			account.setPassword(Md5Tool.getMd5(password));
			// 验证用户账号与密码是否正确
			Account users = this.accountService.countAccount(account);
			map.put("error", "0");
			if (users == null) {
				map.put("error", "用户或密码不正确！");
			}else if (users != null && Common.isEmpty(users.getAccountName())) {
				map.put("error", "用户或密码不正确！");
			}
			return map;
	}
	
	@RequestMapping ("submitlogin")
	public String submitlogin(String username,String password,HttpServletRequest request) throws Exception{
		try {
			if (!request.getMethod().equals("POST")) {
				request.setAttribute("error","支持POST方法提交！");
			}
			if (Common.isEmpty(username) || Common.isEmpty(password)) {
				request.setAttribute("error","用户名或密码不能为空！");
				return Common.BACKGROUND_PATH+"/framework/login";
			}
			// 验证用户账号与密码是否正确
			Account users = this.accountService.querySingleAccount(username);
			if (users == null) {
				request.setAttribute("error", "用户或密码不正确！");
			    return Common.BACKGROUND_PATH+"/framework/login";
			}
			else if (users != null && Common.isEmpty(users.getAccountName()) && !Md5Tool.getMd5(password).equals(users.getPassword())){
				request.setAttribute("error", "用户或密码不正确！");
			    return Common.BACKGROUND_PATH+"/framework/login";
			}
			Authentication authentication = myAuthenticationManager
					.authenticate(new UsernamePasswordAuthenticationToken(username,users.getPassword()));
			SecurityContext securityContext = SecurityContextHolder.getContext();
			securityContext.setAuthentication(authentication);
			HttpSession session = request.getSession(true);  
		    session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);  
		    // 当验证都通过后，把用户信息放在session里
			request.getSession().setAttribute("userSession", users);
			request.getSession().setAttribute("userSessionId", users.getId());
			System.out.println(authentication.getPrincipal().toString());
			String userId = request.getSession().getAttribute("userSessionId").toString();
			String userName = users.getAccountName();
			String ip = Common.toIpAddr(request);
			UserLogin userLogin = new UserLogin();
			userLogin.setUserId(Integer.parseInt(userId));
			userLogin.setUserName(userName);
			userLogin.setloginIP(ip);
			userLoginService.add(userLogin);
			//request.getSession().setAttribute("userRole",authentication.getPrincipal());
			request.removeAttribute("error");
		} catch (AuthenticationException ae) {  
			request.setAttribute("error", "登录异常，请联系管理员！");
		    return Common.BACKGROUND_PATH+"/framework/login";
		}
		return "redirect:index.html";
	}
	
	/**
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping ("index")
	public String index(Model model)
	{   
    	return Common.BACKGROUND_PATH+"/framework/index";
	}
	@RequestMapping ("menu")
	public String menu(Model model)
	{
		return Common.BACKGROUND_PATH+"/framework/menu";
	}
	
	/**
	 * 获取某个用户的权限资源
	 * @param request
	 * @return
	 */
	@RequestMapping ("findAuthority")
	@ResponseBody
	public List<String> findAuthority(HttpServletRequest request){
		SecurityContextImpl securityContextImpl = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");   
		List<GrantedAuthority> authorities = (List<GrantedAuthority>)securityContextImpl.getAuthentication().getAuthorities();   
		List<String> strings = new ArrayList<String>();
		for (GrantedAuthority grantedAuthority : authorities) {   

			strings.add(grantedAuthority.getAuthority());   

		}  
		return strings;
	}
	
	@ResponseBody
	@RequestMapping ("install")
	public Map<String, Object> install(Model model)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("success", "初始化成功!");
		} catch (Exception e) {
			map.put("error", "初始化失败  ---------- >   "+e);
		}
		return map;
	}
}
