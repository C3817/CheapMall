package com.cheapmall.service.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.MemberDao;
import com.cheapmall.dto.UsersDto;
import com.cheapmall.service.CommandProcess;

public class AdminUserListFormAction implements CommandProcess{
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			// HttpSession session = request.getSession();
			String id = "a1";
			String pageNum = request.getParameter("pageNum");
			
			MemberDao memberDao = MemberDao.getInstance();
			
			int totCnt  = memberDao.getTotalUserCnt();	
			if (pageNum==null || pageNum.equals("")) {	pageNum = "1";	}
			int currentPage = Integer.parseInt(pageNum);	
			int pageSize  = 10, blockSize = 10;
			int startRow = (currentPage - 1) * pageSize + 1;
			int endRow   = startRow + pageSize - 1;
			int startNum = totCnt - startRow + 1;
			List<UsersDto> list = memberDao.userList(startRow, endRow);	
			int pageCnt = (int)Math.ceil((double)totCnt/pageSize);
			int startPage = (int)(currentPage-1)/blockSize*blockSize + 1;
			int endPage = startPage + blockSize -1;	
			if (endPage > pageCnt) endPage = pageCnt;	
			
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startNum", startNum);
			request.setAttribute("list", list);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			
			// SYSO
			System.out.println("-----------------------------------------------");  // /ch16/list.do
			System.out.println("startNum-->" + startNum);  // /ch16/list.do
			System.out.println("totCnt-->" + totCnt);  // /ch16/list.do
			System.out.println("currentPage-->" + currentPage);  // /ch16/list.do
			System.out.println("blockSize-->" + blockSize);  // /ch16/list.do
			System.out.println("pageSize-->" + pageSize);  // /ch16/list.do
			System.out.println("pageCnt-->" + pageCnt);  // /ch16/list.do
			System.out.println("startPage-->" + startPage);  // /ch16/list.do
			System.out.println("endPage-->" + endPage);  // /ch16/list.do
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("AdminUserListFormAction Error");
			e.printStackTrace();
		}
		
		return "/admin/adminUserListForm.jsp";
	}
}
