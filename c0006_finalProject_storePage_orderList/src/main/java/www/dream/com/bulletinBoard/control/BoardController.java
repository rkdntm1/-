package www.dream.com.bulletinBoard.control;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import www.dream.com.bulletinBoard.service.BoardService;
import www.dream.com.bulletinBoard.service.PostService;
import www.dream.com.framework.springSecurityAdapter.CustomUser;
import www.dream.com.order.service.OrderService;
import www.dream.com.party.model.Party;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	//LRCUD
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private OrderService orderService;
	
	/**-------------멤버 관련 컨트롤러--------------- */
	@GetMapping(value="memberMain")
	public void memberMain(Model model, @AuthenticationPrincipal Principal principal) {
		Party curUser = null;
		if(principal != null) {
			UsernamePasswordAuthenticationToken upat=(UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();  
			curUser = cu.getCurUser();
		}
		model.addAttribute("categoryList", boardService.categoryList());
		model.addAttribute("member", curUser);
	}
	
	
	/**-------------가게 관련 컨트롤러--------------- */
	@GetMapping(value="storeMain")
	public void readOrder(Model model, @AuthenticationPrincipal Principal principal) {
		Party curUser = null;
		if(principal != null) {
			UsernamePasswordAuthenticationToken upat=(UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();  
			curUser = cu.getCurUser();
		}
		model.addAttribute("myOrderList", orderService.getOrderListById(curUser.getUserId()));
		
	}
	
	/**-------------라이더 관련 컨트롤러--------------- */
	@GetMapping(value="riderMain")
	public void riderListOrder(Model model) {
	}
	
}
