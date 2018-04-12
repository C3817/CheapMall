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
			/*HttpSession session = request.getSession();
			String id = session.getAttribute("id").toString();*/
			String id="test2";
			String[] order_sq1=request.getParameterValues("order_sq");
			String[] detail_sq_String=request.getParameterValues("detail_sq");
			int[] detail_sq=null;
			int result=0;
			int resultAll=0;
			int order_sq=0;
			if (order_sq1.length>0) order_sq=Integer.parseInt(order_sq1[0]);
			
			for(int i=0;i<detail_sq_String.length;i++){
				detail_sq[i]=Integer.parseInt(detail_sq_String[i]);
			}
			
			OrderDao dao=OrderDao.getInstance();
			
			// result=dao.returnOrder(id, order_sq, detail_sq);

			request.setAttribute("result", result);
			
		/*	} catch (SQLException e) {
				 e.printStackTrace();
			}*/
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "/mall/orderReturnDetailPro.jsp";
	}

}
