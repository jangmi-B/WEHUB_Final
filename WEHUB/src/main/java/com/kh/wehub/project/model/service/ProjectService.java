package com.kh.wehub.project.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.vo.Message;
import com.kh.wehub.project.model.vo.Project;

public interface ProjectService {

	int getProjectCount(Map<String, Object> map);

	List<Project> getProjectList(PageInfo pageInfo, Map<String, Object> map);

	List<Member> getSearchMember(String userName);

	int makeProject(Project project);

	Member findReceiver(String name, String rank, String deptName);

	int sendProjectMsg(Map<String, Object> map);

	int makeFav(Map<String, Object> map);

	int removeFav(Map<String, Object> map);

	int findStatus(Map<String,Object> map);

	int getParticipantCount(Map<String, Object> map);

	List<Project> getParticipantList(PageInfo pageInfo, Map<String, Object> map);

	int getFavCount(Map<String, Object> map);

	List<Project> getFavList(PageInfo pageInfo, Map<String, Object> map);

	int closeProject(int proNo);

	List<Project> homeProjectList(int user_no); //home화면 리스트 불러오기

	int getEndProjectCount(Map<String, Object> map); // 종료된 프로젝트

	List<Project> getEndProjectList(PageInfo pageInfo, Map<String, Object> map);

}
