package www.dream.com.delivery.model;

public enum DeliveryStatus {
// 주문대기, 배송중, 배송완료, 주문취소
	pending("주문대기"), matching("배차완료"), inTransit("배송중"), delivered("배송완료"), cancelled("주문취소");

	private final String value;

	DeliveryStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}
}
