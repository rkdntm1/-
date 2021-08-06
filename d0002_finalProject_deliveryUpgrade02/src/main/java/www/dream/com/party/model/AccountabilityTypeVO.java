package www.dream.com.party.model;

import org.springframework.security.core.GrantedAuthority;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AccountabilityTypeVO implements GrantedAuthority{
	private String accType;
	private String description;
	
	@Override
	public String getAuthority() {
		return accType;
	}
	
	public AccountabilityTypeVO(String accType) {
		this.accType = accType;
	}
}
