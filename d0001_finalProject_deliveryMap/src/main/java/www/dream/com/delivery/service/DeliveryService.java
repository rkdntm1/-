package www.dream.com.delivery.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import www.dream.com.delivery.model.DeliveryRequestVO;
import www.dream.com.delivery.persistence.DeliveryMapper;
import www.dream.com.order.model.OrderList;
import www.dream.com.party.model.Party;

@Service
public class DeliveryService {
	@Autowired
	private DeliveryMapper deliveryMapper;
	
	private static final double radiusLatitude = 0.009094;
	private static final double radiusLongitude = 0.011268;
	
	public List<DeliveryRequestVO> getList(int boardId){
		return deliveryMapper.getList(boardId);
	}
	
	public List<DeliveryRequestVO> searchDeliveryList(Party curUser) {
		return deliveryMapper.searchDeliveryRequestList(curUser);
	}
	
	public List<DeliveryRequestVO> searchDeliveryRiderList(Party curUser) {
		return deliveryMapper.searchDeliveryRiderList(curUser);
	}
	
	
//	public List<DeliveryRequestVO> matchingRequest(Party curUser) {
//		return deliveryMapper.matchingRequest(curUser,RiderStatus.valueOf("pending"));
//	}
	
	public int registerRequest(OrderList order) {
		return deliveryMapper.registerRequest(order);
	}

	//reqId값으로 request 객체 조회
	public DeliveryRequestVO findRequestById(String reqId) {
		return (DeliveryRequestVO) deliveryMapper.findRequestById(reqId);
	}
	
	public int updateRequest(String requestId, Party curUser) {
		return deliveryMapper.updateRequest(requestId, curUser);
	}



	// *****************************************************************************************************************

	/*
	 * public int getCountOfReply(String replyId) { int idLength = replyId.length()
	 * + ReplyVO.ID_LENGTH; return replyMapper.getAllReplyCount(replyId, idLength);
	 * }
	 */

	/*
	 * public ComparablePair<Criteria, List<ReplyVO>> getReplyListWithPaging(String
	 * originalId, Criteria cri) { int idLength = originalId.length() +
	 * ReplyVO.ID_LENGTH; cri.setTotal(replyMapper.getReplyCount(originalId,
	 * idLength)); ComparablePair<Criteria, List<ReplyVO>> ret = new
	 * ComparablePair<>(cri, replyMapper.getReplyListWithPaging(originalId,
	 * idLength, cri)); return ret; }
	 */

	/*
	 * public List<ReplyVO> getReplyListOfReply(String replyId) { int idLength =
	 * replyId.length() + ReplyVO.ID_LENGTH; List<ReplyVO> justRead =
	 * replyMapper.getReplyListOfReply(replyId, idLength); return
	 * ReplyVO.buildCompositeHierachy(justRead); // return justRead; }
	 */
	
	/*
	 * public ReplyVO findReplyById(String id) { return
	 * replyMapper.findReplyById(id); }
	 */

	/*
	 * public int updateReply(ReplyVO reply) { return
	 * replyMapper.updateReply(reply); }
	 */

	/*
	 * public int deleteReplyById(String id) { return
	 * replyMapper.deleteReplyById(id); }
	 */
}
