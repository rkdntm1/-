package www.dream.com.delivery.model;

import lombok.Data;
import www.dream.com.delivery.service.DeliveryService;

@Data
public class DeliveryCompleted  {
	
	public static final String DESCRIM4COMPLETED = "completed"; 
	
	
	private String riderId;
	private String totalTip;
	private int cnt;
	private double distance;
	
	
	@Override
	public String toString() {
		return "DeliveryCompleted [riderId=" + riderId + ", totalTip=" + totalTip + ", cnt=" + cnt + ", distance="
				+ distance + "]";
	}
	

}
