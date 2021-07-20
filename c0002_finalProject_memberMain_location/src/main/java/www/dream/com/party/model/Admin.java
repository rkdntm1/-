package www.dream.com.party.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;

import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 사장. 운영자 등록, 삭제 권한 있음
 * @author ivarBae
 */
@Data
@NoArgsConstructor
public class Admin extends Party {
	private static List<AuthorityVO> listAuthority = new ArrayList<>();
	static {
		listAuthority.add(new AuthorityVO("Admin"));
		listAuthority.add(new AuthorityVO("Member"));
		listAuthority.add(new AuthorityVO("Rider"));
		listAuthority.add(new AuthorityVO("Store"));
	}
	@Override
	public List<AuthorityVO> getAuthorityList() {
		return listAuthority;
	}
	public Admin(String userId) {
		super(userId);
	}

	@Override
	public String toString() {
		return "Admin [toString()=" + super.toString() + "]";
	}
}
