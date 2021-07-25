package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.common.model.CommonMngVO;

@Data
@NoArgsConstructor
public class DeliveryRequestVO extends CommonMngVO{
	private String reqId;
	private String storeId;
	private String memberId;
	private String riderId;
	private String reqState;
	private String orderId;
	
}
