package www.dream.com.order.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import www.dream.com.common.model.CommonMngVO;

@Data
public class OrderList extends CommonMngVO {
	private String id;
	private String msg;
	
	public List<DetailOrder> listDetailOrder = new ArrayList<>();
	
}
