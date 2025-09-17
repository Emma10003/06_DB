/*
SELECT 문 해석 순서

5: SELECT 컬럼명 AS 별칭, 계산식, 함수식
1: FROM   참조할 테이블명
2: WHERE  컬럼명 | 함수식 비교연산자 비교값
3: GROUP BY 그룹을 묶을 컬럼명
4: HAVING 그룹함수식 비교연산자 비교값
6: ORDER BY 컬럼명 | 별칭 | 컬럼순번 정렬방식[NULLS FIRST (ASC) | LAST (DSEC)];

FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY

*/