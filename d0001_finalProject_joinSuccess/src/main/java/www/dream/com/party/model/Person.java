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
	private static List<AuthorityVO> listAuthority = new ArrayList<>();
	static {
		listAuthority.add(new AuthorityVO("member"));
	}
	
	private String sex;
	private String userPwd;
	private String state;
	
	public Person(String userId) {
		super(userId);
	}
	
	@Override
	public List<AuthorityVO> getAuthorityList() {
		return listAuthority;
	}
	
}
