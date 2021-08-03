package www.dream.com.common.model;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;
import www.dream.com.framework.printer.PrintTarget;

/**
 * 공통 관리 정보
 * @author ivarBae
 */

@Data
public abstract class CommonMngVO {
	private Date registrationDate;	//등록시점
	private Date updateDate;	//수정시점
	
	public String getFormattedUpdateDate() {
		if (updateDate != null) {
			SimpleDateFormat  fmt = new SimpleDateFormat("HH:mm:ss");
			return fmt.format(updateDate);
		}
		return "";
	}
	
	@Override
	public String toString() {
		return "CommonMngVO [등록일=" + registrationDate + ", 수정일=" + updateDate + "]";
	}
}
