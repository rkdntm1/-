package www.dream.com.delivery.model;

import lombok.Data;

@Data
public class DeliveryException {
	
	public static final String DESCRIM4EXCEPTION = "exception";
	
	private DeliveryPeriod period;
}
