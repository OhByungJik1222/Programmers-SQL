WITH CAN_RENT AS (
    SELECT  CAR_ID
            ,CASE
                WHEN SUM(CASE
                            WHEN START_DATE > '2022-11-30'
                              OR END_DATE < '2022-11-01' THEN 0
                            ELSE 1
                          END) >= 1 THEN 'F'
                ELSE 'T'
              END AS CAN
      FROM  CAR_RENTAL_COMPANY_RENTAL_HISTORY
     GROUP
        BY  CAR_ID
),
CAN_RENT_CAR AS (
    SELECT  A.CAR_ID
            ,A.CAR_TYPE
            ,A.DAILY_FEE
      FROM  CAR_RENTAL_COMPANY_CAR AS A
      LEFT
      JOIN  CAN_RENT AS B
        ON  A.CAR_ID = B.CAR_ID
     WHERE  A.CAR_TYPE IN ('세단', 'SUV')
       AND  B.CAN = 'T'
),
ONLY_30 AS (
    SELECT  CAR_TYPE
            ,DISCOUNT_RATE
      FROM  CAR_RENTAL_COMPANY_DISCOUNT_PLAN
     WHERE  LEFT(DURATION_TYPE, 2) = '30'
)
SELECT  A.CAR_ID
        ,A.CAR_TYPE
        ,ROUND(A.DAILY_FEE * (100 - B.DISCOUNT_RATE) / 100 * 30, 0) AS FEE
  FROM  CAN_RENT_CAR AS A
  LEFT
  JOIN  ONLY_30 AS B
    ON  A.CAR_TYPE = B.CAR_TYPE
 WHERE  ROUND(((A.DAILY_FEE * (100 - B.DISCOUNT_RATE) / 100) * 30) / 100000, 0) BETWEEN 5 AND 20
 ORDER
    BY  FEE DESC
        ,CAR_TYPE ASC
        ,CAR_ID DESC;