package www.dream.com.delivery.persistence;

import static org.junit.Assert.assertNotNull;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import www.dream.com.delivery.model.DeliveryStatus;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class DeliveryMapperTest {
	@Autowired
	private DeliveryMapper delMapper;

	
	//@Test
	public void test000GetList() {
		assertNotNull(delMapper);
		DeliveryStatus st = new DeliveryStatus();
		st.setStatus("request");
		try {
			delMapper.getList("storethirsty5", st).forEach(board->{
				System.out.println(board);
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void test300getRiderPriority() {
			try {
				delMapper.getRiderPriority("storethirsty5").forEach(board -> {
					System.out.println(board);
				});
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
//			if(result != null && result.size() > 0){
//			    
//			    for(int i = 0; result.size() > i; i++){
//			        
//			        Iterator<String> keys = result.get(i).keySet().iterator();
//			        while( keys.hasNext() ){
//			            
//			            String key = keys.next();
//			            String val1 = String.valueOf(result.get(i).get(key)); //result.get(i).get(key) 최근 집계된 값
//			            String val2 = String.valueOf(result.get(i).get(key)); //resultOld.get(i).get(key) 이전 집계된 값
//			 
//			            if(!val1.equals(val2)){ //서로 값이 다른 경우, 변경된 값을 같이 보여준다.
//			                
//			 //               int inputValue = val1 + "[[" + val2 + "]]";
//			   //             result.get(i).put(key, inputValue);
//			            }
//			        }
//			    }
//			}
//		
//		
//		}
		
		
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
