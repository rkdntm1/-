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
	private String order1;
	
	
	@Override
	public String toString() {
		return "DeliveryRequestVO [reqId=" + reqId + ", storeId=" + storeId + ", memberId=" + memberId + ", riderId="
				+ riderId + ", reqState=" + reqState + ", order1=" + order1 + ", getFormattedUpdateDate()="
				+ getFormattedUpdateDate() + ", toString()=" + super.toString() + ", getRegistrationDate()="
				+ getRegistrationDate() + ", getUpdateDate()=" + getUpdateDate() + ", getClass()=" + getClass() + "]";
	}
	
	
	
}
