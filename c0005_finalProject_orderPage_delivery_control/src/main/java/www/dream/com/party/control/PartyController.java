package www.dream.com.party.control;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import www.dream.com.bulletinBoard.model.ReplyVO;
import www.dream.com.party.model.LocationType;
import www.dream.com.party.model.Member;
import www.dream.com.party.service.PartyService;

@Controller
@RequestMapping("/party/*")
public class PartyController implements AuthenticationSuccessHandler, AccessDeniedHandler {
	@Autowired
	private PartyService partyService;
	
	@Autowired
	private PasswordEncoder pwEncoder;
	
	@GetMapping(value="list")
	public void getList(Model model) {
		model.addAttribute("listParty", partyService.getList());		
	}

	@GetMapping(value="customLogin")
	public void loginInput(String error, String logout, Model model) {
		if (error != null) {
			model.addAttribute("error", "아이디 혹은 패스워드가 잘못되었습니다.");
		}
		if (logout != null) {
			model.addAttribute("logout", "로그아웃 되었습니다.");
		}
	}
	
	@GetMapping(value="customLogout")
	public void processLogout() {
		
	}
	
	@PostMapping(value="customLogout")
	public void processLogoutPost() {
		
	}

	@GetMapping("registerClassify")
	public void registerClassify() {
	}
	
	@GetMapping("joinMember")
	public void joinMember(Model model, @RequestParam("partyDescrim") String partyDescrim) {
		model.addAttribute("listCPType", partyService.getCPTypeList());
		model.addAttribute("listLocType", partyService.getLocTypeList());
		model.addAttribute("partyType", partyDescrim);
		
	}
	
	@PostMapping("joinMember")
	public String joinMember(Member newBie, @DateTimeFormat(pattern = "yyyy-MM-dd") Date birthDate) {
		//회원가입시 비밀번호 암호화
		newBie.setUserPwd(pwEncoder.encode(newBie.getUserPwd()));
		partyService.joinMember(newBie);
		return "redirect:/";
	}
	
//	@GetMapping("chkIdDup")
//	public ResponseEntity<Boolean> chkIdDup(String newBieId) {
//		System.out.println(newBieId);
//		boolean idExist = partyService.IDDuplicateCheck(newBieId);
//		return new ResponseEntity<>(idExist, HttpStatus.OK);
//	}
	
	@ResponseBody
	@PostMapping(value = "idCheck", produces="text/plane")
	public String ID_Check(@RequestBody String paramData) throws ParseException {
		//클라이언트가 보낸 ID값
		String ID = paramData.trim();
		int dto = partyService.IDDuplicateCheck(ID);
		
		if(dto > 0) {//결과 값이 있으면 아이디 존재	
			return "-1";
		} else {		//없으면 아이디 존재 X
			return "0";
		}
	}
	
	/**
	 * 로그인 성공 시 각 사용자의 권한 유형에 따라 개인화된 화면을 연동시켜주기 위한 기능을 이곳에서 개발 합니다
	 */
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		List<String> roleNames = new ArrayList<>();
		authentication.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		if (roleNames.contains("Admin")) {
			response.sendRedirect("/");
			return;
		}else if (roleNames.contains("Member")) {
			response.sendRedirect("/board/memberMain");
			return;
		}else if (roleNames.contains("Store")) {
			response.sendRedirect("/board/storeMain");
			return;
		}else if (roleNames.contains("Rider")) {
			response.sendRedirect("delivery/requestList?boardId=3");
			return;
		}
		response.sendRedirect("/");
	}
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		response.sendRedirect("/party/accessError");
	}

	
}