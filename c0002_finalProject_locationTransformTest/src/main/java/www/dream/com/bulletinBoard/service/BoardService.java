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

	public List<BoardVO> getList() {
		return boardMapper.getList();
	}

	public List<BoardVO> getMemberList() {
		return boardMapper.getMemberList();
	}
	
	public BoardVO getBoard(int id) {
		return boardMapper.getBoard(id);
	}

	public BoardVO getMemberBoard(int id) {
		return boardMapper.getMemberBoard(id);
	}


}
