package www.dream.com.party.model;

import java.util.Date;

import org.springframework.security.core.GrantedAuthority;

import lombok.Data;
import lombok.NoArgsConstructor;
/**
 * 주체 - 객체의 책임 관계를 나타냄
 * @author qoddn987
 *
 */
@Data
@NoArgsConstructor
public class Accountability {
	private String ownerId;
	private String respId;
	private String accType;
	private Date fromDate;
	private Date thruDate;
	
}
