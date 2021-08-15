package www.dream.com.delivery.model;

import lombok.Data;

@Data
public class DeliveryCompleted extends DeliveryPerformVO {
	
	public static final String DESCRIM4COMPLETED = "completed"; 
	
	public DeliveryCompleted(DeliveryRequestVO request, String riderId) {
		super(request.getId(), riderId);
	}
	
}
