DROP FUNCTION calc_real_inventory;
DROP TYPE table_calc_real_inventory;
DROP TYPE type_calc_real_inventory;
/
-- 객체 타입 정의 (한 행 구조)
CREATE OR REPLACE TYPE type_calc_real_inventory AS OBJECT (
    item_no NUMBER,
    item_status VARCHAR2(255),
    item_name VARCHAR2(255),
    cnt NUMBER
    -- proper_cnt:적정수량
    -- diff_cnt:편차
);
/
-- 객체 타입의 테이블 타입 정의 (여러 행)
CREATE OR REPLACE TYPE table_calc_real_inventory AS TABLE OF type_calc_real_inventory;
/
-- 부품/제품 전체 조회
CREATE OR REPLACE FUNCTION calc_real_inventory(p_itemStatus IN NUMBER)
RETURN table_calc_real_inventory PIPELINED -- PIPELINED : 한 행씩 순차적으로 반환할 수 있게 해주는 함수로 지정
IS
    -- 변수선언
    v_sql VARCHAR2(10000); -- 동적 SQL
    v_cur SYS_REFCURSOR; -- 커서
    -- 속성변수
    v_item_no NUMBER; -- 재고번호
    v_item_status VARCHAR2(255); -- 재고분류
    v_name VARCHAR2(255); -- 재고명
    v_cnt NUMBER; -- 수량
    -- proper_cnt:적정수량
    -- diff_cnt:편차

BEGIN
    -- 부품 조회
    IF p_itemStatus = 0 THEN
        v_sql := '
        SELECT mi.item_no, c.context, p.parts_name, mi.cnt FROM month_inventory mi
        JOIN parts p ON mi.item_no = p.parts_no -- 부품 정보를 가져오기 위한 조인
        JOIN common c ON p.parts_status = c.middle_status AND big_status = 900 -- 부품 분류 가져오기 위한 조인
        WHERE yearmonth = (
            SELECT MAX(yearmonth) FROM month_inventory
            )
        AND startend_status = 1 -- 기말재고
        AND item_status = :1 -- 부품/제품
        ';
    ELSIF p_itemStatus = 1 THEN
        v_sql := '
        SELECT mi.item_no, c.context, p.product_name, mi.cnt FROM month_inventory mi
        JOIN product p ON mi.item_no = p.product_no -- 제품 정보를 가져오기 위한 조인
        JOIN common c ON p.product_status = c.middle_status AND big_status = 800 -- 제품 분류 가져오기 위한 조인
        WHERE yearmonth = (
            SELECT MAX(yearmonth) FROM month_inventory
            )
        AND startend_status = 1 -- 기말재고
        AND item_status = :1 -- 부품/제품
        ';
    ELSE 
        RETURN;
    END IF;
    
    OPEN v_cur FOR v_sql USING p_itemStatus;
    
    LOOP
        FETCH v_cur INTO v_item_no, v_item_status, v_name, v_cnt;
        EXIT WHEN v_cur%NOTFOUND;
        PIPE ROW(type_calc_real_inventory(v_item_no, v_item_status, v_name, v_cnt));
    END LOOP;
    
    CLOSE v_cur;
    RETURN;
    
EXCEPTION
    WHEN OTHERS THEN
        -- 간단한 예외 처리 예시
        NULL; 
END;
/
SELECT * FROM TABLE(calc_real_inventory(0));