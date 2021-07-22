package www.dream.com.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import www.dream.com.order.model.DetailOrder;
import www.dream.com.order.model.OrderList;
import www.dream.com.order.persistence.OrderMapper;

@Service
public class OrderService {
	@Autowired
	private OrderMapper orderMapper;
//
//	public List<DeliveryRequestVO> getList(int boardId){
//		return deliveryMapper.getList(boardId);
//	}
//	
//	public int insertRequest(String requestId, DeliveryRequestVO request) {
//		return deliveryMapper.insertRequest(requestId, request);
//	}

	public List<OrderList> getOrderListById(String userId) {
		return orderMapper.getOrderListById(userId);
	}

	public int insertOrder(String memberId, OrderList orderList) {
		return orderMapper.insertOrder(memberId, orderList);
	}

	public int insertDetailOrder(String memberId, OrderList orderList, DetailOrder detailOrder) {
		return orderMapper.insertDetailOrder(memberId, orderList, detailOrder);
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
