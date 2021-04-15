package com.kh.wehub.memo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.kh.wehub.memo.model.vo.Memo;

@Mapper
public interface MemoDao {

	List<Memo> getMemoList(int userNo);

	int updateMemo(Map<String, Object> map);

	int getMemoCount(int userNo);

	int insertMemo(Map<String, Object> map);

	int clearMemo(int userNo);

}
