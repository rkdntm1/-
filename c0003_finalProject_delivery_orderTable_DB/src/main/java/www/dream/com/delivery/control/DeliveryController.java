package www.dream.com.delivery.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.dream.com.delivery.model.DeliveryRequestVO;
import www.dream.com.delivery.service.DeliveryService;

@Controller
@RequestMapping("/delivery/*")
public class DeliveryController {
	//LRCUD
	@Autowired
	private DeliveryService deliveryService;

	
	@GetMapping(value="requestList")
	public void requestList(@RequestParam("boardId") int boardId, Model model) {
		model.addAttribute("requestList", deliveryService.getList(boardId));
	}
	
	/*
	 * @GetMapping(value="registerRequest") public void registerRequest(int reqId,
	 * Model model) { model.addAttribute("reqId", reqId); }
	 */

	/*
	 * @PostMapping(value="registerRequest") public String
	 * registerPost(@RequestParam("reqId") int reqId, DeliveryRequestVO newRequest,
	 * RedirectAttributes rttr) { deliveryService.insertRequest(reqId, newRequest);
	 * rttr.addFlashAttribute("result", newRequest.getReqId()); //listBySearch로 목록
	 * 조회하면 어떤 단점이 있을까? 검색한 단어와 상관성이 없는 신규 게시글을 볼 수 없다. return
	 * "redirect:/delivery/requestList?boardId=" + reqId; }
	 * 
	 * @PostMapping(value="removeRequest") public String
	 * removePost(@RequestParam("reqId") int reqId, String userId,
	 * RedirectAttributes rttr) { if(deliveryService.deleteRequestById(userId)) {
	 * rttr.addFlashAttribute("result", "success"); } return
	 * "redirect:/post/listBySearch?boardId=" + reqId; }
	 */
}
