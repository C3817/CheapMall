package com.cheapmall.service.admin;

import java.io.IOException;



import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.service.CommandProcess;

public class UserAdminDeleteProAction implements CommandProcess{

	/*
	 * �씠 �럹�씠吏��뒗 愿�由ъ옄媛� �쉶�썝 �궘�젣瑜� �쐞�븯�뿬 
	 * �궘�젣�븷 �쉶�썝�쓣 �꽑�깮�븯怨� �궘�젣�떆�궎�뒗 �겢�옒�뒪 �엯�땲�떎.
	 * 
	*/
	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		System.out.println("�룄李�");
		String check=request.getParameter("del");
		System.out.println("泥댄겕 �셿猷�");

		try {
			int result=0;
			MemberDao dao=MemberDao.getInstance();
			result= dao.deleteUser(check);
			
			System.out.println("�봽由고듃 �셿猷�");
			
			request.setAttribute("result", result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "/admin/userAdminDeletePro.jsp";
	
	}

}
