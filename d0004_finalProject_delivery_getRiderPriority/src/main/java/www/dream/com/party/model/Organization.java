package www.dream.com.party.model;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 시스템 운영자
 * @author ivarBae
 */
@Data
@NoArgsConstructor
public class Organization extends Party {
	private String	storeInfo;
	
	public Organization(String userId) {
		super(userId);
	}

	@Override
	public List<AccountabilityTypeVO> getListAccountability() {
		return null;
	}

}
