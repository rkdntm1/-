package www.dream.com.party.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;
import www.dream.com.common.model.CommonMngVO;
import www.dream.com.framework.printer.ClassPrintTarget;
import www.dream.com.framework.printer.PrintTarget;
import www.dream.com.hashTag.model.IHashTagOpponent;

/**
 * 모든 행위자 정보의 공통적인 상위 정보를 담고 있는 추상적인 클래스
 * 
 * @author ivarBae
 */
@Data
@NoArgsConstructor
@ClassPrintTarget

public abstract class Party extends CommonMngVO implements IHashTagOpponent{
	private String userId; // 로그인 ID
	@PrintTarget(order = 250, caption = "작성자")
	private String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birthDate; // 탄생일
	private String descrim;
	// 1 : N 관계에 대한 속성
	//연락처 정보
	private List<ContactPoint> listContactPoint = new ArrayList<>();
	
	//위치 정보
	private Location location;

	public Party(String userId) {
		this.userId = userId;
	}
	
	public String getId() {
		return userId;
	}
	public String getType() {
		return "Party";
	}
	
	public void addContactPoint(ContactPoint cp) {
		listContactPoint.add(cp);
	}

}
