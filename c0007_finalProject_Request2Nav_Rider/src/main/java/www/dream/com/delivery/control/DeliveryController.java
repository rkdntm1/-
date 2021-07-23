package www.dream.com.delivery.control;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.dream.com.delivery.model.DeliveryRequestVO;
import www.dream.com.delivery.service.DeliveryService;
import www.dream.com.framework.springSecurityAdapter.CustomUser;
import www.dream.com.party.model.Party;

@Controller
@RequestMapping("/delivery/*")
public class DeliveryController {
	@Autowired
	private DeliveryService deliveryService;

	/** 1. 라이더의 위치를 기준으로 반경 1km안 그리고 req_state가 pending인 요청들을 탐색한다.
	 *  2. 조회된 요청들중 1건 랜덤으로 라이더에게 할당한다.
	 */
	@GetMapping(value="requestList")
	public void requestList(@AuthenticationPrincipal Principal principal, Model model) {
		Party curUser = null;
		if(principal != null){
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();	
		}
		
		model.addAttribute("searchRequest", deliveryService.searchRequest(curUser));
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
		
		model.addAttribute("request", deliveryService.findRequestById(requestId));
	}
	
	
	
	
	/** 1.가게가 배달요청을 누르면 riderId는 제외하고 모든 데이터가 request테이블에 다 등록되어야한다. 
	 *  2. req_state 는 pending(배달대기)로 등록되어야 한다.
	 *  3. req_start_lat, req_start_lang, req_start_addr는 storeId로부터 갖고온다.
	 *  4. req_end_lat, req_end_lang, r	eq_end_addr는 memberId로부터 갖고온다.
	 * */
	@GetMapping(value="registerPost")
	//@PreAuthorize("isAuthenticated()") 
	public void registerPost(@RequestParam("boardId") int boardId, Model model) {
		model.addAttribute("boardId", boardId);
	}	

	
	/** 1. 라이더가 request를 수락하면 riderId와 req_state = in transit 로 업데이트 해야한다.
	 *  2. 라이더가 request를 완료하면 req_state = delivered로 업데이트 되어야 한다.
	 *  3. 라이더가 배달취소버튼을 누르면 req_state가 cancelled로 업데이트 되어야 한다. 
	 * */
	@PostMapping(value="updateRequest")
	public String modifyPost(@RequestParam("boardId") int boardId, DeliveryRequestVO reqId, RedirectAttributes rttr) {
		
		deliveryService.updateRequest(reqId);
		
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
