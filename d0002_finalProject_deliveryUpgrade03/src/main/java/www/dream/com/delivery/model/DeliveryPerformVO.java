package www.dream.com.delivery.model;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.framework.langPosAnalyzer.HashTarget;
import www.dream.com.framework.printer.ClassPrintTarget;
import www.dream.com.framework.printer.PrintTarget;
@Data
@NoArgsConstructor
@ClassPrintTarget
public class DeliveryPerformVO extends DeliveryVO {
	
	// descrim : 수행건
	public static final String DESCRIM4PERFORM = "perform"; 
	
	private String reqId;
	@PrintTarget(order= 800, caption = "라이더")
	private String riderId;
	
	@HashTarget
	private DeliveryRequestVO request;


}
