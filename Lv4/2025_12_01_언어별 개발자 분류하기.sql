WITH PYTHON AS (
    SELECT  D.ID
      FROM  DEVELOPERS AS D
     WHERE  EXISTS (SELECT  1
                      FROM  SKILLCODES AS S
                     WHERE  S.NAME = 'PYTHON'
                       AND  D.SKILL_CODE & S.CODE > 0)
),
A_GRADE AS (    
    SELECT  D.ID
      FROM  DEVELOPERS AS D
     WHERE  EXISTS (SELECT  1
                      FROM  SKILLCODES AS S
                     WHERE  D.ID IN (SELECT ID FROM PYTHON)
                       AND  S.CATEGORY = 'FRONT END'
                       AND  D.SKILL_CODE & S.CODE > 0)
),
B_GRADE AS (
    SELECT  D.ID
      FROM  DEVELOPERS AS D
     WHERE  EXISTS (SELECT  1
                      FROM  SKILLCODES AS S
                     WHERE  S.NAME = 'C#'
                       AND  D.SKILL_CODE & S.CODE > 0)
),
C_GRADE AS (
    SELECT  D.ID
      FROM  DEVELOPERS AS D
     WHERE  EXISTS (SELECT  1
                      FROM  SKILLCODES AS S
                     WHERE  S.CATEGORY = 'FRONT END'
                       AND  D.SKILL_CODE & S.CODE > 0)
),
GRADED AS (
    SELECT  CASE
                WHEN ID IN (SELECT ID FROM A_GRADE) THEN 'A'
                WHEN ID IN (SELECT ID FROM B_GRADE) THEN 'B'
                WHEN ID IN (SELECT ID FROM C_GRADE)THEN 'C'
            END AS GRADE
            ,ID
            ,EMAIL
      FROM  DEVELOPERS
)
SELECT  *
  FROM  GRADED
 WHERE  GRADE IS NOT NULL
 ORDER
    BY  GRADE ASC
        ,ID ASC;