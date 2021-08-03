package www.dream.com.party.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;

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
	public List<AuthorityVO> getAuthorityList() {
		return null;
	}

}
