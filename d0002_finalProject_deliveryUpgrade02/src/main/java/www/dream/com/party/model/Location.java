package www.dream.com.party.model;

import java.util.Date;

import lombok.Data;
import www.dream.com.common.model.CommonMngVO;

@Data
public class Location extends CommonMngVO {
	private String userId;			 	// 위치종류
	private String longitude; 			// 위치 정보
	private String latitude; 			// 위치 정보
	private Date latestDate; 			// 위치 정보
}
