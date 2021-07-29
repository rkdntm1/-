package www.dream.com.delivery.model;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.common.model.CommonMngVO;
import www.dream.com.framework.printer.AnchorTarget;
import www.dream.com.framework.printer.ClassPrintTarget;


@Data
@NoArgsConstructor
public class DeliveryVO extends CommonMngVO{
	private String id;
	private DeliveryStatus status;
	private String descrim;
	private DeliveryException exception;

	
}
