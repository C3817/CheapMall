package com.cheapmall.service.mall;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cheapmall.dao.OrderDao;
import com.cheapmall.dto.OrdersDto;
import com.cheapmall.service.CommandProcess;

public class OrderUserCancleProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String[] detail_sq = request.getParameterValues("check");
		int result = 0;
		int result2 = 0;
		List<HashMap>[] list = null;
		OrderDao od = OrderDao.getInstance();
		for (int i = 0; i < detail_sq.length; i++) {
			System.out.println(detail_sq[i]);
		}
		try {
			result = od.khOrderCancle(detail_sq);
			HashSet<String> set = od.khGetOrder_Sq(detail_sq);
			list = new ArrayList[set.size()];
			Object[] valueList = set.toArray();
			for (int i = 0; i < valueList.length; i++) {
				list[i] = od.khReMakeOrderList(valueList[i].toString());
				System.out.println("list 목록 : " + list[i]);
			}

			for (int i = 0; i < list.length; i++) {
				int control = 0;
				int size = list[i].size();
				for (int j = 0; j < size; j++) {

					System.out.println("list[" + i + "].size() : " + list[i].size());
					HashMap testMap = new HashMap();
					testMap = list[i].get(j - control);
					for (int k = 0; k < detail_sq.length; k++) {
						if (testMap.get("detail_sq").equals(detail_sq[k])) {
							list[i].remove(j - control);
							++control;
							break;
						}
					}
				}
				System.out.println(list[i]);
			}
			// -------------------------------주문 재등록--------------
			for (int i = 0; i < list.length; i++) {
				OrdersDto orderDto = new OrdersDto();
				if (list[i].size() > 0) {
					for (int j = 0; j < list[i].size(); j++) {
						HashMap testMap = new HashMap();
						testMap = list[i].get(j);
						
					}
					result2 = od.khOrderReInsert(list[i]);
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		request.setAttribute("pageSet", "/mall/orderUserCanclePro.jsp");
		return "/mall/cheapmall.jsp";
	}
}
