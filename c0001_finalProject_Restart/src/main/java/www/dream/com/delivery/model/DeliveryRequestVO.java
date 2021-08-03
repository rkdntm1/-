package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.common.model.CommonMngVO;
import www.dream.com.framework.printer.AnchorTarget;
import www.dream.com.framework.printer.ClassPrintTarget;
import www.dream.com.framework.printer.PrintTarget;
@Data
@NoArgsConstructor

//배달 요청건 
public class DeliveryRequestVO extends DeliveryVO{
	
	private String memberId;
	private String storeId;
	private String orderContents;
	@PrintTarget(order=300, caption="주문상태")
	private double endLat;
	private double endLng;
	@PrintTarget(order = 250, caption = "도착지")
	private String endAddr;
	private String deliveryTip;
	private String cookedTime;
}
