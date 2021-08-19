package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DeliveryinTransit extends DeliveryPerformVO{
	
	public static final String DESCRIM4INTRANSIT  = "inTransit";

	public DeliveryinTransit(DeliveryRequestVO request, String riderId) {
		super(request.getId(), riderId);
	}

	
}
