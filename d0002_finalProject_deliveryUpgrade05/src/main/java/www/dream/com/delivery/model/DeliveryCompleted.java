package www.dream.com.delivery.model;

import lombok.Data;

@Data
public class DeliveryCompleted extends DeliveryPerformVO {
	
	public static final String DESCRIM4COMPLETED = "completed"; 
	
	
//	private String riderId;
//	private String totalTip;
//	private int cnt;
//	private double distance;
//	
	
	public DeliveryCompleted(DeliveryPerformVO perform) {
		super(perform.getReqId(), perform.getRiderId());
	}
	
//	public String toString() {
//		return "DeliveryCompleted [riderId=" + riderId + ", totalTip=" + totalTip + ", cnt=" + cnt + ", distance="
//				+ distance + "]";
//	}
	

}
