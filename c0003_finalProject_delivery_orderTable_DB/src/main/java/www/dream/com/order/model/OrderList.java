package www.dream.com.order.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class OrderList {
	private String id;
	private String msg;
	
	private List<DetailOrder> listDetailOrder = new ArrayList<>();
	
}
