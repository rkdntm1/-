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
public class DeliveryRequestVO extends DeliveryVO{
	private String memberId;
	private String storeId;
	private String orderContents;
	private double endLat;
	private double endLng;
	private String endAddr;
	private String deliveryTip;
	private String cookedTime;
}
