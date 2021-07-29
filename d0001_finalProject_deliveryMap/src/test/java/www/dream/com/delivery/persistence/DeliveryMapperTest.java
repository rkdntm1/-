package www.dream.com.delivery.persistence;

import org.junit.FixMethodOrder;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import www.dream.com.order.model.OrderList;
import www.dream.com.party.model.Post;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DeliveryMapperTest {
	@Autowired
	private DeliveryMapper delMapper;

	
	Post rider = new Post();
	
//	@Test
//	public void test000GetList() {
//		assertNotNull(delMapper);
//		try {
//			rider.setUserId("rider3");
//			delMapper.matchingRequest(rider,RiderStatus.valueOf("matching")).forEach(board->{
//				System.out.println(board);
//			});
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
	//@Test
	public void test300GetList() {
			OrderList order = new OrderList();
			order.setId("aaaaa");
			order.setMemberId("memberthirsty");
			order.setStoreId("storethirsty");
			order.setMsg("뀨");
		}
	

	//@Test
//	public void test001GetBoard() {
//		assertNotNull(boardMapper);
//		try {
//			System.out.println(boardMapper.getBoard(2));
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}
