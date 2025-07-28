-- 월마감 패키지
CREATE OR REPLACE PACKAGE month_close AS
    g_in_empno emp.emp_no%TYPE := '1001';
    g_prod_cnt NUMBER(9) := 0;
    
    -- 월마감0 : 메인
    PROCEDURE month_close_main(p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2);
    
    -- 월마감0 : 수불마감 시작 이력 등록
    PROCEDURE month_close_start (p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2);
    -- 월마감1 : 이번달 기초 재고 등록
    PROCEDURE month_close_prc1 (p_sum_yymm in VARCHAR2);
    -- 월마감2 : 이번달 발주/생산/폐기/수주 반영
    PROCEDURE month_close_prc2 (p_sum_yymm in VARCHAR2);
    -- 월마감7 : 거래처 실적 기록
    -- 월마감8 : 제품 실적 기록
    -- 월마감9 : 부품 실적 기록
    -- 월마감998 : 다음달 기말 재고 등록
    -- 월마감999 : 수불마감 끝 이력 등록
END;
-- PACKAGE와 PACKAGE BODY 구분
/
CREATE OR REPLACE PACKAGE BODY month_close AS
    PROCEDURE month_close_main(p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2) 
    IS
    BEGIN
        dbms_output.put_line('월마감 시작 p_sum_yymm =>' || p_sum_yymm );
        dbms_output.put_line('월마감 시작 p_regi_emp_no =>' || p_regi_emp_no );
        
        -- 월마감0 : 수불마감 시작 이력 등록
        month_close_start(p_sum_yymm, p_regi_emp_no);
        -- 월마감1 : 이번달 기초 재고 등록
        month_close_prc1(p_sum_yymm);
        -- 월마감2 : 이번달 발주/생산/폐기/수주 반영
        month_close_prc2(p_sum_yymm);
        -- 월마감7 : 거래처 실적 기록
        -- 월마감8 : 제품 실적 기록
        -- 월마감9 : 부품 실적 기록
        -- 월마감998 : 다음달 기말 재고 등록
        -- 월마감999 : 수불마감 끝 이력 등록
        COMMIT;
    END;
    
    /***************************************************************************
    Procedure Name : month_close_start
    Description    : 수불마감 시작 이력 등록
    ***************************************************************************/
    PROCEDURE month_close_start(p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2)
    IS
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_start START p_sum_yymm/p_regi_emp_no ' || p_sum_yymm || '/' || p_regi_emp_no);
        
        dbms_output.put_line('덮어씌워지는 데이터 삭제');
        -- 수불마감의 이번달 삭제
        DELETE FROM inventory_close WHERE yearmonth = p_sum_yymm;
        -- 월재고의 기말재고 삭제
        DELETE FROM month_inventory WHERE yearmonth = p_sum_yymm;
        
        -- 수불마감 시작 이력 등록
        INSERT INTO inventory_close(YEARMONTH, CLOSE_STATUS, CLOSE_STARTDATE, CLOSE_ENDDATE, EMP_NO) VALUES (p_sum_yymm, 0, sysdate, null, p_regi_emp_no);
        
        dbms_output.put_line('month_close_start END');
    END;
    
    /***************************************************************************
    Procedure Name : month_close_prc1
    Description    : 이번달 기초 재고 등록
    ***************************************************************************/
    PROCEDURE month_close_prc1(p_sum_yymm in VARCHAR2)
    IS
        v_count NUMBER := 0;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_prc1 START p_sum_yymm ' || p_sum_yymm);
        
        dbms_output.put_line('지난달 기말재고 복사하여 이번달 기초재고 등록');
        -- 지난달 기말재고 확인
        SELECT COUNT(*)
        INTO v_count
        FROM month_inventory
        WHERE YEARMONTH = TO_CHAR(ADD_MONTHS(TO_DATE(p_sum_yymm, 'YYMM'), -1), 'YYMM')
        AND ITEM_STATUS = '1';
        -- 지난달 기말재고 복사하여 이번달 기초재고 등록
        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('복사시작');
            INSERT INTO month_inventory
            (YEARMONTH,
            STARTEND_STATUS,
            ITEM_STATUS,
            ITEM_NO,
            CNT,
            IN_DATE)
                (SELECT p_sum_yymm
                    ,'0' -- 기초
                    ,ITEM_STATUS
                    ,ITEM_NO
                    ,CNT
                    ,SYSDATE
                FROM     month_inventory   
                WHERE    YEARMONTH  = TO_CHAR(ADD_MONTHS (TO_DATE(p_sum_yymm,'YYMM'),-1),'YYMM')
                AND      ITEM_STATUS = '1' -- 기말
            );
            DBMS_OUTPUT.PUT_LINE('복사끝');
        -- 지난달 기말재고 없음
        ELSE
            DBMS_OUTPUT.PUT_LINE('지난달 기말 재고가 존재하지 않습니다.');
        END IF;
        
        dbms_output.put_line('신규 재고 등록');
        create_item_to_inventory;
        
        dbms_output.put_line('month_close_prc1 END');
    END;
    
    /***************************************************************************
    Procedure Name : month_close_prc2
    Description    : 이번달 발주/생산/폐기/수주 반영
    ***************************************************************************/
    PROCEDURE month_close_prc2(p_sum_yymm in VARCHAR2)
    IS
        -- 년월, 부품/제품 구분, 번호, 월재고, 입고, 출고, 생산, 폐기 조회
        CURSOR cur_close_clac IS
        SELECT M.yearmonth,M.item_status,M.item_no, SUM(M.cnt) AS inventory_cnt, NVL(AVG(P.purchase_item_cnt),0) AS purchase_cnt, NVL(AVG(S.sales_item_cnt),0) AS sales_cnt
        FROM (SELECT yearmonth, item_status, item_no, cnt FROM month_inventory 
            WHERE    yearmonth = p_sum_yymm
            AND      startend_status = '0' -- 기초 재고에 한해
            ) M -- 월재고
            LEFT JOIN
            -- 부품
            (SELECT 0 AS item_status, PARTS_NO, PURCHASE_ITEM_CNT FROM purchase_item 
            WHERE purchase_no IN (
                SELECT purchase_no FROM purchase_order 
                WHERE TO_CHAR(purchase_date, 'YYMM') = p_sum_yymm
                AND in_status IN (2,3) -- 완료, 마감
                )
            ) P -- 구매 실적
            ON M.item_status = P.item_status
            AND M.item_no = P.parts_no
            LEFT JOIN
            -- 제품 -> 부품 자동 변환
            (SELECT 0 AS item_status, PB.parts_no, SUM(PB.cnt * SS.sales_item_cnt) AS sales_item_cnt
            FROM product_bom PB
            JOIN (
                SELECT product_no, sales_item_cnt FROM sales_item WHERE sales_no IN (
                SELECT sales_no FROM sales_order 
                WHERE TO_CHAR(sales_date, 'YYMM') = p_sum_yymm
                AND out_status IN (2,3) -- 완료, 마감
                )) SS
            ON PB.product_no = SS.product_no
            GROUP BY PB.parts_no) S -- 판매실적
            ON M.item_status = S.item_status
            AND M.item_no = S.parts_no
        GROUP BY M.yearmonth,M.item_status,M.item_no;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_prc2 START p_sum_yymm ' || p_sum_yymm);
        
        -- 이번달 발주, 수주, (폐기), (생산) 반영 하기
        FOR rec_close_clac IN cur_close_clac LOOP
            ------------------------------------------------------------------
            --    만약 창고 기초재고가 판매량보다 크다면 기말재고 입력 
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
                    , 1 -- 기말재고
                    , rec_close_clac.item_status
                    , rec_close_clac.item_no
                    , rec_close_clac.inventory_cnt + rec_close_clac.purchase_cnt - rec_close_clac.sales_cnt
                    , SYSDATE
                );
            ELSE
                --에러 기록
                g_prod_cnt := rec_close_clac.inventory_cnt + rec_close_clac.purchase_cnt - rec_close_clac.sales_cnt;
                dbms_output.put_line(rec_close_clac.yearmonth || '년월에 ' || rec_close_clac.item_status || ':' || rec_close_clac.item_no || '번호 ' ||  g_prod_cnt || '개수 부족');
            END IF;
        END LOOP;
        
        dbms_output.put_line('month_close_prc2 END');
        EXCEPTION
            WHEN OTHERS THEN
                  DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
    END;
END;
