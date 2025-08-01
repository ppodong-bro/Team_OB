DROP FUNCTION calc_real_inventory;
DROP TYPE table_calc_real_inventory;
DROP TYPE type_calc_real_inventory;
/
-- ��ü Ÿ�� ���� (�� �� ����)
CREATE OR REPLACE TYPE type_calc_real_inventory AS OBJECT (
    item_no NUMBER,
    item_status VARCHAR2(255),
    item_name VARCHAR2(255),
    cnt NUMBER
    -- proper_cnt:��������
    -- diff_cnt:����
);
/
-- ��ü Ÿ���� ���̺� Ÿ�� ���� (���� ��)
CREATE OR REPLACE TYPE table_calc_real_inventory AS TABLE OF type_calc_real_inventory;
/
-- ��ǰ/��ǰ ��ü ��ȸ
CREATE OR REPLACE FUNCTION calc_real_inventory(p_itemStatus IN NUMBER)
RETURN table_calc_real_inventory PIPELINED -- PIPELINED : �� �྿ ���������� ��ȯ�� �� �ְ� ���ִ� �Լ��� ����
IS
    -- ��������
    v_sql VARCHAR2(10000); -- ���� SQL
    v_cur SYS_REFCURSOR; -- Ŀ��
    -- �Ӽ�����
    v_item_no NUMBER; -- ����ȣ
    v_item_status VARCHAR2(255); -- ���з�
    v_name VARCHAR2(255); -- ����
    v_cnt NUMBER; -- ����
    -- proper_cnt:��������
    -- diff_cnt:����

BEGIN
    -- ��ǰ ��ȸ
    IF p_itemStatus = 0 THEN
        v_sql := '
        SELECT mi.item_no, c.context, p.parts_name, mi.cnt FROM month_inventory mi
        JOIN parts p ON mi.item_no = p.parts_no -- ��ǰ ������ �������� ���� ����
        JOIN common c ON p.parts_status = c.middle_status AND big_status = 900 -- ��ǰ �з� �������� ���� ����
        WHERE yearmonth = (
            SELECT MAX(yearmonth) FROM month_inventory
            )
        AND startend_status = 1 -- �⸻���
        AND item_status = :1 -- ��ǰ/��ǰ
        ';
    ELSIF p_itemStatus = 1 THEN
        v_sql := '
        SELECT mi.item_no, c.context, p.product_name, mi.cnt FROM month_inventory mi
        JOIN product p ON mi.item_no = p.product_no -- ��ǰ ������ �������� ���� ����
        JOIN common c ON p.product_status = c.middle_status AND big_status = 800 -- ��ǰ �з� �������� ���� ����
        WHERE yearmonth = (
            SELECT MAX(yearmonth) FROM month_inventory
            )
        AND startend_status = 1 -- �⸻���
        AND item_status = :1 -- ��ǰ/��ǰ
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
        -- ������ ���� ó�� ����
        NULL; 
END;
/
SELECT * FROM TABLE(calc_real_inventory(0));