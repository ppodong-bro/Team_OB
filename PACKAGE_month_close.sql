-- ������ ��Ű��
CREATE OR REPLACE PACKAGE month_close AS
    g_in_empno emp.emp_no%TYPE := '1001';
    g_prod_cnt NUMBER(9) := 0;
    
    -- ������0 : ����
    PROCEDURE month_close_main(p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2);
    
    -- ������0 : ���Ҹ��� ���� �̷� ���
    PROCEDURE month_close_start (p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2);
    -- ������1 : �̹��� ���� ��� ���
    PROCEDURE month_close_prc1 (p_sum_yymm in VARCHAR2);
    -- ������2 : �̹��� ����/����/���/���� �ݿ�
    PROCEDURE month_close_prc2 (p_sum_yymm in VARCHAR2);
    -- ������7 : �ŷ�ó ���� ���
    -- ������8 : ��ǰ ���� ���
    -- ������9 : ��ǰ ���� ���
    -- ������998 : ������ �⸻ ��� ���
    -- ������999 : ���Ҹ��� �� �̷� ���
END;
-- PACKAGE�� PACKAGE BODY ����
/
CREATE OR REPLACE PACKAGE BODY month_close AS
    PROCEDURE month_close_main(p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2) 
    IS
    BEGIN
        dbms_output.put_line('������ ���� p_sum_yymm =>' || p_sum_yymm );
        dbms_output.put_line('������ ���� p_regi_emp_no =>' || p_regi_emp_no );
        
        -- ������0 : ���Ҹ��� ���� �̷� ���
        month_close_start(p_sum_yymm, p_regi_emp_no);
        -- ������1 : �̹��� ���� ��� ���
        month_close_prc1(p_sum_yymm);
        -- ������2 : �̹��� ����/����/���/���� �ݿ�
        month_close_prc2(p_sum_yymm);
        -- ������7 : �ŷ�ó ���� ���
        -- ������8 : ��ǰ ���� ���
        -- ������9 : ��ǰ ���� ���
        -- ������998 : ������ �⸻ ��� ���
        -- ������999 : ���Ҹ��� �� �̷� ���
        COMMIT;
    END;
    
    /***************************************************************************
    Procedure Name : month_close_start
    Description    : ���Ҹ��� ���� �̷� ���
    ***************************************************************************/
    PROCEDURE month_close_start(p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2)
    IS
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_start START p_sum_yymm/p_regi_emp_no ' || p_sum_yymm || '/' || p_regi_emp_no);
        
        dbms_output.put_line('��������� ������ ����');
        -- ���Ҹ����� �̹��� ����
        DELETE FROM inventory_close WHERE yearmonth = p_sum_yymm;
        -- ������� �⸻��� ����
        DELETE FROM month_inventory WHERE yearmonth = p_sum_yymm;
        
        -- ���Ҹ��� ���� �̷� ���
        INSERT INTO inventory_close(YEARMONTH, CLOSE_STATUS, CLOSE_STARTDATE, CLOSE_ENDDATE, EMP_NO) VALUES (p_sum_yymm, 0, sysdate, null, p_regi_emp_no);
        
        dbms_output.put_line('month_close_start END');
    END;
    
    /***************************************************************************
    Procedure Name : month_close_prc1
    Description    : �̹��� ���� ��� ���
    ***************************************************************************/
    PROCEDURE month_close_prc1(p_sum_yymm in VARCHAR2)
    IS
        v_count NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_prc1 START p_sum_yymm ' || p_sum_yymm);
        
        dbms_output.put_line('������ �⸻��� �����Ͽ� �̹��� ������� ���');
        -- ������ �⸻��� Ȯ��
        SELECT COUNT(*)
        INTO v_count
        FROM month_inventory
        WHERE YEARMONTH = TO_CHAR(ADD_MONTHS(TO_DATE(p_sum_yymm, 'YYMM'), -1), 'YYMM')
        AND ITEM_STATUS = '1';
        -- ������ �⸻��� �����Ͽ� �̹��� ������� ���
        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('�������');
            INSERT INTO month_inventory
            (YEARMONTH,
            STARTEND_STATUS,
            ITEM_STATUS,
            ITEM_NO,
            CNT,
            IN_DATE)
                (SELECT p_sum_yymm
                    ,'0' -- ����
                    ,ITEM_STATUS
                    ,ITEM_NO
                    ,CNT
                    ,SYSDATE
                FROM     month_inventory   
                WHERE    YEARMONTH  = TO_CHAR(ADD_MONTHS (TO_DATE(p_sum_yymm,'YYMM'),-1),'YYMM')
                AND      ITEM_STATUS = '1' -- �⸻
            );
            DBMS_OUTPUT.PUT_LINE('���糡');
        -- ������ �⸻��� ����
        ELSE
            DBMS_OUTPUT.PUT_LINE('������ �⸻ ��� �������� �ʽ��ϴ�.');
        END IF;
        
        dbms_output.put_line('�ű� ��� ���');
        create_item_to_inventory;
        
        dbms_output.put_line('month_close_prc1 END');
    END;
    
    /***************************************************************************
    Procedure Name : month_close_prc2
    Description    : �̹��� ����/����/���/���� �ݿ�
    ***************************************************************************/
    PROCEDURE month_close_prc2(p_sum_yymm in VARCHAR2)
    IS
        -- ���, ��ǰ/��ǰ ����, ��ȣ, �����, �԰�, ���, ����, ��� ��ȸ
        CURSOR cur_close_clac IS
        SELECT M.yearmonth,M.item_status,M.item_no, SUM(M.cnt) AS inventory_cnt, NVL(AVG(P.purchase_item_cnt),0) AS purchase_cnt, NVL(AVG(S.sales_item_cnt),0) AS sales_cnt
        FROM (SELECT yearmonth, item_status, item_no, cnt FROM month_inventory 
            WHERE    yearmonth = p_sum_yymm
            AND      startend_status = '0' -- ���� ��� ����
            ) M -- �����
            LEFT JOIN
            -- ��ǰ
            (SELECT 0 AS item_status, PARTS_NO, PURCHASE_ITEM_CNT FROM purchase_item 
            WHERE purchase_no IN (
                SELECT purchase_no FROM purchase_order 
                WHERE TO_CHAR(purchase_date, 'YYMM') = p_sum_yymm
                AND in_status IN (2,3) -- �Ϸ�, ����
                )
            ) P -- ���� ����
            ON M.item_status = P.item_status
            AND M.item_no = P.parts_no
            LEFT JOIN
            -- ��ǰ -> ��ǰ �ڵ� ��ȯ
            (SELECT 0 AS item_status, PB.parts_no, SUM(PB.cnt * SS.sales_item_cnt) AS sales_item_cnt
            FROM product_bom PB
            JOIN (
                SELECT product_no, sales_item_cnt FROM sales_item WHERE sales_no IN (
                SELECT sales_no FROM sales_order 
                WHERE TO_CHAR(sales_date, 'YYMM') = p_sum_yymm
                AND out_status IN (2,3) -- �Ϸ�, ����
                )) SS
            ON PB.product_no = SS.product_no
            GROUP BY PB.parts_no) S -- �ǸŽ���
            ON M.item_status = S.item_status
            AND M.item_no = S.parts_no
        GROUP BY M.yearmonth,M.item_status,M.item_no;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_prc2 START p_sum_yymm ' || p_sum_yymm);
        
        -- �̹��� ����, ����, (���), (����) �ݿ� �ϱ�
        FOR rec_close_clac IN cur_close_clac LOOP
            ------------------------------------------------------------------
            --    ���� â�� ������� �Ǹŷ����� ũ�ٸ� �⸻��� �Է� 
            ------------------------------------------------------------------
            IF rec_close_clac.inventory_cnt + rec_close_clac.purchase_cnt >= rec_close_clac.sales_cnt THEN  
                INSERT INTO month_inventory       
                    (yearmonth
                    ,startend_status
                    ,item_status
                    ,item_no
                    ,cnt
                    ,in_date
                )
                VALUES(p_sum_yymm
                    , 1 -- �⸻���
                    , rec_close_clac.item_status
                    , rec_close_clac.item_no
                    , rec_close_clac.inventory_cnt + rec_close_clac.purchase_cnt - rec_close_clac.sales_cnt
                    , SYSDATE
                );
            ELSE
                --���� ���
                g_prod_cnt := rec_close_clac.inventory_cnt + rec_close_clac.purchase_cnt - rec_close_clac.sales_cnt;
                dbms_output.put_line(rec_close_clac.yearmonth || '����� ' || rec_close_clac.item_status || ':' || rec_close_clac.item_no || '��ȣ ' ||  g_prod_cnt || '���� ����');
            END IF;
        END LOOP;
        
        dbms_output.put_line('month_close_prc2 END');
        EXCEPTION
            WHEN OTHERS THEN
                  DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
    END;
END;
