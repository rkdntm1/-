package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DeliveryinTransit extends DeliveryPerformVO{
	
	public static final String DESCRIM4INTRANSIT  = "inTransit";

	public DeliveryinTransit(DeliveryPerformVO perform) {
		super(perform.getReqId(), perform.getRiderId());
	}

	
}
