package www.dream.com.delivery.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.common.model.CommonMngVO;
import www.dream.com.framework.printer.AnchorTarget;
import www.dream.com.framework.printer.ClassPrintTarget;

@Data
@NoArgsConstructor
@ClassPrintTarget
public class DeliveryVO extends CommonMngVO {

	@AnchorTarget
	private String id;
	private DeliveryStatus status;
	private DeliveryException exception;

}
