package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.common.model.CommonMngVO;

@Data
@NoArgsConstructor
public class DeliveryVO extends CommonMngVO {
	private String id;
	
	private DeliveryStatus status;
	private DeliveryException exception;
	
	public DeliveryVO(String id) {
		this.id = id;
	}
	
	public String getId() {
		return id;
	}
}
