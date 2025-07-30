create or replace PROCEDURE create_item_to_inventory
IS
    -- ��ǰ Ŀ��
    CURSOR cur_parts IS
        SELECT parts_no, parts_name FROM parts;  -- �ʿ��� �÷��� ����
    v_parts_no   parts.parts_no%TYPE;
    v_parts_name parts.parts_name%TYPE;
    -- ��ǰ Ŀ��
    CURSOR cur_product IS
        SELECT product_no, product_name FROM product;  -- �ʿ��� �÷��� ����
    v_product_no   product.product_no%TYPE;
    v_product_name product.product_name%TYPE;
BEGIN
    -- ��ǰ ���
    FOR part_rec IN cur_parts LOOP
        DBMS_OUTPUT.PUT_LINE('��ǰ��ȣ: ' || part_rec.parts_no || ', ��ǰ��: ' || part_rec.parts_name);
        -- month_inventory ���̺� �����ϴ��� Ȯ��
        DECLARE -- ���� ����
            v_exists NUMBER := 0;
        BEGIN
            SELECT COUNT(*)
            INTO v_exists
            FROM month_inventory
            WHERE YEARMONTH = TO_CHAR(SYSDATE, 'YYMM')
            AND item_no = part_rec.parts_no
            AND ITEM_STATUS = 0;

            IF v_exists > 0 THEN
                DBMS_OUTPUT.PUT_LINE('����');
            ELSE
                DBMS_OUTPUT.PUT_LINE('������');
                -- INSERT
                INSERT INTO month_inventory(YEARMONTH, STARTEND_STATUS, ITEM_STATUS, ITEM_NO, CNT, IN_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMM'), 0, 0, part_rec.parts_no, 0, sysdate);
            END IF;
        END;
    END LOOP;

    -- ��ǰ ���
    FOR product_rec IN cur_product LOOP
        DBMS_OUTPUT.PUT_LINE('��ǰ��ȣ: ' || product_rec.product_no || ', ��ǰ��: ' || product_rec.product_name);
        -- month_inventory ���̺� �����ϴ��� Ȯ��
        DECLARE -- ���� ����
            v_exists NUMBER := 0;
        BEGIN
            SELECT COUNT(*)
            INTO v_exists
            FROM month_inventory
            WHERE YEARMONTH = TO_CHAR(SYSDATE, 'YYMM')
            AND item_no = product_rec.product_no
            AND ITEM_STATUS = 1;

            IF v_exists > 0 THEN
                DBMS_OUTPUT.PUT_LINE('����');
            ELSE
                DBMS_OUTPUT.PUT_LINE('������');
                -- INSERT
                INSERT INTO month_inventory(YEARMONTH, STARTEND_STATUS, ITEM_STATUS, ITEM_NO, CNT, IN_DATE) VALUES (TO_CHAR(SYSDATE, 'YYMM'), 0, 1, product_rec.product_no, 0, sysdate);
            END IF;
        END;
    END LOOP;
    COMMIT;
END;