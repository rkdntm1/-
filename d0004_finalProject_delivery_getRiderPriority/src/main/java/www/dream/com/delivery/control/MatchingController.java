package www.dream.com.delivery.control;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.dream.com.delivery.model.DeliveryRequestVO;
import www.dream.com.delivery.service.DeliveryService;
import www.dream.com.framework.springSecurityAdapter.CustomUser;
import www.dream.com.party.model.Party;

@RestController
@RequestMapping("/matching/*")
public class MatchingController {
	@Autowired
	private DeliveryService deliveryService;
	
	@PostMapping(value="/{requestId}")
	public ResponseEntity<Map<String, DeliveryRequestVO>> matchingRequest(@PathVariable("requestId") String requestId, @AuthenticationPrincipal Principal principal,
			Model model, RedirectAttributes rttr) {
		Party curUser = null;
		if(principal != null){
			UsernamePasswordAuthenticationToken upat = (UsernamePasswordAuthenticationToken) principal;
			CustomUser cu = (CustomUser) upat.getPrincipal();
			curUser = cu.getCurUser();	
		}
		//요청이 만들어지고나서 바로 조건에 맞는 라이더의 우선순위 리스트를 가져온다.
		Map<String, DeliveryRequestVO> map = new HashMap<>();
		String rider = deliveryService.getRiderPriority(requestId).get(0);
		DeliveryRequestVO req = deliveryService.selectRequest(requestId);
		map.put(rider, req);
		
		//해당 요청과 라이더 우선순위 리스트 데이터를 라이더 메인페이지에 보내준다.

		return new ResponseEntity<>(map, HttpStatus.OK);
	}
}
