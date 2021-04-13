package com.kh.wehub.project.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.wehub.common.util.PageInfo;
import com.kh.wehub.member.model.vo.Member;
import com.kh.wehub.message.model.vo.Message;
import com.kh.wehub.project.model.dao.ProjectDao;
import com.kh.wehub.project.model.vo.Project;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Autowired
	private ProjectDao projectDao;

	@Override
	public int getProjectCount(Map<String, Object> map) {
		
		return projectDao.getProjectCount(map);
	}

	@Override
	public List<Project> getProjectList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return projectDao.getProjectList(rowBounds, map);
	}

	@Override
	public List<Member> getSearchMember(String userName) {
		
		return projectDao.getSearchMember(userName);
	}

	@Override
	@Transactional
	public int makeProject(Project project) {
		int result = 0;
		
		result = projectDao.makeProject(project);
		
		return result;
	}

	@Override
	public Member findReceiver(String name, String rank, String deptName) {
		
		return projectDao.findReceiver(name,rank, deptName);
	}

	@Override
	public int sendProjectMsg(Map<String, Object> map) {
		int result = 0;
		
		result = projectDao.sendProjectMsg(map);
		
		return result;
	}

	@Override
	public int makeFav(Map<String, Object> map) {
		int result = 0;
		
		result = projectDao.makeFav(map);
		
		return result;
	}

	@Override
	public int removeFav(Map<String, Object> map) {
		int result = 0;
		
		result = projectDao.removeFav(map);
		
		return result;
	}

	@Override
	public int findStatus(Map<String,Object> map) {
		
		return projectDao.findStatus(map);
	}

	@Override
	public int getParticipantCount(Map<String, Object> map) {
		
		return projectDao.getParticipantCount(map);
	}

	@Override
	public List<Project> getParticipantList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return projectDao.getParticipantList(rowBounds, map);
	}

	@Override
	public int getFavCount(Map<String, Object> map) {
		
		return projectDao.getFavCount(map);
	}

	@Override
	public List<Project> getFavList(PageInfo pageInfo, Map<String, Object> map) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		RowBounds rowBounds = new RowBounds(offset, pageInfo.getListLimit());
		
		return projectDao.getFavList(rowBounds, map);
	}

	@Override
	public int closeProject(int proNo) {
		
		return projectDao.closeProject(proNo);
	}

}
