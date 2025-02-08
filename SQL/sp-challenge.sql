-- 挑戰題

-- 請在一次查詢中，計算用戶王小明的剩餘可用堂數，顯示須包含以下欄位：user_id, remaining_credit

SELECT
    "CREDIT_PURCHASE".user_id,
    SUM("CREDIT_PURCHASE".purchased_credits) - count(DISTINCT("COURSE_BOOKING".id)) AS remaining_credit
FROM
    "CREDIT_PURCHASE"
    INNER JOIN "COURSE_BOOKING" ON "CREDIT_PURCHASE".user_id = "COURSE_BOOKING".user_id
WHERE
    "CREDIT_PURCHASE".user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
    AND
    "COURSE_BOOKING".status != '課程已取消'
GROUP BY
    "CREDIT_PURCHASE".user_id;

-- 1. 主要資料表及欄位

"CREDIT_PURCHASE"

id, user_id, credit_package_id, purchased_credits, price_paid, created_at, purchase_at

-- 兩筆王小明、一筆好野人

"COURSE_BOOKING"

id, user_id, course_id, booking_at, status, join_at, leave_at, cancelled_at, cancellation_reason, created_at

-- 兩筆王小明、一筆好野人

-- 2. 步驟拆解

SELECT * FROM "CREDIT_PURCHASE" INNER JOIN INNER JOIN "COURSE_BOOKING" ON "CREDIT_PURCHASE".user_id = "COURSE_BOOKING".user_id;

-- 預期呈現在表格上的資料共有五筆（ 王小明四筆、好野人一筆 ）

-- 首先，主資料表為 "CREDIT_PURCHASE"、要加進去的資料表是 "COURSE_BOOKING"

-- 而加入的條件為 "CREDIT_PURCHASE".user_id = "COURSE_BOOKING".user_id
-- 也就是說只要 id 一致就可以合併

-- 在 "COURSE_BOOKING" 裡面，和王小明的 ID 一致、又符合這個條件的有兩筆

-- 所以主資料表 "CREDIT_PURCHASE" 中每一筆王小明的資料，都會各自被加上 "COURSE_BOOKING" 那兩筆
-- 導致呈現的資料共五筆

WHERE

"CREDIT_PURCHASE".user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')

-- 補上第一個條件，我們不要好野人 ( 剩 4 筆 )

AND "COURSE_BOOKING".status != '課程已取消'

-- 補上第二個條件，我們只要預約成功的紀錄 ( 剩 2 筆 )

SELECT count(DISTINCT("COURSE_BOOKING".id))

-- 但這兩筆實際上在 "COURSE_BOOKING" 是屬於同一筆
-- 因為 "COURSE_BOOKING".id 是一樣的

-- 只是因為 "CREDIT_PURCHASE" 有兩筆王小明的資料 ( 一次是買 14 堂組合、一次是買 21 堂盤子組合 )
-- 又都符合 "CREDIT_PURCHASE".user_id = "COURSE_BOOKING".user_id 這個條件
-- 才會各自合併 "COURSE_BOOKING" 剩下的那一筆（ 王小明、有預約成功的那一筆 ）

--

-- 2025.02.08 --

-- 參考助教給予的提示，採用事先篩選資料表的欄位之後再合併的做法：

-- 首先，在 "CREDIT_PURCHASE" 裡，我們需要的資訊只有 user_id ( 合併資料表用 ) 及 purchased_credits

-- 也就是 5-6

SELECT
    user_id,
    SUM(purchased_credits) AS total_credit
FROM
    "CREDIT_PURCHASE"
WHERE
    user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
GROUP BY
    user_id

-- 接著，在 "COURSE_BOOKING" 裡，我們需要的資訊只有 user_id ( 合併資料表用 ) 及王小明實際參與上課的次數

-- 也就是 5-7

SELECT
    user_id,
    count(*) as used_credit
FROM
    "COURSE_BOOKING"
WHERE
    user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
    AND
    cancelled_at IS NULL
GROUP BY
    user_id

-- 接下來只要合併資料表就可以了！

-- 不同的是，我們要合併的資料表都是已經被篩選完畢的、不含其他多餘資訊的 ”乾淨“ 資料表！

SELECT

    "CREDIT_PURCHASE".user_id,

    -- 合併完成的資料表裡會有兩筆 user_id 擇一即可

    "CREDIT_PURCHASE".total_credit - "COURSE_BOOKING".used_credit AS remaining_credit

FROM
    (
    SELECT
        user_id, SUM(purchased_credits) AS total_credit
    FROM
        "CREDIT_PURCHASE"
    WHERE
        user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
    GROUP BY
        user_id
    )
    AS "CREDIT_PURCHASE"
    INNER JOIN (
    SELECT
        user_id, count(*) AS used_credit
    FROM
        "COURSE_BOOKING"
    WHERE
        user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
        AND
        cancelled_at IS NULL
    GROUP BY
        user_id
    )
    AS "COURSE_BOOKING" ON "COURSE_BOOKING".user_id = "CREDIT_PURCHASE".user_id;