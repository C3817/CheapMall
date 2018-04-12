package com.cheapmall.service.mall;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.service.CommandProcess;

public class UserRemoveFormAction implements CommandProcess {

	
	
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();
			request.setAttribute(id, "id");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "mall/userRemoveForm.jsp";
		
	}

}
