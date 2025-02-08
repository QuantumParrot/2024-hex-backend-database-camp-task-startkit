-- 延伸考題

-- 接續 6-3 的題目，讓資料表能夠顯示 " 所有 " 組合包方案的銷售狀況

SELECT
    "CREDIT_PACKAGE".name AS 組合包方案名稱, count("CREDIT_PURCHASE".id) AS 銷售數量
FROM
    "CREDIT_PACKAGE"
    LEFT JOIN "CREDIT_PURCHASE" ON "CREDIT_PACKAGE".id = "CREDIT_PURCHASE".credit_package_id
    AND
    "CREDIT_PURCHASE".purchase_at >= '2024-11-01 00:00:00'
    AND
    "CREDIT_PURCHASE".purchase_at <= '2024-11-30 23:59:59'
GROUP BY
    "CREDIT_PACKAGE".name;

-- 知識點一：

-- 用 LEFT JOIN 來保留所有的主資料表 ( 在這裡是指 "CREDIT_PACKAGE" ) 的欄位

-- 知識點二：

-- 若是使用 WHERE 來篩選日期區間，無人購買的組合包方案就會在資料庫合併之後又被篩選掉，導致無法完整顯示所有組合包方案

-- 因此改成在合併 ( LEFT JOIN ) 的當下就先行篩選

-- 如此一來，既能排除不屬於指定日期區間的資料，也不會影響主資料表的欄位顯示與否

-- 知識點三：

-- 在經由 GROUP BY 分組後的資料表裡

-- count(*) 所代表的意思是：計算每一個分組內的 " 總行數 "

-- 即便 '7 堂組合包方案' 無人購買，實際上為 NULL 值，但它仍舊佔據了資料表中的一行

-- 因此會得到 "1"

-- 而這與我們預期的 " 銷售數量為 0 " 統計結果不符

-- 所以我們必須調整帶入 count 的參數

-- 讓 count 轉而計算每一個分組內的 "CREDIT_PURCHASE".id 數量，

-- 此時由於無人購買的 '7 堂組合包方案' 為 NULL 值，銷售數量就會顯示為 " 0 "
