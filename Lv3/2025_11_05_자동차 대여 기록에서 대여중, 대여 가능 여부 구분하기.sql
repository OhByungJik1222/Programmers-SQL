# WITH 절 사용
WITH IS_AVAIL AS (
    SELECT  CAR_ID
            ,CASE
                WHEN START_DATE <= '2022-10-16' AND END_DATE >= '2022-10-16' THEN 0
                ELSE 1
            END AS AVAIL
      FROM  CAR_RENTAL_COMPANY_RENTAL_HISTORY
)
SELECT  CAR_ID
        ,CASE
            WHEN MIN(AVAIL) = 0 THEN '대여중'
            WHEN MIN(AVAIL) = 1 THEN '대여 가능'
         END AS AVAILABILITY
  FROM  IS_AVAIL
 GROUP
    BY  CAR_ID
 ORDER
    BY  CAR_ID DESC;
    
# WITH 절 사용 x
SELECT  CAR_ID
        ,CASE
            WHEN SUM(CASE 
                         WHEN START_DATE <= '2022-10-16' 
                          AND END_DATE >= '2022-10-16' THEN 1 
                         ELSE 0 
                      END) > 0 THEN '대여중'
            ELSE '대여 가능'
          END AS AVAILABILITY
  FROM  CAR_RENTAL_COMPANY_RENTAL_HISTORY
 GROUP 
    BY CAR_ID
 ORDER 
    BY CAR_ID DESC;
