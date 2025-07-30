create or replace PROCEDURE create_item_to_inventory
IS
    -- 부품 커서
    CURSOR cur_parts IS
        SELECT parts_no, parts_name FROM parts;  -- 필요한 컬럼만 적기
    v_parts_no   parts.parts_no%TYPE;
    v_parts_name parts.parts_name%TYPE;
    -- 제품 커서
    CURSOR cur_product IS
        SELECT product_no, product_name FROM product;  -- 필요한 컬럼만 적기
    v_product_no   product.product_no%TYPE;
    v_product_name product.product_name%TYPE;
BEGIN
    -- 부품 등록
    FOR part_rec IN cur_parts LOOP
        DBMS_OUTPUT.PUT_LINE('부품번호: ' || part_rec.parts_no || ', 부품명: ' || part_rec.parts_name);
        -- month_inventory 테이블에 존재하는지 확인
        DECLARE -- 변수 선언
            v_exists NUMBER := 0;
        BEGIN
            SELECT COUNT(*)
            INTO v_exists
            FROM month_inventory
            WHERE YEARMONTH = TO_CHAR(SYSDATE, 'YYMM')
            AND item_no = part_rec.parts_no
            AND ITEM_STATUS = 0;

            IF v_exists > 0 THEN
                DBMS_OUTPUT.PUT_LINE('존재');
            ELSE
                DBMS_OUTPUT.PUT_LINE('미존재');
                -- INSERT
                INSERT INTO month_inventory(YEARMONTH, STARTEND_STATUS, ITEM_STATUS, ITEM_NO, CNT, IN_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMM'), 0, 0, part_rec.parts_no, 0, sysdate);
            END IF;
        END;
    END LOOP;

    -- 제품 등록
    FOR product_rec IN cur_product LOOP
        DBMS_OUTPUT.PUT_LINE('제품번호: ' || product_rec.product_no || ', 제품명: ' || product_rec.product_name);
        -- month_inventory 테이블에 존재하는지 확인
        DECLARE -- 변수 선언
            v_exists NUMBER := 0;
        BEGIN
            SELECT COUNT(*)
            INTO v_exists
            FROM month_inventory
            WHERE YEARMONTH = TO_CHAR(SYSDATE, 'YYMM')
            AND item_no = product_rec.product_no
            AND ITEM_STATUS = 1;

            IF v_exists > 0 THEN
                DBMS_OUTPUT.PUT_LINE('존재');
            ELSE
                DBMS_OUTPUT.PUT_LINE('미존재');
                -- INSERT
                INSERT INTO month_inventory(YEARMONTH, STARTEND_STATUS, ITEM_STATUS, ITEM_NO, CNT, IN_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMM'), 0, 1, product_rec.product_no, 0, sysdate);
            END IF;
        END;
    END LOOP;
    COMMIT;
END;