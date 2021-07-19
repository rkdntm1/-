package www.dream.com.bulletinBoard.service;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import www.dream.com.bulletinBoard.model.BoardVO;
import www.dream.com.bulletinBoard.persistence.BoardMapper;

@Service
public class BoardService {
	@Autowired
	private BoardMapper boardMapper;


	public List<BoardVO> categoryList() {
		return boardMapper.getCategoryList();
	}

	public BoardVO getCategory(String categoryId) {
		return boardMapper.getCategory(categoryId);
	}
	



}
