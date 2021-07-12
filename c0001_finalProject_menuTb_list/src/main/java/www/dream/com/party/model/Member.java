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
public class Member extends Party {
	private static List<AuthorityVO> listAuthority = new ArrayList<>();
	static {
		listAuthority.add(new AuthorityVO("member"));
	}
	@Override
	public List<AuthorityVO> getAuthorityList() {
		return listAuthority;
	}
	public Member(String userId) {
		super(userId);
	}
	
}
