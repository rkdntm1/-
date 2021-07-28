package www.dream.com.delivery.model;

public enum RiderStatus {
	//delivery Request Status 배차대기, 배차완료, 배송중, 배송완료
	pending("배차대기"), matching("배차완료"), inTransit("배송중"), delivered("배송완료"),
	//Rider Status 오프라인, 온라인(배차대기), 배송중(배송중), 자리비움  
	offline("오프라인"), brb("자리비움");
	
	private final String value;

	RiderStatus(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}
	
}
