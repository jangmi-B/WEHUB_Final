package com.kh.wehub.memo.model.service;

import java.util.List;
import java.util.Map;

import com.kh.wehub.memo.model.vo.Memo;

public interface MemoService {

	List<Memo> getMemoList(int userNo);

	int updateMemo(Map<String, Object> map);

	int getMemoCount(int user_no);

	int insertMemo(Map<String, Object> map);

	int clearMemo(int userNo);



}
