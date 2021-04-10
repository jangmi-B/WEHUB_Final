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

	int makeFav(int proNum);

	int removeFav(int proNum);

	Project findStatus(int proNum);

	int getParticipantCount(Map<String, Object> map);

	List<Project> getParticipantList(PageInfo pageInfo, Map<String, Object> map);

	int getFavCount(Map<String, Object> map);

	List<Project> getFavList(PageInfo pageInfo, Map<String, Object> map);

}
