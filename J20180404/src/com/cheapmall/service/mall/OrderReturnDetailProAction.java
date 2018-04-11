package com.cheapmall.service.mall;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.service.CommandProcess;


public class OrderReturnDetailProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();
			
			String[] order_sq=request.getParameterValues("order_sq");
			String[] detail_sq=request.getParameterValues("detail_sq");
			
			
			int result=0;
			int resultAll=0;
			OrderDao dao=OrderDao.getInstance();
			for(int i=0;i<detail_sq.length;i++){
				result=dao.returnOrder(id, order_sq[i], detail_sq[i]);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("pageSet", "/mall/orderReturnDetailPro.jsp");
		return "/mall/cheapmall.jsp";
	}

}
