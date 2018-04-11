package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserLoginProAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			String gender = request.getParameter("gender") == null ? "" : request.getParameter("gender");
			String top_category = request.getParameter("top_category") == null ? "" : request.getParameter("top_category");
			String middle_category = request.getParameter("middle_category") == null ? "" : request.getParameter("middle_category");
			
			request.setAttribute("gender", gender);
			request.setAttribute("top_category", top_category);
			request.setAttribute("middle_category", middle_category);
			
			MemberDao memberDao = MemberDao.getInstance();
			int result = memberDao.userLoginCheck(id, pw);
			if(result == 1) {
				// SYSO
				System.out.println("success");
				
				// 로그인 성공 시, session에 id를 저장한다.
				HttpSession session = request.getSession();
				session.setAttribute("id", id);
				
				//List 화면에서 로그인 시
				if(!gender.equals("") && !top_category.equals("") && !middle_category.equals("")) {
					request.setAttribute("returnPage", "list");
				}
				
			}
			System.out.println("finish");
			request.setAttribute("result", result);
			request.setAttribute("returnList", "main");
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("UserLoginProAction Error");
			e.printStackTrace();
		}
		request.setAttribute("pageSet", "/mall/userLoginPro.jsp");
		return "/mall/cheapmall.jsp";
	}
}
