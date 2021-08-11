package www.dream.com.party.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 회원
 * @author ivarBae
 */
@Data
@NoArgsConstructor
public class Person extends Party {
	private static List<AccountabilityTypeVO> listAccountability = new ArrayList<>();
	static {
		listAccountability.add(new AccountabilityTypeVO("MEMBER"));
	}
	
	private String sex;
	private String userPwd;
	private String state;
	
	public Person(String userId) {
		super(userId);
	}
	
	@Override
	public List<AccountabilityTypeVO> getListAccountability() {
		return listAccountability;
	}
	
}
