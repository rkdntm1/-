--======================================================================================================================================================

<!-- public List<DeliveryRequestVO> getList(@Param("boardId") int userId, @Param("cri") 
		Criteria cri) 김혜윰님 감쏴 Oracle12부터 지원됩니다 select p.*, w.name w_name, w.descrim 
		w_descrim from ( select p.*, rownum rn from s_post p where board_id = #{boardId} 
		and rownum <= #{cri.pageNumber} * #{cri.amount} order by id desc ) p, s_party 
		w where p.rn > (#{cri.pageNumber} - 1) * #{cri.amount} and p.writer_id = 
		w.user_id -->
	<select id="getList" resultMap="rmReply">
	<![CDATA[
	select p.*, w.name w_name, w.descrim w_descrim
	  from (
	      select p.*, pc.reply_cnt
		from (
        select p.id, count(r.id) reply_cnt
		  		from (
				       SELECT *
			             FROM s_reply
			            where board_id = #{boardId}
			            ORDER BY id DESC
			           OFFSET (#{cri.pageNumber} - 1) * #{cri.amount} ROWS FETCH FIRST #{cri.amount} ROWS ONLY
			       ) p left outer join s_reply r
	        on r.id like p.id || '%'
	     and length(r.id) > length(p.id)
	     group by p.id ) pc, s_reply p
	where pc.id = p.id
	 ORDER BY p.id DESC
	       ) p, s_party w
	 where p.writer_id = w.user_id
	]]>
	</select>







--======================================================================================================================================================

	<!-- public int insertRequest (@Param("request") DeliveryRequestVO request); -->
	
	<insert id="insertRequest">
	
		<selectKey keyProperty="request.id" order="BEFORE" resultType="string">
			select get_id(SEQ_DELIVERY_ID.nextval) from dual
		</selectKey>
		
		insert into b_delivery (id, status, member_id, store_id, order_contents, 
		req_end_lat, req_end_lng, req_end_addr, req_delivery_tip, req_cooked_time)
			values (#{request.id}, #{request.DESCRIM4REQUEST}, #{request.memberId}, #{request.storeId}, #{request.orderContents},
			#{request.endLat}, #{request.endLng}, #{request.endAddrd}, #{request.deliveryTip}, #{request.cookedTime})
    
	</insert>
	
--======================================================================================================================================================
	
	<!-- public int insertPerform (@Param("perform") DeliveryPerformVO perform); -->
	
	<insert id="insertPerform">
	
		<selectKey keyProperty="perform.id" order="BEFORE" resultType="string">
			select get_id(SEQ_DELIVERY_ID.nextval) from dual
		</selectKey>
		
		insert into b_delivery (id, status, req_id, rider_id)
			values (#{perform.id}, #{perform.DESCRIM4PERFORM}, #{perform.request.getId},  #{perform.riderId})
    
	</insert>
	
--======================================================================================================================================================	
	
	<!-- public int insertInTransit (@Param("inTransit") DeliveryinTransit inTransit); -->
	
	<insert id="insertInTransit">
	
		<selectKey keyProperty="inTransit.id" order="BEFORE" resultType="string">
			select get_id(SEQ_DELIVERY_ID.nextval) from dual
		</selectKey>
		
		insert into b_delivery (id, status, req_id, rider_id)
			values (#{inTransit.id}, #{perform.DESCRIM4INTRANSIT}, #{inTransit.reqId},  #{inTransit.riderId})
    
	</insert>
	
--======================================================================================================================================================	
	
	<!-- public int insertCompleted (@Param("completed") DeliveryCompleted completed); -->
	
	<insert id="insertCompleted">
	
		<selectKey keyProperty="completed.id" order="BEFORE" resultType="string">
			select get_id(SEQ_DELIVERY_ID.nextval) from dual
		</selectKey>
		
		insert into b_delivery (id, status, req_id, rider_id)
			values (#{completed.id}, #{completed.DESCRIM4COMPLETED}, #{completed.reqId},  #{completed.riderId})
    
	</insert>
	
--======================================================================================================================================================	
	
	<!-- public int insertCancel (@Param("cancel") DeliveryCancel cancel); -->
	
	<insert id="insertCancel">
	
		<selectKey keyProperty="cancel.id" order="BEFORE" resultType="string">
			select get_id(SEQ_DELIVERY_ID.nextval) from dual
		</selectKey>
		
		insert into b_delivery (id, status, req_id, rider_id)
			values (#{cancel.id}, #{completed.DESCRIM4COMPLETED}, #{completed.reqId},  #{completed.riderId})
    
	</insert>
	
--======================================================================================================================================================	