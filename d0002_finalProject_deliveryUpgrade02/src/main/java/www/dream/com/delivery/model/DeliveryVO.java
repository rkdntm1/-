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
public class DeliveryVO extends CommonMngVO {
	@PrintTarget(order= 100, caption = "번호")
	private String id;
	private String descrim;
	
	private DeliveryStatus status;
	private DeliveryException exception;
	
	public DeliveryVO(String id) {
		this.id = id;
	}
	
	public String getId() {
		return id;
	}
	
	
}
