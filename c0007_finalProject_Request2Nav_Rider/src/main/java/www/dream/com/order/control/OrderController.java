package www.dream.com.order.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import www.dream.com.order.model.DetailOrder;
import www.dream.com.order.model.OrderList;
import www.dream.com.order.service.OrderService;

@Controller
@RequestMapping("/order/*")
public class OrderController {
	//LRCUD
	@Autowired
	private OrderService orderService;

	
	@GetMapping(value="orderPage")
	public void registOrder(@RequestParam("userId") String memberId, Model model) {
		model.addAttribute("memberId", memberId);
		model.addAttribute("detailOrderList", orderService.getDetailOrderList());
	}
	
	@PostMapping(value="orderPage")
	public String registOrder(@RequestParam("userId") String memberId, 
			OrderList orderList, DetailOrder detailOrder) {
		orderService.insertOrder(memberId, orderList, detailOrder);
		return "redirect:/board/memberMain";
	}
}
