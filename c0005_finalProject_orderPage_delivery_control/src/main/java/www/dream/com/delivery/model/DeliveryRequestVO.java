package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DeliveryRequestVO {
	private String reqId;
	private String storeId;
	private String memberId;
	private String riderId;
	private String reqState;
	private double startLat;
	private double startLng;
	private String startAddr;
	private double endLat;
	private double endLng;
	private String endAdd;
	private String order1;
	
	@Override
	public String toString() {
		return "DeliveryRequestVO [reqId=" + reqId + ", storeId=" + storeId + ", memberId=" + memberId + ", riderId="
				+ riderId + ", reqState=" + reqState + ", startLat=" + startLat + ", startLng=" + startLng
				+ ", startAddr=" + startAddr + ", endLat=" + endLat + ", endLng=" + endLng + ", endAdd=" + endAdd
				+ ", order1=" + order1 + "]";
	}
	
	
}
