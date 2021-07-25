package www.dream.com.delivery.persistence;

import static org.junit.Assert.assertNotNull;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import www.dream.com.order.model.OrderList;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DeliveryMapperTest {
	@Autowired
	private DeliveryMapper delMapper;

	//@Test
	public void test000GetList() {
		assertNotNull(delMapper);
		try {
			delMapper.getList(3).forEach(board->{
				System.out.println(board);
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
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
