SELECT  SUM(B.SCORE) AS `SCORE`
        ,B.EMP_NO AS EMP_NO
        ,A.EMP_NAME AS EMP_NAME
        ,A.POSITION AS POSITION
        ,A.EMAIL AS EMAIL
  FROM  HR_EMPLOYEES AS A
  LEFT
  JOIN  HR_GRADE AS B
    ON  A.EMP_NO = B.EMP_NO
 WHERE  B.YEAR = 2022
 GROUP
    BY  B.EMP_NO
HAVING  `SCORE` = (SELECT  MAX(SUB2.SCORE_SUM) AS `SCORE_MAX`
                     FROM  (SELECT  SUM(SUB1.SCORE) AS `SCORE_SUM`
                                    ,SUB1.EMP_NO
                              FROM  HR_GRADE AS SUB1
                             WHERE  SUB1.YEAR = 2022
                             GROUP
                                BY  SUB1.EMP_NO) AS SUB2);