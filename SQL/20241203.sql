-- ===================== ====================
-- ████████  █████   █     █ 
--   █ █   ██    █  █     ██ 
--   █ █████ ███ ███       █ 
--   █ █   █    ██  █      █ 
--   █ █   █████ █   █     █ 
-- ===================== ====================

INSERT INTO
    "USER" (name, email, role)
VALUES
    (
        '李燕容',
        'lee2000@hexschooltest.io',
        'USER'
    ),
    (
        '王小明',
        'wXlTq@hexschooltest.io',
        'USER'
    ),
    (
        '肌肉棒子',
        'muscle@hexschooltest.io',
        'USER'
    ),
    (
        '好野人',
        'richman@hexschooltest.io',
        'USER'
    ),
    (
        'Ｑ太郎',
        'starplatinum@hexschooltest.io',
        'USER'
    ),
    (
        '透明人',
        'opacity0@hexschooltest.io',
        'USER'
    );

-- 驗證

-- SELECT * FROM "USER";

UPDATE
    "USER"
SET
    role = 'COACH'
WHERE
    email
    IN ('lee2000@hexschooltest.io', 'muscle@hexschooltest.io', 'starplatinum@hexschooltest.io');

-- 驗證

-- SELECT * FROM "USER";

--

DELETE FROM "USER" WHERE email = 'opacity0@hexschooltest.io';

-- 驗證

-- SELECT name FROM "USER";

--

SELECT count(*) AS 用戶數量 FROM "USER";

--

SELECT * FROM "USER" LIMIT 3;

-- ===================== ====================
--  ████████  █████   █    ████  
--    █ █   ██    █  █         █ 
--    █ █████ ███ ███       ███  
--    █ █   █    ██  █     █     
--    █ █   █████ █   █    █████ 
-- ===================== ====================

INSERT INTO
    "CREDIT_PACKAGE" (name, price, credit_amount)
VALUES
    ('7 堂組合包方案', 1400, 7), ('14 堂組合包方案', 2520, 14), ('21 堂組合包方案', 4800, 21);

-- 驗證

-- SELECT * FROM "CREDIT_PACKAGE";

--

INSERT INTO
    "CREDIT_PURCHASE" (user_id, credit_package_id, purchased_credits, price_paid)
VALUES
    (
        (SELECT id FROM "USER" WHERE name = '王小明'),
        (SELECT id FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案'),
        (SELECT credit_amount FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案'),
        (SELECT price FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案')
    ),
    (
        (SELECT id FROM "USER" WHERE name = '王小明'),
        (SELECT id FROM "CREDIT_PACKAGE" WHERE name = '21 堂組合包方案'),
        (SELECT credit_amount FROM "CREDIT_PACKAGE" WHERE name = '21 堂組合包方案'),
        (SELECT price FROM "CREDIT_PACKAGE" WHERE name = '21 堂組合包方案')		
    ),
    (
        (SELECT id FROM "USER" WHERE name = '好野人'),
        (SELECT id FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案'),
        (SELECT credit_amount FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案'),
        (SELECT price FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案')		
    );

-- 驗證

-- SELECT
--     "USER".name as 會員姓名,
--     "CREDIT_PACKAGE".name as 課程名稱,
--     "CREDIT_PURCHASE".price_paid as 付款金額,
--     "CREDIT_PURCHASE".purchased_credits as 購買堂數
-- FROM
--     "CREDIT_PURCHASE"
--     inner join "USER" on "CREDIT_PURCHASE".user_id = "USER".id 
--     inner join "CREDIT_PACKAGE" on "CREDIT_PURCHASE".credit_package_id = "CREDIT_PACKAGE".id;

-- ===================== ====================
-- ████████  █████   █    ████   
--   █ █   ██    █  █         ██ 
--   █ █████ ███ ███       ███   
--   █ █   █    ██  █         ██ 
--   █ █   █████ █   █    ████   
-- ===================== ====================

INSERT INTO
    "COACH" (user_id, experience_years)
VALUES
    (
        (select id from "USER" where email = 'lee2000@hexschooltest.io'),
        2
    ),
    ( 
        (select id from "USER" where email = 'starplatinum@hexschooltest.io'),
        2
    ),
    (
        (select id from "USER" where email = 'muscle@hexschooltest.io'),
        2
    );

-- 驗證

-- SELECT
--     "USER".name as 教練姓名, "COACH".experience_years as 年資
-- FROM
--     "COACH"
--     INNER JOIN "USER" ON "USER".id = "COACH".user_id;

--

INSERT INTO
    "COACH_LINK_SKILL" (coach_id, skill_id)
VALUES
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '重訓')
    ),
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'starplatinum@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '重訓')
    ),
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'muscle@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '重訓')
    ),
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'muscle@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '瑜伽')
    ),
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'starplatinum@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '有氧運動')
    ), 
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'starplatinum@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '復健訓練')
    );

-- 驗證

-- SELECT
--	   "USER".name as 教練姓名, "SKILL".name as 技能名稱
-- FROM
--	   "COACH_LINK_SKILL"
--	   INNER JOIN "SKILL" ON "SKILL".id = "COACH_LINK_SKILL".skill_id 
--	   INNER JOIN "COACH" ON "COACH".id = "COACH_LINK_SKILL".coach_id INNER JOIN "USER" ON "USER".id = "COACH".user_id;

--

UPDATE
    "COACH"
SET
    experience_years = 3,
    updated_at = now()
WHERE
    user_id = (SELECT id FROM "USER" WHERE email = 'muscle@hexschooltest.io');

UPDATE
    "COACH"
SET
    experience_years = 5,
    updated_at = now()
WHERE
    user_id = (SELECT id FROM "USER" WHERE email = 'starplatinum@hexschooltest.io');

-- 驗證

-- SELECT
--     "USER".name as 教練, "COACH".experience_years as 年資
-- FROM
--     "COACH", "USER"
-- WHERE
--     "USER".id = "COACH".user_id;

--

INSERT INTO "SKILL" (name) VALUES ('空中瑜伽');

DELETE FROM "SKILL" WHERE name = '空中瑜伽';

-- 驗證

-- SELECT * FROM "SKILL";

-- ===================== ==================== 
--  ████████  █████   █    █   █ 
--    █ █   ██    █  █     █   █ 
--    █ █████ ███ ███      █████ 
--    █ █   █    ██  █         █ 
--    █ █   █████ █   █        █ 
-- ===================== ==================== 

INSERT INTO
    "COURSE" (user_id, skill_id, name, start_at, end_at, max_participants, meeting_url)
VALUES
    (
        (SELECT id
            FROM "USER"
                WHERE email = 'lee2000@hexschooltest.io'),
        (SELECT id
            FROM "SKILL"
                WHERE name = '重訓'),
        '重訓基礎課',
        '2024-11-25 14:00:00',
        '2024-11-25 16:00:00',
        10,
        'https://test-meeting.test.io'
    );

-- 驗證

-- SELECT
--     "USER".name AS 授課教練, "COURSE".name AS 課程名稱, "SKILL".name AS 目標技能,
-- 	   "COURSE".start_at AS 開始時間, "COURSE".end_at AS 結束時間,
--     "COURSE".max_participants AS 人數上限,
--     "COURSE".meeting_url AS 直播網址
-- FROM
--     "COURSE"
-- 	   INNER JOIN "USER" ON "USER".id = "COURSE".user_id INNER JOIN "SKILL" ON "SKILL".id = "COURSE".skill_id;

-- ===================== ====================
-- ████████  █████   █    █████ 
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █         █ 
--   █ █   █████ █   █    ████  
-- ===================== ====================
    
INSERT INTO
    "COURSE_BOOKING" (user_id, course_id, booking_at, status)
VALUES
    (
        (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io'),
        (SELECT id FROM "COURSE" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io')),
        '2024-11-24 16:00:00',
        '即將授課'
    ),
    (
        (SELECT id FROM "USER" WHERE email = 'richman@hexschooltest.io'),
        (SELECT id FROM "COURSE" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io')),
        '2024-11-24 16:00:00',
        '即將授課'
    );

-- 驗證

-- SELECT
--     "USER".name AS 預約會員, "COURSE".name AS 預約課程,
--     "COURSE_BOOKING".booking_at AS 預約時間,
--     "COURSE_BOOKING".status AS 狀態
-- FROM
--     "COURSE_BOOKING"
--     INNER JOIN "USER" ON "COURSE_BOOKING".user_id = "USER".id
--     INNER JOIN "COURSE" ON "COURSE_BOOKING".course_id = "COURSE".id;

--

UPDATE
    "COURSE_BOOKING"
SET
    cancelled_at  = '2024-11-24 17:00:00',
    status = '課程已取消'
WHERE
    user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
    AND
    course_id = (SELECT id FROM "COURSE" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io'));

-- 驗證

-- SELECT
--     "USER".name AS 預約會員, "COURSE".name AS 預約課程,
--     "COURSE_BOOKING".booking_at AS 預約時間, "COURSE_BOOKING".cancelled_at AS 取消時間,
--     "COURSE_BOOKING".status AS 狀態
-- FROM
--     "COURSE_BOOKING"
--     INNER JOIN "USER" ON "COURSE_BOOKING".user_id = "USER".id
--     INNER JOIN "COURSE" ON "COURSE_BOOKING".course_id = "COURSE".id;

--

INSERT INTO
    "COURSE_BOOKING" (user_id, course_id, booking_at, status)
VALUES
    (
        (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io'),
        (SELECT id FROM "COURSE" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io')),
        '2024-11-24 17:10:25',
        '即將授課'
    );

-- 驗證

-- SELECT
--     "USER".name AS 預約會員, "COURSE".name AS 預約課程,
--     "COURSE_BOOKING".booking_at AS 預約時間,
--     "COURSE_BOOKING".status AS 狀態
-- FROM
--     "COURSE_BOOKING"
--     INNER JOIN "USER" ON "COURSE_BOOKING".user_id = "USER".id
--     INNER JOIN "COURSE" ON "COURSE_BOOKING".course_id = "COURSE".id;

--

SELECT
    "USER".name AS 預約會員, "COURSE".name AS 預約課程,
    "COURSE_BOOKING".booking_at AS 預約時間,
    "COURSE_BOOKING".status AS 預約狀態,
    "COURSE_BOOKING".cancelled_at AS 取消時間
FROM
    "COURSE_BOOKING"
    INNER JOIN "USER" ON "USER".id = "COURSE_BOOKING".user_id
    INNER JOIN "COURSE" ON "COURSE".id = "COURSE_BOOKING".course_id
WHERE
    "USER".email = 'wXlTq@hexschooltest.io';

--

UPDATE
    "COURSE_BOOKING"
SET
    join_at = '2024-11-25 14:01:59',
    status = '上課中'
WHERE
    user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
    AND
    course_id = (SELECT id FROM "COURSE" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io'))
    AND
    status = '即將授課';

-- 驗證

-- SELECT
--     "USER".name AS 預約會員, "COURSE".name AS 預約課程,
--     "COURSE_BOOKING".booking_at AS 預約時間,
--     "COURSE_BOOKING".status AS 預約狀態,
--     "COURSE_BOOKING".cancelled_at AS 取消時間,
--     "COURSE_BOOKING".join_at as 加入直播時間
-- FROM
--     "COURSE_BOOKING"
--     INNER JOIN "USER" ON "USER".id = "COURSE_BOOKING".user_id
--     INNER JOIN "COURSE" ON "COURSE".id = "COURSE_BOOKING".course_id
-- WHERE
--     "USER".email = 'wXlTq@hexschooltest.io';

--

SELECT
    user_id,
    SUM(purchased_credits) AS total
FROM
    "CREDIT_PURCHASE"
WHERE
    user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
GROUP BY
    user_id;

--

SELECT
    user_id,
    count(*) AS total
FROM
    "COURSE_BOOKING"
WHERE
    user_id = (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io')
    AND
    status != '課程已取消'
GROUP BY
    user_id;

-- ===================== ====================
-- ████████  █████   █     ███  
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █     █   █ 
--   █ █   █████ █   █     ███  
-- ===================== ====================

SELECT
    "USER".name AS 教練名稱, "COACH".experience_years AS 經驗年數, "SKILL".name AS 專長名稱
FROM
    "COACH_LINK_SKILL"
    INNER JOIN "SKILL" ON "COACH_LINK_SKILL".skill_id = "SKILL".id
    INNER JOIN ("COACH" INNER JOIN "USER" ON "COACH".user_id = "USER".id) 
    ON "COACH_LINK_SKILL".coach_id = "COACH".id
WHERE
    "SKILL".name = '重訓' -- "COACH_LINK_SKILL".skill_id = ( SELECT id FROM "SKILL" WHERE name = '重訓' )
ORDER BY
    "COACH".experience_years DESC;

--

SELECT
    "SKILL".name AS 專長名稱, count(*) AS coach_total
FROM
    "SKILL"
    INNER JOIN "COACH_LINK_SKILL" ON "SKILL".id = "COACH_LINK_SKILL".skill_id
GROUP BY
    "SKILL".id
ORDER BY
    coach_total DESC
LIMIT 1;

-- 步驟拆解

SELECT * FROM "SKILL" INNER JOIN "COACH_LINK_SKILL" ON "COACH_LINK_SKILL".skill_id = "SKILL".id;

-- 合併主資料表 "SKILL" 和 "COACH_LINK_SKILL"
-- 條件為 "COACH_LINK_SKILL".skill_id = "SKILL".id

COUNT(*) AS coach_total

-- 合併的過程中，在 "COACH_LINK_SKILL" 的每一筆資料，只要和 "SKILL".id 吻合就會和該技能併在一塊

-- 如果只選擇顯示 "SKILL".name 的話
-- 就會看到三筆重訓、一筆瑜伽、一筆有氧運動、一筆復健訓練
-- 這個就是我們要的了，直接 count(*) 起來

ORDER BY coach_total DESC
LIMIT 1;

-- 由於題目提及要用到 ORDER BY + LIMIT 代表可以用這個方式選出最多教練擅長的專長

--

SELECT
    "CREDIT_PACKAGE".name AS 組合包方案名稱,
    count(*) AS 銷售數量
FROM
    "CREDIT_PACKAGE"
    INNER JOIN "CREDIT_PURCHASE" ON "CREDIT_PURCHASE".credit_package_id = "CREDIT_PACKAGE".id
WHERE
    "CREDIT_PURCHASE".purchase_at >= '2024-11-01 00:00:00'
    AND
    "CREDIT_PURCHASE".purchase_at =< '2024-11-30 23:59:59'
GROUP BY
    "CREDIT_PACKAGE".name;

--

SELECT
    SUM(price_paid) AS 總營收
FROM
    "CREDIT_PURCHASE"
WHERE
    purchase_at >= '2024-11-01 00:00:00'
    AND
    purchase_at <= '2024-11-30 23:59:59';

--

SELECT
    COUNT(DISTINCT(user_id)) AS 預約會員人數
FROM
    "COURSE_BOOKING"
WHERE
    created_at >= '2024-12-01 00:00:00' AND created_at <= '2024-12-31 23:59:59'
    AND
    status != '課程已取消';

