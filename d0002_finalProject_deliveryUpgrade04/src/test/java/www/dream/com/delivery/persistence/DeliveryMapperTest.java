package www.dream.com.delivery.persistence;

import static org.junit.Assert.assertNotNull;

import org.apache.ibatis.annotations.Param;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import www.dream.com.delivery.model.DeliveryCancel;
import www.dream.com.delivery.model.DeliveryCompleted;
import www.dream.com.delivery.model.DeliveryPerformVO;
import www.dream.com.delivery.model.DeliveryRequestVO;
import www.dream.com.delivery.model.DeliveryStatus;
import www.dream.com.delivery.model.DeliveryinTransit;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DeliveryMapperTest {
	@Autowired
	private DeliveryMapper delMapper;

	
	//@Test
	public void test100GetList() {
		assertNotNull(delMapper);
		DeliveryStatus st = new DeliveryStatus();
		st.setStatus("inTransit");
		try {
			delMapper.getList("riderthirsty5", st).forEach(board->{
				System.out.println(board);
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//@Test
	public void test200getRiderPriority() {
			try {
				delMapper.getRiderPriority("storethirsty5").forEach(board -> {
					System.out.println(board);
				});
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	
//	public int insertRequest(@Param("request") DeliveryRequestVO request);
//
//	public int insertPerform(@Param("perform") DeliveryPerformVO perform);
//
//	public int insertInTransit(@Param("inTransit") DeliveryinTransit inTransit);
//
//	public int insertCompleted(@Param("completed") DeliveryCompleted completed);
//
//	public int insertCancel(@Param("cancel") DeliveryCancel cancel);
	
	
	@Test
	public void test300InsertDelivery() {
		try {
			DeliveryRequestVO request = new DeliveryRequestVO();
			delMapper.insertRequest(request);
			System.out.println("지금 만든 객체의 아이디는 " + request.getId() + "책 기준 191쪽 참조");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
}
