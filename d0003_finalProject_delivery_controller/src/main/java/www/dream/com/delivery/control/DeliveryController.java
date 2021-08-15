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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@GetMapping(value="matchingRider")
	public void matchingRider(@AuthenticationPrincipal Principal principal, Model model) {
		Party curUser = null;
		if(principal != null){
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();	
		}
		
//		model.addAttribute("matchingRequest", deliveryService.matchingRequest(curUser));
	}
	
	@GetMapping(value="rider2Nav")
	public void rider2Nav(@RequestParam("requestId") String requestId,
			@AuthenticationPrincipal Principal principal, Model model) {
		Party curUser = null;
		if(principal != null){
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();	
		}
		//model.addAttribute("request", deliveryService.findRequestById(requestId));
		
	}
	
	
	
	
	/**
	 * 가게가 주문을 수락하면 request를 등록하고 가게메인페이지에 띄어준다.
	 * @param req
	 * @param rttr
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="registerRequest")
	//@PreAuthorize("isAuthenticated()")
	public String registerPost(String reqId, RedirectAttributes rttr) {
		//deliveryService.insertRequest(req);
		deliveryService.selectRequest(reqId);
		
		//요청이 만들어지고나서 바로 조건에 맞는 라이더의 우선순위 리스트를 가져온다.		
		
		//해당 요청과 라이더 우선순위 리스트 데이터를 라이더 메인페이지에 보내준다.
		rttr.addAttribute("req", reqId);

		return "redirect:/board/storeMain?";
	}
	
	/**
	 * 가게가 주문을 수락하면 우선순위를 따져 라이더를 배정한 뒤 request를 보내준다.
	 * @param req
	 * @param rttr
	 * @return
	 */
	
	@PostMapping(value="matchingRequest")
	public String matchingRequest(String req, @AuthenticationPrincipal Principal principal,
			RedirectAttributes rttr) {
		Party curUser = null;
		if(principal != null){
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();	
		}
		//요청이 만들어지고나서 바로 조건에 맞는 라이더의 우선순위 리스트를 가져온다.
		//해당 요청과 라이더 우선순위 리스트 데이터를 라이더 메인페이지에 보내준다.

		return "redirect:/board/riderMain?";
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
