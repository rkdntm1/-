package www.dream.com.bulletinBoard.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import www.dream.com.bulletinBoard.service.BoardService;
import www.dream.com.bulletinBoard.service.PostService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	//LRCUD
	@Autowired
	private BoardService boardService;

	@Autowired
	private PostService postService;
	
	/**-------------멤버 관련 컨트롤러--------------- */
	@GetMapping(value="memberMain")
	public void memberMain(Model model) {
		model.addAttribute("categoryList", boardService.categoryList());
	}
	
	
	/**-------------가게 관련 컨트롤러--------------- */
	@GetMapping(value="storeMain")
	public void readOrder(Model model) {
	}
	
	/**-------------라이더 관련 컨트롤러--------------- */
	@GetMapping(value="riderMain")
	public void riderListOrder(Model model) {
	}
	
}
