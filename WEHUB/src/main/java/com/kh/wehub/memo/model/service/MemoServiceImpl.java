package com.kh.wehub.memo.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.wehub.memo.model.dao.MemoDao;
import com.kh.wehub.memo.model.vo.Memo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemoServiceImpl implements MemoService {
	
	@Autowired
	private MemoDao memoDao;

	@Override
	public List<Memo> getMemoList(int userNo) {
		
		return memoDao.getMemoList(userNo);
	}

	@Override
	public int updateMemo(Map<String, Object> map) {
		int result = 0;
		
		result = memoDao.updateMemo(map);
		
		return result;
	}

	@Override
	public int getMemoCount(int userNo) {
		
		return memoDao.getMemoCount(userNo);
	}

	@Override
	public int insertMemo(Map<String, Object> map) {
		int result = 0;
		
		result = memoDao.insertMemo(map);
		
		return result;
	}

}
