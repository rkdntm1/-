package www.dream.com.delivery.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import www.dream.com.delivery.model.DeliveryCancel;
import www.dream.com.delivery.model.DeliveryPerformVO;
import www.dream.com.delivery.model.DeliveryRequestVO;
import www.dream.com.delivery.persistence.DeliveryMapper;

@Service
public class DeliveryService {
	@Autowired
	private DeliveryMapper deliveryMapper;
	
//	public List<DeliveryVO> getList(String userId, DeliveryStatus descrim){
//		return deliveryMapper.getList(userId, descrim);
//	}
	
	public List<String> getRiderPriority(String storeId){
		return deliveryMapper.getRiderPriority(storeId);
	};


	@Transactional
	public int insertRequest(DeliveryRequestVO request) {
		int success = deliveryMapper.insertRequest(request);
		return success;
	}
	
	public int insertPerform(DeliveryPerformVO perform) {
		int success = deliveryMapper.insertPerform(perform);
		return success;
	}
	
	public int insertInTransit(DeliveryPerformVO inTransit) {
		int success = deliveryMapper.insertInTransit(inTransit);
		return success;
	}
	
	public int insertCompleted(DeliveryPerformVO completed) {
		int success = deliveryMapper.insertCompleted(completed);
		return success;
	}
	
	public int insertCancel(DeliveryCancel cancel) {
		int success = deliveryMapper.insertCancel(cancel);
		return success;
	}
	
	
}
