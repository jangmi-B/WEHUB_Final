package com.kh.wehub.project.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.vo.Message;
import com.kh.wehub.project.model.vo.Project;

@Mapper
public interface ProjectDao {

	int getProjectCount(Map<String, Object> map);

	List<Project> getProjectList(RowBounds rowBounds, Map<String, Object> map);

	List<Member> getSearchMember(String userName);

	int makeProject(Project project);

	Member findReceiver(@Param(value="name") String name, @Param(value="rank") String rank, @Param(value="deptName") String deptName);

	int sendProjectMsg(Map<String, Object> map);

	int makeFav(Map<String, Object> map);

	int removeFav(Map<String, Object> map);

	int findStatus(Map<String, Object> map);

	int getParticipantCount(Map<String, Object> map);

	List<Project> getParticipantList(RowBounds rowBounds, Map<String, Object> map);

	int getFavCount(Map<String, Object> map);

	List<Project> getFavList(RowBounds rowBounds, Map<String, Object> map);

	int closeProject(int proNo);

	List<Project> homeProjectList(int userNo);

}
