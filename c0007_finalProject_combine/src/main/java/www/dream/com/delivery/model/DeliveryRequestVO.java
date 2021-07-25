package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.common.model.CommonMngVO;
import www.dream.com.framework.printer.AnchorTarget;
import www.dream.com.framework.printer.ClassPrintTarget;
import www.dream.com.framework.printer.PrintTarget;

@Data
@NoArgsConstructor
@ClassPrintTarget
public class DeliveryRequestVO extends CommonMngVO{
	@AnchorTarget
	private String reqId;
	@PrintTarget(order = 250, caption = "가게이름")
	private String storeId;
	private String memberId;
	private String riderId;
	@PrintTarget(order=300, caption="주문상태")
	private String reqState;
	private double startLat;
	private double startLng;
	private String startAddr;
	private double endLat;
	private double endLng;
	private String endAdd;
	private String orderId;
	
	@PrintTarget(order=100, caption="출발지", withAnchor=true)
	public String getStartAddr() {
		return startAddr;
	}
	
	@Override
	public String toString() {
		return "DeliveryRequestVO [reqId=" + reqId + ", storeId=" + storeId + ", memberId=" + memberId + ", riderId="
				+ riderId + ", reqState=" + reqState + ", startLat=" + startLat + ", startLng=" + startLng
				+ ", startAddr=" + startAddr + ", endLat=" + endLat + ", endLng=" + endLng + ", endAdd=" + endAdd
				+ ", orderId=" + orderId + "]";
	}
	
	
}
