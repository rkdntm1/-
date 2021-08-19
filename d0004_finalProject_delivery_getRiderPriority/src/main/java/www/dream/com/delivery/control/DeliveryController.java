package www.dream.com.delivery.control;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.dream.com.delivery.model.DeliveryRequestVO;
import www.dream.com.delivery.service.DeliveryService;
import www.dream.com.framework.springSecurityAdapter.CustomUser;
import www.dream.com.party.model.Accountability;
import www.dream.com.party.model.Party;
import www.dream.com.party.model.Person;
import www.dream.com.party.service.PartyService;

@Controller
@RequestMapping("/delivery/*")
public class DeliveryController {
	@Autowired
	private DeliveryService deliveryService;
	
	@Autowired
	private PartyService partyService;
	
/** 특정 게시판에 등록되어 있는 게시글을 목록을 조회하기 ++ void : /post/list.jsp로 반환 ++ */
	@GetMapping(value = "deliveryList")
	public void list(@AuthenticationPrincipal Principal principal, Model model) {
		Person curUser = null;
		if (principal != null) {
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
			String userId = curUser.getUserId();
			List<Accountability> listAcc = curUser.getAccountability();
			for (Accountability gd : listAcc) {
				if (gd.getAccType().equals("RIDER")) {
					//model.addAttribute("list", deliveryService.getList(userId, DeliveryPerformVO.DESCRIM4PERFORM));
				}
				if (gd.getAccType().equals("CEO")) {
					//model.addAttribute("list", deliveryService.getList(userId, DeliveryRequestVO.DESCRIM4REQUEST));
				}
			}
		}
	}
	
	/** 1. 라이더의 위치를 기준으로 반경 1km안 그리고 req_state가 pending인 요청들을 탐색한다.
	 */
	@GetMapping(value="requestList")
	public void requestList(@AuthenticationPrincipal Principal principal, Model model) {
		Party curUser = null;
		if(principal != null){
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();
		}
		//model.addAttribute("searchRequest", deliveryService.searchRequest(curUser));
	}
	
	//requestList.jsp에서 누른 request를 없애준다.
	//b_request req_state Matching으로 바꿔준다.
	//b_request rider_id를 넣어준다.
	@PostMapping(value="requestList")
	public String requestList(@RequestParam("requestId") String requestId,
			@AuthenticationPrincipal Principal principal,
			Model model, RedirectAttributes rttr) {
		Party curUser = null;
		if(principal != null){
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();	
		}
		//riderId, reqState, upt 수정
		//deliveryService.updateRequest(requestId, curUser);
		
		return  "redirect:/delivery/matchingRider";
		
	}
	
	/**
	 * 해당 주문id에 대한 상세내용을 가져옴
	 * @param reqId 클릭한 해당 주문 id
	 * @param model
	 */
	@GetMapping(value="readOrder")
	//@PreAuthorize("isAuthenticated()")
	public void readOrder(@RequestParam("orderId") String orderId, Model model) {
		model.addAttribute("order", deliveryService.findOrderbyId(orderId));
	}
	
	/**
	 * 해당 고객정보를 가지고 주문하기
	 * @param memberId 현 로그인한 고객 id
	 * @param model
	 */
	@GetMapping(value="registerOrder")
	//@PreAuthorize("isAuthenticated()")
	public void registerPost(@RequestParam("memberId") String memberId, Model model) {
		model.addAttribute("memberId", memberId);
	}
	
	
	/**
	 * 고객이 요청에 담길 주문을 함
	 * @param req 요청 객체
	 * @param rttr
	 * @return
	 */
	@PostMapping(value="registerOrder")
	//@PreAuthorize("isAuthenticated()")
	public String registerPost(DeliveryRequestVO req, RedirectAttributes rttr) {
		deliveryService.insertOrder(req);

		return "redirect:/board/memberMain";
	}
	
	/**
	 * 가게가 주문을 수락하면 request를 등록하고 가게메인페이지에 띄어준다.
	 * @param req 요청으로 등록될 객체
	 * @param rttr
	 * @return
	 */
	@PostMapping(value="registerRequest")
	//@PreAuthorize("isAuthenticated()")
	public String registerRequest(DeliveryRequestVO req, RedirectAttributes rttr) {
		deliveryService.updateRequest(req);
		return "redirect:/board/storeMain";
	}
	
	
	/** 1. 라이더가 request를 수락하면 riderId와 req_state = in transit 로 업데이트 해야한다.
	 *  2. 라이더가 request를 완료하면 req_state = delivered로 업데이트 되어야 한다.
	 *  3. 라이더가 배달취소버튼을 누르면 req_state가 cancelled로 업데이트 되어야 한다. 
	 * */
	@PostMapping(value="updateRequest")
	public String modifyPost(@RequestParam("boardId") int boardId, DeliveryRequestVO reqId, RedirectAttributes rttr) {
		
//		modifiedPost.parseAttachInfo();
//		}
//		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("");
//		builder.queryParam("boardId", boardId);
//		fromUser.appendQueryParam(builder);
		//게시글의 전체 내용이 바뀌기 보다는 조금의 내용이 바뀌는 것이 수정 행위의 일반적인 경향
		//다만 너무나 대폭적인 수정의 경우 재 검색 하여야 보일 것
		return "redirect:/post/listBySearch"; //+ builder.toUriString();
	}
	
}
