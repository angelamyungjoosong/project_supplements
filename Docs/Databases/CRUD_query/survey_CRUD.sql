-- 질문을 뽑아오는 쿼리 
SELECT Q.SURVEY_QUESTION, Q.SURVEY_QUESTION_ID
FROM survey_type_for_question AS T
INNER JOIN survey_question AS Q
ON T.SURVEY_QUESTION_ID = Q.SURVEY_QUESTION_ID
WHERE T.SURVEY_TYPE_ID = 'F-01';

-- 답변 뽑아오는 쿼리 
select O.SURVEY_QUESTION_ID, O.SURVEY_OPT, O.SURVEY_OPT_ID 
from survey_opt AS O
	;

-- 질문과 답항을 뽑아오는 쿼리(복용x) 
SELECT Q.SURVEY_QUESTION, O.SURVEY_OPT, Q.SURVEY_QUESTION_ID
FROM survey_type_for_question AS T
INNER JOIN survey_question AS Q 
ON T.SURVEY_QUESTION_ID = Q.SURVEY_QUESTION_ID
LEFT JOIN survey_opt AS O 
ON Q.SURVEY_QUESTION_ID = O.SURVEY_QUESTION_ID
WHERE T.SURVEY_TYPE_ID = 'F-01'
ORDER BY O.OPT_ORDER;

-- 질문과 답항을 뽑아오는 쿼리( 복용o)
SELECT Q.SURVEY_QUESTION, O.SURVEY_OPT, Q.SURVEY_QUESTION_ID
FROM survey_type_for_question AS T
INNER JOIN survey_question AS Q 
ON T.SURVEY_QUESTION_ID = Q.SURVEY_QUESTION_ID
LEFT JOIN survey_opt AS O 
ON Q.SURVEY_QUESTION_ID = O.SURVEY_QUESTION_ID
WHERE T.SURVEY_TYPE_ID = 'F-02'
ORDER BY Q.QUESTION_ORDER, O.OPT_ORDER;

-- 설문조사 결과 INSERT 
INSERT INTO surveyresult
(USER_ID, DATE_TIME, SURVEY_UID)
VALUES 
('honggd123',NOW(), 'SUID_78');

INSERT INTO survey (SURVEY_TYPE_ID, SURVEY_QUESTION_ID, SURVEY_ID,SURVEY_OPT_ID, SURVEY_UID)    
VALUES      ('F-01', 'Q-01', 'SU-550','O-01', 'SUID_77');


 -- 특정 복용한 사람 USER_ID가 선택한 보조제를 나오게 하는 쿼리문(각각 따로) 
SELECT SO.SURVEY_OPT
FROM SURVEYRESULT AS SR
INNER JOIN SURVEY AS S
ON SR.SURVEY_UID = S.SURVEY_UID
INNER JOIN SURVEY_OPT AS SO
ON S.SURVEY_OPT_ID = SO.SURVEY_OPT_ID
WHERE S.SURVEY_QUESTION_ID = 'Q-06' AND SR.USER_ID = 'kimeh456'
ORDER BY SO.SURVEY_OPT;
;

-- 특정 복용한 사람 USER_ID가 선택한 보조제를 나오게 하는 쿼리문 (하나의 문자열로)
SELECT GROUP_CONCAT(SO.SURVEY_OPT) AS SUPP_LIST
FROM SURVEYRESULT AS SR
INNER JOIN SURVEY AS S
ON SR.SURVEY_UID = S.SURVEY_UID
INNER JOIN SURVEY_OPT AS SO
ON S.SURVEY_OPT_ID = SO.SURVEY_OPT_ID
WHERE S.SURVEY_QUESTION_ID = 'Q-06' AND SR.USER_ID = 'kimeh456'
ORDER BY SO.SURVEY_OPT;
;

-- 설문 통계 (다이어트 보조제별 count) -pie chart 
SELECT COUNT(SO.SURVEY_OPT) AS SURVEY_OPT_COUNT , SO.SURVEY_OPT
FROM SURVEYRESULT AS SR
INNER JOIN SURVEY AS S
ON SR.SURVEY_UID = S.SURVEY_UID
INNER JOIN SURVEY_OPT AS SO
ON S.SURVEY_OPT_ID = SO.SURVEY_OPT_ID
WHERE S.SURVEY_QUESTION_ID = 'Q-06'
GROUP BY SO.SURVEY_OPT
;

-- 설문 통계 (보조제 복용 원인 count) -pie chart 
SELECT COUNT(SO.SURVEY_OPT) AS SURVEY_OPT_COUNT , SO.SURVEY_OPT
FROM SURVEYRESULT AS SR
INNER JOIN SURVEY AS S
ON SR.SURVEY_UID = S.SURVEY_UID
INNER JOIN SURVEY_OPT AS SO
ON S.SURVEY_OPT_ID = SO.SURVEY_OPT_ID
WHERE S.SURVEY_QUESTION_ID = 'Q-09'
GROUP BY SO.SURVEY_OPT
;