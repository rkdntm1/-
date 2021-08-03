package www.dream.com.bulletinBoard.persistence;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import www.dream.com.bulletinBoard.model.BoardVO;

public interface BoardMapper {



	public List<BoardVO> getCategoryList();

	public BoardVO getCategory(@Param("categoryId") String categoryId);


	
}
