package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.common.model.CommonMngVO;
import www.dream.com.framework.langPosAnalyzer.HashTarget;
import www.dream.com.framework.printer.AnchorTarget;
import www.dream.com.framework.printer.ClassPrintTarget;
import www.dream.com.framework.printer.PrintTarget;
@Data
@NoArgsConstructor
@ClassPrintTarget
public class DeliveryRequestVO extends DeliveryVO{
	
	// descrim : 요청건
	public static final String DESCRIM4REQUEST = "request"; 
	@PrintTarget(order= 200, caption = "주문자")
	private String memberId;
	@PrintTarget(order= 300, caption = "출발지")
	private String storeId;
	@PrintTarget(order = 400, caption = "상세주문")
	private String orderContents;
	private double endLat;
	private double endLng;
	@PrintTarget(order= 500, caption = "도착지")
	private String endAddr;
	@PrintTarget(order= 600, caption = "배달비")
	private String deliveryTip;
	@PrintTarget(order= 700, caption = "조리시간")
	private String cookedTime;
	
	
	@Override
	public String getId() {
		return super.getId();
	}
	
	
	
	@Override
	public String toString() {
		return "DeliveryRequestVO [memberId=" + memberId + ", storeId=" + storeId + ", orderContents=" + orderContents
				+ ", endLat=" + endLat + ", endLng=" + endLng + ", endAddr=" + endAddr + ", deliveryTip=" + deliveryTip
				+ ", cookedTime=" + cookedTime + ", getId()=" + super.getId() + ", getStatus()=" + super.getStatus() + "]";
	}






	
	
}
