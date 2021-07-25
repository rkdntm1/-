package www.dream.com.party.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.NoArgsConstructor;
import www.dream.com.framework.springSecurityAdapter.CustomUser;
import www.dream.com.party.model.ContactTypeVO;
import www.dream.com.party.model.LocationType;
import www.dream.com.party.model.Member;
import www.dream.com.party.model.Party;
import www.dream.com.party.persistence.PartyMapper;

@Service
@NoArgsConstructor
public class PartyService implements UserDetailsService {
	@Autowired
	private PartyMapper partyMapper;
	
	public List<Party> getList() {
		return partyMapper.getList();
	}

	//연락처 목록 조회
	public List<ContactTypeVO> getCPTypeList() {
		return partyMapper.getCPTypeList();
	}
	
	public void joinMember(Member m) {
		partyMapper.joinMember(m);
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Party loginParty = partyMapper.findPartyByUserId(username);
		return loginParty == null ? null : new CustomUser(loginParty);
	}

//	public boolean IDDuplicateCheck(String userId) {
//		if (partyMapper.IDDuplicateCheck(userId) == 1) {
//			return true;	
//		}
//	   return false;
//	}
	
	public int IDDuplicateCheck(String userId) {
	   return partyMapper.IDDuplicateCheck(userId);
	}

	//위치정보 목록 조회
	public List<LocationType> getLocTypeList() {
		return partyMapper.getLocTypeList();
	}

	public Party chkIdDup(String newBieId) {
		return partyMapper.findPartyByUserId(newBieId);
	}
}
