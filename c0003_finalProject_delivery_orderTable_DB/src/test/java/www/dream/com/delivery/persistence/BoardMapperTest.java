package www.dream.com.delivery.persistence;

import static org.junit.Assert.assertNotNull;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class BoardMapperTest {
	@Autowired
	private DeliveryMapper delMapper;

	@Test
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
