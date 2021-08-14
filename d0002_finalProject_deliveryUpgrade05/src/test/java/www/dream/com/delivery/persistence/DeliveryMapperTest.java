package www.dream.com.delivery.persistence;

import org.junit.FixMethodOrder;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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

	// @Test
	public void test100GetList() {
		//assertNotNull(delMapper);
		DeliveryStatus st = new DeliveryStatus();
		st.setStatus("inTransit");
		try {
			delMapper.getList("riderthirsty5", st).forEach(board -> {
				System.out.println(board);
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//********************************* 라이더 우선순위 뽑기 ******************************************************************************************//
	
	/* resultType이 list,arraylist가 아닌 string인 이유
	 * 한 행을 객체로 보기때문에 한 행을 객체 string으로 차곡차곡 담은 뒤 mybatis가 알아서 리스트로 넣어주기 때문이다. 
	 * 애초에 설계가 그렇게 되어있다. (프레임워크가 원래 그렇다.) 
	 * 출처 : https://smujihoon.tistory.com/112
	 * 라이더 우선순위를 뽑는 클래스를 따로 만들어야 하나?
	 */
	
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
	
//********************************** insert 관련  test ***************************************************************************************//	
	
	// @Test
	public void test300InsertRequest() {
		try {
			DeliveryRequestVO request = new DeliveryRequestVO("member5", "storethirsty5", "물", 37.481769663825915,
					126.88155754018804, "애슐리", "2000", "20분");
			delMapper.insertRequest(request);
			System.out.println("지금 만든 객체의 아이디는 " + request.getId() + " 가게가 요청버튼을 눌렀음");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//public int insertCancel(@Param("cancel") DeliveryCancel cancel); 애매하다. 취소건을 어떻게 관리해야할지 감이안온다.

	// @Test
	public void test301InsertPerform() {
		DeliveryRequestVO rqst = new DeliveryRequestVO();
		rqst.setId("00002");
		try {
			DeliveryPerformVO perform = new DeliveryPerformVO(rqst, "ghostrider5");
			delMapper.insertPerform(perform);
			System.out.println("지금 만든 객체의 아이디는 " + perform.getId() + " 라이더가 이 요청건을 수행하겠다고 했음");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// @Test
	public void test301InsertInTransit() {
		DeliveryRequestVO rqst = new DeliveryRequestVO();
		rqst.setId("00002");
		DeliveryPerformVO perform = new DeliveryPerformVO(rqst, "ghostrider5");

		try {
			DeliveryPerformVO inTransit = new DeliveryinTransit(perform);
			delMapper.insertInTransit(inTransit);
			System.out.println("지금 만든 객체의 아이디는 " + inTransit.getId() + " 라이더가 픽업 완료했음");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// @Test
	public void test301InsertCompleted() {
		DeliveryRequestVO rqst = new DeliveryRequestVO();
		rqst.setId("00002");
		DeliveryPerformVO perform = new DeliveryPerformVO(rqst, "ghostrider5");

		try {
			DeliveryPerformVO completed = new DeliveryCompleted(perform);
			delMapper.insertCompleted(completed);
			System.out.println("지금 만든 객체의 아이디는 " + completed.getId() + " 라이더가 물건을 잘 전달해줬음");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
