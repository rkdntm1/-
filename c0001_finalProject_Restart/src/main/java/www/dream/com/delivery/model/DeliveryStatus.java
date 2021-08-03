package www.dream.com.delivery.model;

public enum DeliveryStatus {
// 배차대기, 배차완료, 배송중, 배송완료, 예외
	pending("배차대기"), matched("배차완료"), inTransit("배송중"), completed("배송완료"), exception("예외"), cancel("취소");

	private final String value;

	DeliveryStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}
}
