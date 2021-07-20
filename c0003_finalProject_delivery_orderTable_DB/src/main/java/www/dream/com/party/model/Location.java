package www.dream.com.party.model;

import lombok.Data;
import www.dream.com.common.model.CommonMngVO;

@Data
public class Location extends CommonMngVO {
	private String locationType; 	// 위치종류
	private String info; 			// 위치 정보
}
