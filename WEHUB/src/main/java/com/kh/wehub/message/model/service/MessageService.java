package com.kh.wehub.message.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.vo.Message;

public interface MessageService {

	List<Message> getReceiveList(PageInfo pageInfo, Map<String, Object> map); //받은메세지함
	
	int getMsgCount(Map<String, Object> map); //페이징 하기위한 메세지 갯수
	
	int deleteMsg(int msgNo); //받은메세지함 메세지 삭제
	
	int deleteCheckMsg(List<Integer> checkList); //받은쪽지함 삭제
	
	int readCheckMsg(int msgNo); // 메세지 detail 확인 시 readStatus Y로 변경
	
	int readCheckSelected(List<Integer> checkList); //선택된 메세지 삭제
	
	int saveSelected(List<Integer> checkList); //선택된 메세지 보관
	
	Member getReceiver(Map<String, Object> map); //받는사람 사번 가져오기
	
	int sendMsg(Message Message); //쪽지보내기
	
	int getSendMsgCount(Map<String, Object> map); // 보낸메세지 개수
	
	List<Message> getSendList(PageInfo pageInfo, Map<String, Object> map); //보낸메세지 리스트
	
	int deleteCheckSendMsg(List<Integer> checkList); //보낸메세지 선택삭제
	
	int deleteSendMsg(int msgNo); //보낸메세지 detail 삭제
	
	int saveSendSelected(List<Integer> checkList); //보낸메세지 보관

	int getDeletedMsgCount(Map<String, Object> map); // 휴지통 리스트 개수
	
	List<Message> getDeletedList(PageInfo pageInfo, Map<String, Object> map); //휴지통 리스트
	
	List<Member> getSearchMember(String user_name); //쪽지 자동완성
	
	int deleteCheckDeletedMsg(List<Integer> checkList); // 휴지통 선택 메세지 완전삭제
	
	int deletedMsgDelete(int msgNo); //휴지통 detail 삭제
	
	int getSaveRecCount(Map<String, Object> map); // 받은쪽지 보관함 리스트 개수
	
	List<Message> getSaveList(PageInfo pageInfo, Map<String, Object> map); //받은쪽지 보관함 리스트
	
	int saveSendMsgCount(Map<String, Object> map); //보낸메세지 보관함 카운트
	
	List<Message> getSaveSendList(PageInfo pageInfo, Map<String, Object> map); //보낸쪽지 보관함 리스트

	int getUnreadCheck(int user_no);

}
