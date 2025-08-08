/************************************************** 
 *  DROP TABLE
 **************************************************/
DROP TABLE BOARD CASCADE CONSTRAINTS;
DROP TABLE COMMON CASCADE CONSTRAINTS;
DROP TABLE CLIENT CASCADE CONSTRAINTS;
DROP TABLE CLIENT_HIS CASCADE CONSTRAINTS;
DROP TABLE CLIENT_PERFORM CASCADE CONSTRAINTS;
DROP TABLE DEPT CASCADE CONSTRAINTS;
DROP TABLE EMP CASCADE CONSTRAINTS;
DROP TABLE EMP_IMAGE CASCADE CONSTRAINTS;
DROP TABLE ERROR_LOG CASCADE CONSTRAINTS;
DROP TABLE INVENTORY CASCADE CONSTRAINTS;
DROP TABLE INVENTORY_ADJUST CASCADE CONSTRAINTS;
DROP TABLE INVENTORY_CLOSE CASCADE CONSTRAINTS;
DROP TABLE MONTH_INVENTORY CASCADE CONSTRAINTS;
DROP TABLE PARTS CASCADE CONSTRAINTS;
DROP TABLE PARTS_COSTHIS CASCADE CONSTRAINTS;
DROP TABLE PRODUCT CASCADE CONSTRAINTS;
DROP TABLE PRODUCT_BOM CASCADE CONSTRAINTS;
DROP TABLE PRODUCT_COSTHIS CASCADE CONSTRAINTS;
DROP TABLE PURCHASE_ITEM CASCADE CONSTRAINTS;
DROP TABLE PURCHASE_ORDER CASCADE CONSTRAINTS;
DROP TABLE PURCHASE_PERFORM CASCADE CONSTRAINTS;
DROP TABLE SALES_ITEM CASCADE CONSTRAINTS;
DROP TABLE SALES_ORDER CASCADE CONSTRAINTS;
DROP TABLE SALES_PERFORM CASCADE CONSTRAINTS;

/************************************************** 
 *  SEQUENCE : 시퀀스
 **************************************************/
-- 사원(EMP) 시퀀스
DROP SEQUENCE EMP_NO_SEQ;
CREATE SEQUENCE EMP_NO_SEQ
START WITH 1001 -- 시작 숫자
INCREMENT BY 1   -- 증가 값
NOCACHE         -- 캐시 사용 안 함
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

-- 부서(DEPT) 시퀀스
DROP SEQUENCE DEPT_CODE_SEQ;
CREATE SEQUENCE DEPT_CODE_SEQ
START WITH 1001 -- 시작 숫자
INCREMENT BY 1   -- 증가 값
NOCACHE         -- 캐시 사용 안 함
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

-- 게시판(BOARD) 시퀀스
DROP SEQUENCE BOARD_NO_SEQ;
CREATE SEQUENCE BOARD_NO_SEQ
START WITH 1 -- 시작 숫자
INCREMENT BY 1   -- 증가 값
NOCACHE         -- 캐시 사용 안 함
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

-- 에러(ERROR_LOG) 시퀀스
DROP SEQUENCE ERROR_LOG_SEQ;
CREATE SEQUENCE ERROR_LOG_SEQ
START WITH 1 -- 시작 숫자
INCREMENT BY 1 -- 증가값
NOCACHE -- 캐시 안 함 (옵션)
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

-- 재고(INVENTORY) 시퀀스
DROP SEQUENCE INVENTORY_SEQ;
CREATE SEQUENCE INVENTORY_SEQ
START WITH 1 -- 시작 숫자
INCREMENT BY 1 -- 증가값
NOCACHE -- 캐시 안 함 (옵션)
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

-- 재고(INVENTORY) 시퀀스
DROP SEQUENCE INVENTORY_ADJUST_SEQ;
CREATE SEQUENCE INVENTORY_ADJUST_SEQ
START WITH 1 -- 시작 숫자
INCREMENT BY 1 -- 증가값
NOCACHE -- 캐시 안 함 (옵션)
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

-- 제품가격변동이력(PRODUCT_PRICE_his) 시퀀스
DROP SEQUENCE PRODUCT_PRICE_his_SEQ;
CREATE SEQUENCE PRODUCT_PRICE_his_SEQ
START WITH 1 -- 시작 숫자
INCREMENT BY 1 -- 증가값
NOCACHE -- 캐시 안 함 (옵션)
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

-- 부품가격변동이력(PARTS_PRICE_HIS) 시퀀스
DROP SEQUENCE PARTS_PRICE_his_SEQ;
CREATE SEQUENCE PARTS_PRICE_his_SEQ
START WITH 1 -- 시작 숫자
INCREMENT BY 1 -- 증가값
NOCACHE -- 캐시 안 함 (옵션)
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

-- 부품(PARTS) 시퀀스
DROP SEQUENCE PARTS_SEQ;
CREATE SEQUENCE PARTS_SEQ
START WITH 1 -- 시작 숫자
INCREMENT BY 1 -- 증가값
NOCACHE -- 캐시 안 함 (옵션)
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음

--  제품(PRODUCT) 시퀀스
DROP SEQUENCE PRODUCT_SEQ;
CREATE SEQUENCE PRODUCT_SEQ
START WITH 1 -- 시작 숫자
INCREMENT BY 1 -- 증가값
NOCACHE -- 캐시 안 함 (옵션)
NOCYCLE; -- 마지막 값 이후 다시 1로 돌아가지 않음


/************************************************** 
 *  CREATE TABLE
 **************************************************/
 
/* 제품 ***********************************************************************/
CREATE TABLE product (
	product_no NUMBER(7) NOT NULL, /* 제품번호 */
	product_status NUMBER(1), /* 분류번호 */
	product_name VARCHAR2(100), /* 제품명 */
	product_context VARCHAR2(1000), /* 제품내용 */
	filename VARCHAR2(1000), /* 사진 */
	del_status NUMBER(1), /* 삭제구분 */
	emp_no NUMBER(7), /* 사원번호 */
	in_date TIMESTAMP /* 등록일자 */
);

CREATE UNIQUE INDEX PK_product
	ON product (
		product_no ASC
	);

ALTER TABLE product
	ADD
		CONSTRAINT PK_product
		PRIMARY KEY (
			product_no
		);

COMMENT ON TABLE product IS '제품';

COMMENT ON COLUMN product.product_no IS '제품번호';

COMMENT ON COLUMN product.product_status IS '분류번호';

COMMENT ON COLUMN product.product_name IS '제품명';

COMMENT ON COLUMN product.product_context IS '제품내용';

COMMENT ON COLUMN product.filename IS '사진';

COMMENT ON COLUMN product.del_status IS '삭제구분';

COMMENT ON COLUMN product.emp_no IS '사원번호';

COMMENT ON COLUMN product.in_date IS '등록일자';

/* 제품_BOM *******************************************************************/
CREATE TABLE product_BOM (
	product_no NUMBER(7) NOT NULL, /* 제품번호 */
	parts_no NUMBER(7) NOT NULL, /* 부품번호 */
	cnt NUMBER(10) /* 부품수량 */
);

CREATE UNIQUE INDEX PK_product_BOM
	ON product_BOM (
		product_no ASC,
		parts_no ASC
	);

ALTER TABLE product_BOM
	ADD
		CONSTRAINT PK_product_BOM
		PRIMARY KEY (
			product_no,
			parts_no
		);

COMMENT ON TABLE product_BOM IS '제품_BOM';

COMMENT ON COLUMN product_BOM.product_no IS '제품번호';

COMMENT ON COLUMN product_BOM.parts_no IS '부품번호';

COMMENT ON COLUMN product_BOM.cnt IS '부품수량';

/* 부품 ***********************************************************************/
CREATE TABLE parts (
	parts_no NUMBER(7) NOT NULL, /* 부품번호 */
	parts_status NUMBER(1), /* 분류번호 */
	parts_name VARCHAR2(100), /* 부품명 */
	parts_context VARCHAR2(1000), /* 부품내용 */
	manufacture VARCHAR2(100), /* 제조사 */
	filename VARCHAR2(1000), /* 사진 */
	del_status NUMBER(1), /* 삭제구분 */
	emp_no NUMBER(7), /* 사원번호 */
	in_date DATE /* 등록일자 */
);

CREATE UNIQUE INDEX PK_parts
	ON parts (
		parts_no ASC
	);

ALTER TABLE parts
	ADD
		CONSTRAINT PK_parts
		PRIMARY KEY (
			parts_no
		);

COMMENT ON TABLE parts IS '부품';

COMMENT ON COLUMN parts.parts_no IS '부품번호';

COMMENT ON COLUMN parts.parts_status IS '분류번호';

COMMENT ON COLUMN parts.parts_name IS '부품명';

COMMENT ON COLUMN parts.parts_context IS '부품내용';

COMMENT ON COLUMN parts.manufacture IS '제조사';

COMMENT ON COLUMN parts.filename IS '사진';

COMMENT ON COLUMN parts.del_status IS '삭제구분';

COMMENT ON COLUMN parts.emp_no IS '사원번호';

COMMENT ON COLUMN parts.in_date IS '등록일자';

/* 에러 ***********************************************************************/
CREATE TABLE error_log (
	error_no NUMBER(7) NOT NULL, /* 에러 번호 */
	error_code VARCHAR2(4000), /* 에러 코드 */
	error_coment VARCHAR2(4000), /* 에러 설명 */
	error_date DATE NOT NULL /* 에러 일시 */
);

CREATE UNIQUE INDEX PK_error_log
	ON error_log (
		error_no ASC
	);

ALTER TABLE error_log
	ADD
		CONSTRAINT PK_error_log
		PRIMARY KEY (
			error_no
		);

COMMENT ON TABLE error_log IS '에러';

COMMENT ON COLUMN error_log.error_no IS '에러 번호';

COMMENT ON COLUMN error_log.error_code IS '에러 코드';

COMMENT ON COLUMN error_log.error_coment IS '에러 설명';

COMMENT ON COLUMN error_log.error_date IS '에러 일시';

/* 재고 ***********************************************************************/
CREATE TABLE inventory (
	inventory_his_no NUMBER(7) NOT NULL, /* 재고변동이력번호 */
	order_status NUMBER(1) NOT NULL, /* 수주/발주 구분 */
	order_no NUMBER(7) NOT NULL, /* 수주/발주번호 */
	item_status NUMBER(1) NOT NULL, /* 제품/부품 구분 */
	item_no NUMBER(7) NOT NULL, /* 제품/부품번호 */
	inout_status NUMBER(1) NOT NULL, /* 입/출고 구분 */
	inout_date DATE NOT NULL, /* 입/출고일시 */
	item_cnt NUMBER(10), /* 변동 수량 */
	item_totalcnt NUMBER(10), /* 총 수량 */
	item_quality NUMBER(1) /* 품질 */
);

CREATE UNIQUE INDEX PK_inventory
	ON inventory (
		inventory_his_no ASC
	);

ALTER TABLE inventory
	ADD
		CONSTRAINT PK_inventory
		PRIMARY KEY (
			inventory_his_no
		);

COMMENT ON TABLE inventory IS '재고';

COMMENT ON COLUMN inventory.inventory_his_no IS '재고변동이력번호';

COMMENT ON COLUMN inventory.order_status IS '수주/발주 구분';

COMMENT ON COLUMN inventory.order_no IS '수주/발주번호';

COMMENT ON COLUMN inventory.item_status IS '제품/부품 구분';

COMMENT ON COLUMN inventory.item_no IS '제품/부품번호';

COMMENT ON COLUMN inventory.inout_status IS '입/출고 구분';

COMMENT ON COLUMN inventory.inout_date IS '입/출고일시';

COMMENT ON COLUMN inventory.item_cnt IS '변동 수량';

COMMENT ON COLUMN inventory.item_totalcnt IS '총 수량';

COMMENT ON COLUMN inventory.item_quality IS '품질';

/* 재고 조정 ***********************************************************************/
CREATE TABLE inventory_adjust (
	inventory_adjust_no NUMBER(7) NOT NULL, /* 재고조정번호 */
	adjust_status NUMBER(1) NOT NULL, /* 조정 구분 */
	item_status NUMBER(1) NOT NULL, /* 제품/부품 구분 */
	item_no NUMBER(7) NOT NULL, /* 제품/부품번호 */
	inout_status NUMBER(1) NOT NULL, /* 입/출고 구분 */
	item_cnt NUMBER(10), /* 변동 수량 */
	inout_date DATE NOT NULL, /* 입/출고일시 */
    item_close_status NUMBER(1) NOT NULL /* 마감 구분 */
);

CREATE UNIQUE INDEX PK_inventory_adjust
	ON inventory_adjust (
		inventory_adjust_no ASC
	);

ALTER TABLE inventory_adjust
	ADD
		CONSTRAINT PK_inventory_adjust
		PRIMARY KEY (
			inventory_adjust_no
		);

COMMENT ON TABLE inventory_adjust IS '재고 조정';

COMMENT ON COLUMN inventory_adjust.inventory_adjust_no IS '재고조정번호';

COMMENT ON COLUMN inventory_adjust.adjust_status IS '조정 구분';

COMMENT ON COLUMN inventory_adjust.item_status IS '제품/부품 구분';

COMMENT ON COLUMN inventory_adjust.item_no IS '제품/부품번호';

COMMENT ON COLUMN inventory_adjust.inout_status IS '입/출고 구분';

COMMENT ON COLUMN inventory_adjust.item_cnt IS '변동 수량';

COMMENT ON COLUMN inventory_adjust.inout_date IS '입/출고일시';

COMMENT ON COLUMN inventory_adjust.item_close_status IS '마감 구분';

/* 월 재고 ********************************************************************/
CREATE TABLE month_inventory (
	yearmonth VARCHAR2(4) NOT NULL, /* 년월 */
	startend_status NUMBER(1) NOT NULL, /* 기초/기말 구분 */
	item_status NUMBER(1) NOT NULL, /* 제품/부품 구분 */
	item_no NUMBER(7) NOT NULL, /* 제품/부품번호 */
	cnt NUMBER(10), /* 수량 */
	in_date DATE /* 등록일자 */
);

CREATE UNIQUE INDEX PK_month_inventory
	ON month_inventory (
		yearmonth ASC,
		startend_status ASC,
		item_status ASC,
		item_no ASC
	);

ALTER TABLE month_inventory
	ADD
		CONSTRAINT PK_month_inventory
		PRIMARY KEY (
			yearmonth,
			startend_status,
			item_status,
			item_no
		);

COMMENT ON TABLE month_inventory IS '월 재고';

COMMENT ON COLUMN month_inventory.yearmonth IS '년월';

COMMENT ON COLUMN month_inventory.startend_status IS '기초/기말 구분';

COMMENT ON COLUMN month_inventory.item_status IS '제품/부품 구분';

COMMENT ON COLUMN month_inventory.item_no IS '제품/부품번호';

COMMENT ON COLUMN month_inventory.cnt IS '수량';

COMMENT ON COLUMN month_inventory.in_date IS '등록일자';

/* 제품가격변동이력 ***********************************************************/
CREATE TABLE product_costhis (
	product_costhis_no NUMBER(7) NOT NULL, /* 제품가격변동이력 */
	product_no NUMBER(7) NOT NULL, /* 제품번호 */
	start_date DATE NOT NULL, /* 시작일자 */
	end_date DATE, /* 종료일자 */
	price NUMBER(19) /* 가격 */
);

CREATE UNIQUE INDEX PK_product_costhis
	ON product_costhis (
		product_costhis_no ASC
	);

ALTER TABLE product_costhis
	ADD
		CONSTRAINT PK_product_costhis
		PRIMARY KEY (
			product_costhis_no
		);

COMMENT ON TABLE product_costhis IS '제품가격변동이력';

COMMENT ON COLUMN product_costhis.product_costhis_no IS '제품가격변동이력';

COMMENT ON COLUMN product_costhis.product_no IS '제품번호';

COMMENT ON COLUMN product_costhis.start_date IS '시작일자';

COMMENT ON COLUMN product_costhis.end_date IS '종료일자';

COMMENT ON COLUMN product_costhis.price IS '가격';

/* 매출실적 *******************************************************************/
CREATE TABLE sales_perform (
	yearmonth VARCHAR2(4) NOT NULL, /* 년월 */
	product_no NUMBER(7) NOT NULL, /* 제품번호 */
	cnt NUMBER(10), /* 수량 */
	total NUMBER(19) /* 총액 */
);

CREATE UNIQUE INDEX PK_sales_perform
	ON sales_perform (
		yearmonth ASC,
		product_no ASC
	);

ALTER TABLE sales_perform
	ADD
		CONSTRAINT PK_sales_perform
		PRIMARY KEY (
			yearmonth,
			product_no
		);

COMMENT ON TABLE sales_perform IS '매출실적';

COMMENT ON COLUMN sales_perform.yearmonth IS '년월';

COMMENT ON COLUMN sales_perform.product_no IS '제품번호';

COMMENT ON COLUMN sales_perform.cnt IS '수량';

COMMENT ON COLUMN sales_perform.total IS '총액';

/* 수주 ***********************************************************************/
CREATE TABLE SALES_ORDER (
	sales_no NUMBER(7) NOT NULL, /* 수주번호 */
	client_no NUMBER(7), /* 거래처번호 */
    emp_no NUMBER(7), /* 사원번호 */
	sales_date DATE, /* 납기완료일 */
	out_status NUMBER(1), /* 출고상태 */
	del_status NUMBER(1), /* 삭제구분 */
	in_date DATE /* 등록일시 */
);

CREATE UNIQUE INDEX PK_SALES_ORDER
	ON SALES_ORDER (
		sales_no ASC
	);

ALTER TABLE SALES_ORDER
	ADD
		CONSTRAINT PK_SALES_ORDER
		PRIMARY KEY (
			sales_no
		);

COMMENT ON TABLE SALES_ORDER IS '수주';

COMMENT ON COLUMN SALES_ORDER.sales_no IS '수주번호';

COMMENT ON COLUMN SALES_ORDER.client_no IS '거래처번호';

COMMENT ON COLUMN SALES_ORDER.emp_no IS '사원번호';

COMMENT ON COLUMN SALES_ORDER.sales_date IS '납기완료일';

COMMENT ON COLUMN SALES_ORDER.out_status IS '출고상태';

COMMENT ON COLUMN SALES_ORDER.del_status IS '삭제구분';

COMMENT ON COLUMN SALES_ORDER.in_date IS '등록일시';

/* 발주 ***********************************************************************/
CREATE TABLE PURCHASE_ORDER (
	purchase_no NUMBER(7) NOT NULL, /* 발주번호 */
	client_no NUMBER(7), /* 거래처번호 */
	emp_no NUMBER(7), /* 사원번호 */
	purchase_date DATE, /* 납기완료일 */
	in_status NUMBER(1), /* 입고상태 */
	del_status NUMBER(1), /* 삭제구분 */
	in_date DATE /* 등록일시 */
);

CREATE UNIQUE INDEX PK_PURCHASE_ORDER
	ON PURCHASE_ORDER (
		purchase_no ASC
	);

ALTER TABLE PURCHASE_ORDER
	ADD
		CONSTRAINT PK_PURCHASE_ORDER
		PRIMARY KEY (
			purchase_no
		);

COMMENT ON TABLE PURCHASE_ORDER IS '발주';

COMMENT ON COLUMN PURCHASE_ORDER.purchase_no IS '발주번호';

COMMENT ON COLUMN PURCHASE_ORDER.client_no IS '거래처번호';

COMMENT ON COLUMN PURCHASE_ORDER.emp_no IS '사원번호';

COMMENT ON COLUMN PURCHASE_ORDER.purchase_date IS '납기완료일';

COMMENT ON COLUMN PURCHASE_ORDER.in_status IS '입고상태';

COMMENT ON COLUMN PURCHASE_ORDER.del_status IS '삭제구분';

COMMENT ON COLUMN PURCHASE_ORDER.in_date IS '등록일시';

/* 거래처 *********************************************************************/
CREATE TABLE client (
	client_no NUMBER(7) NOT NULL, /* 거래처번호 */
	emp_no NUMBER(7), /* 사원번호 */
	client_name VARCHAR2(100), /* 거래처명 */
	client_gubun NUMBER(1), /* 거래처유형 */
	client_email VARCHAR2(100), /* 거래처이메일 */
    client_tel VARCHAR2(13), /* 거래처전화번호 */
	client_man VARCHAR2(100), /* 거래처담당자명 */
	client_address VARCHAR2(100), /* 거래처주소 */
	del_status NUMBER(1), /* 삭제구분 */
	modify_date DATE, /* 수정일자 */
	in_date DATE /* 등록일자 */
);

CREATE UNIQUE INDEX PK_client
	ON client (
		client_no ASC
	);

ALTER TABLE client
	ADD
		CONSTRAINT PK_client
		PRIMARY KEY (
			client_no
		);

COMMENT ON TABLE client IS '거래처';

COMMENT ON COLUMN client.client_no IS '거래처번호';

COMMENT ON COLUMN client.emp_no IS '사원번호';

COMMENT ON COLUMN client.client_name IS '거래처명';

COMMENT ON COLUMN client.client_gubun IS '거래처유형';

COMMENT ON COLUMN client.client_email IS '거래처이메일';

COMMENT ON COLUMN client.client_tel IS '거래처전화번호';

COMMENT ON COLUMN client.client_man IS '거래처담당자명';

COMMENT ON COLUMN client.client_address IS '거래처주소';

COMMENT ON COLUMN client.del_status IS '삭제구분';

COMMENT ON COLUMN client.modify_date IS '수정일자';

COMMENT ON COLUMN client.in_date IS '등록일자';

/* 수주 제품 ******************************************************************/
CREATE TABLE SALES_ITEM (
	sales_no NUMBER(7) NOT NULL, /* 수주번호 */
	product_no NUMBER(7) NOT NULL, /* 제품번호 */
	sales_item_cnt NUMBER(10), /* 요청수량 */
	sales_item_outcnt NUMBER(10), /* 출고수량 */
	sales_item_cost NUMBER(10) /* 단가 */
);

CREATE UNIQUE INDEX PK_SALES_ITEM
	ON SALES_ITEM (
		sales_no ASC,
		product_no ASC
	);

ALTER TABLE SALES_ITEM
	ADD
		CONSTRAINT PK_SALES_ITEM
		PRIMARY KEY (
			sales_no,
			product_no
		);

COMMENT ON TABLE SALES_ITEM IS '수주 제품';

COMMENT ON COLUMN SALES_ITEM.sales_no IS '수주번호';

COMMENT ON COLUMN SALES_ITEM.product_no IS '제품번호';

COMMENT ON COLUMN SALES_ITEM.sales_item_cnt IS '요청수량';

COMMENT ON COLUMN SALES_ITEM.sales_item_outcnt IS '출고수량';

COMMENT ON COLUMN SALES_ITEM.sales_item_cost IS '단가';

/* 발주 부품 */
CREATE TABLE PURCHASE_ITEM (
	purchase_no NUMBER(7) NOT NULL, /* 발주번호 */
	parts_no NUMBER(7) NOT NULL, /* 부품번호 */
	purchase_item_cnt NUMBER(10), /* 요청수량 */
	purchase_item_incnt NUMBER(10), /* 입고수량 */
	purchase_item_cost NUMBER(10) /* 단가 */
);

CREATE UNIQUE INDEX PK_PURCHASE_ITEM
	ON PURCHASE_ITEM (
		purchase_no ASC,
		parts_no ASC
	);

ALTER TABLE PURCHASE_ITEM
	ADD
		CONSTRAINT PK_PURCHASE_ITEM
		PRIMARY KEY (
			purchase_no,
			parts_no
		);

COMMENT ON TABLE PURCHASE_ITEM IS '발주 부품';

COMMENT ON COLUMN PURCHASE_ITEM.purchase_no IS '발주번호';

COMMENT ON COLUMN PURCHASE_ITEM.parts_no IS '부품번호';

COMMENT ON COLUMN PURCHASE_ITEM.purchase_item_cnt IS '요청수량';

COMMENT ON COLUMN PURCHASE_ITEM.purchase_item_incnt IS '입고수량';

COMMENT ON COLUMN PURCHASE_ITEM.purchase_item_cost IS '단가';

/* 공통 ***********************************************************************/
CREATE TABLE common (
	big_status NUMBER(4) NOT NULL, /* 대분류 */
	middle_status NUMBER(4) NOT NULL, /* 중분류 */
	context VARCHAR2(100) /* 내용 */
);

CREATE UNIQUE INDEX PK_common
	ON common (
		big_status ASC,
		middle_status ASC
	);

ALTER TABLE common
	ADD
		CONSTRAINT PK_common
		PRIMARY KEY (
			big_status,
			middle_status
		);

COMMENT ON TABLE common IS '공통';

COMMENT ON COLUMN common.big_status IS '대분류';

COMMENT ON COLUMN common.middle_status IS '중분류';

COMMENT ON COLUMN common.context IS '내용';

/* 부품가격변동이력 ***********************************************************/
CREATE TABLE parts_costhis (
	parts_costhis_no NUMBER(7) NOT NULL, /* 부품가격변동이력번호 */
	parts_no NUMBER(7) NOT NULL, /* 부품번호 */
	start_date DATE NOT NULL, /* 시작일자 */
	end_date DATE, /* 종료일자 */
	price NUMBER(19) /* 가격 */
);

CREATE UNIQUE INDEX PK_parts_costhis
	ON parts_costhis (
		parts_costhis_no ASC
	);

ALTER TABLE parts_costhis
	ADD
		CONSTRAINT PK_parts_costhis
		PRIMARY KEY (
			parts_costhis_no
		);

COMMENT ON TABLE parts_costhis IS '부품가격변동이력';

COMMENT ON COLUMN parts_costhis.parts_costhis_no IS '부품가격변동이력번호';

COMMENT ON COLUMN parts_costhis.parts_no IS '부품번호';

COMMENT ON COLUMN parts_costhis.start_date IS '시작일자';

COMMENT ON COLUMN parts_costhis.end_date IS '종료일자';

COMMENT ON COLUMN parts_costhis.price IS '가격';

/* 매입실적 *******************************************************************/
CREATE TABLE purchase_perform (
	yearmonth VARCHAR2(4) NOT NULL, /* 년월 */
	parts_no NUMBER(7) NOT NULL, /* 부품번호 */
	cnt NUMBER(10), /* 수량 */
	total NUMBER(19) /* 총액 */
);

CREATE UNIQUE INDEX PK_purchase_perform
	ON purchase_perform (
		yearmonth ASC,
		parts_no ASC
	);

ALTER TABLE purchase_perform
	ADD
		CONSTRAINT PK_purchase_perform
		PRIMARY KEY (
			yearmonth,
			parts_no
		);

COMMENT ON TABLE purchase_perform IS '매입실적';

COMMENT ON COLUMN purchase_perform.yearmonth IS '년월';

COMMENT ON COLUMN purchase_perform.parts_no IS '부품번호';

COMMENT ON COLUMN purchase_perform.cnt IS '수량';

COMMENT ON COLUMN purchase_perform.total IS '총액';

/* 거래처별 실적 **************************************************************/
CREATE TABLE Client_perform (
	yearmonth VARCHAR2(4) NOT NULL, /* 년월 */
	client_no NUMBER(7) NOT NULL, /* 거래처번호 */
	cnt NUMBER(10), /* 건수 */
	total_amt NUMBER(19) /* 총액 */
);

CREATE UNIQUE INDEX PK_Client_perform
	ON Client_perform (
		yearmonth ASC,
		client_no ASC
	);

ALTER TABLE Client_perform
	ADD
		CONSTRAINT PK_Client_perform
		PRIMARY KEY (
			yearmonth,
			client_no
		);

COMMENT ON TABLE Client_perform IS '거래처별 실적';

COMMENT ON COLUMN Client_perform.yearmonth IS '년월';

COMMENT ON COLUMN Client_perform.client_no IS '거래처번호';

COMMENT ON COLUMN Client_perform.cnt IS '건수';

COMMENT ON COLUMN Client_perform.total_amt IS '총액';

/* 수불마감 *******************************************************************/
CREATE TABLE inventory_close (
	yearmonth VARCHAR2(4) NOT NULL, /* 년월 */
	close_status NUMBER(1), /* 마감완료여부 */
	close_startdate DATE, /* 마감시작일시 */
	close_enddate DATE, /* 마감종료일시 */
	emp_no NUMBER(7) /* 마감처리담당자 */
);

CREATE UNIQUE INDEX PK_inventory_close
	ON inventory_close (
		yearmonth ASC
	);

ALTER TABLE inventory_close
	ADD
		CONSTRAINT PK_inventory_close
		PRIMARY KEY (
			yearmonth
		);

COMMENT ON TABLE inventory_close IS '수불마감';

COMMENT ON COLUMN inventory_close.yearmonth IS '년월';

COMMENT ON COLUMN inventory_close.close_status IS '마감완료여부';

COMMENT ON COLUMN inventory_close.close_startdate IS '마감시작일시';

COMMENT ON COLUMN inventory_close.close_enddate IS '마감종료일시';

COMMENT ON COLUMN inventory_close.emp_no IS '마감처리담당자';

/* 거래처 이력 ****************************************************************/
CREATE TABLE client_HIS (
	client_no NUMBER(7) NOT NULL, /* 거래처번호 */
	start_date VARCHAR2(8) NOT NULL, /* 시작일자 */
	end_date VARCHAR2(8) NOT NULL, /* 종료일자 */
	emp_no NUMBER(7), /* 사원번호 */
	client_name VARCHAR2(100), /* 거래처명 */
	client_gubun NUMBER(1), /* 거래처유형 */
    client_man VARCHAR2(100), /* 거래처담당자명 */
	client_email VARCHAR2(100), /* 거래처이메일 */
    client_tel VARCHAR2(13), /* 거래처전화번호 */
	client_address VARCHAR2(100), /* 거래처주소 */
	in_date DATE /* 등록일자 */
);

CREATE UNIQUE INDEX PK_client_HIS
	ON client_HIS (
		client_no ASC,
		start_date ASC
	);

ALTER TABLE client_HIS
	ADD
		CONSTRAINT PK_client_HIS
		PRIMARY KEY (
			client_no,
			start_date
		);

COMMENT ON TABLE client_HIS IS '거래처 이력';

COMMENT ON COLUMN client_HIS.client_no IS '거래처번호';

COMMENT ON COLUMN client_HIS.start_date IS '시작일자';

COMMENT ON COLUMN client_HIS.end_date IS '종료일자';

COMMENT ON COLUMN client_HIS.emp_no IS '사원번호';

COMMENT ON COLUMN client_HIS.client_name IS '거래처명';

COMMENT ON COLUMN client_HIS.client_gubun IS '거래처유형';

COMMENT ON COLUMN client.client_man IS '거래처담당자명';

COMMENT ON COLUMN client_HIS.client_email IS '거래처이메일';

COMMENT ON COLUMN client_HIS.client_tel IS '거래처전화번호';

COMMENT ON COLUMN client_HIS.client_address IS '거래처주소';

COMMENT ON COLUMN client_HIS.in_date IS '등록일자';

/* 사원 ***********************************************************************/
CREATE TABLE emp (
	emp_no NUMBER(7) NOT NULL, /* 사원번호 */
	emp_name VARCHAR2(100), /* 사원명 */
	emp_tel VARCHAR2(13), /* 전화번호 */
	email VARCHAR2(50), /* e-Mail */
	sal NUMBER(10), /* 급여 */
	dept_code NUMBER(4), /* 부서번호 */
	username VARCHAR2(100), /* 사원아이디 */
	password VARCHAR2(1000), /* 사원비밀번호 */
	roles_status VARCHAR2(20), /* 권한구분 */
	del_status NUMBER(1), /* 삭제구분 */
	registrar NUMBER(7), /* 등록자 */
	in_date DATE /* 등록일자 */
);

CREATE UNIQUE INDEX PK_emp
	ON emp (
		emp_no ASC
	);

ALTER TABLE emp
	ADD
		CONSTRAINT PK_emp
		PRIMARY KEY (
			emp_no
		);

COMMENT ON TABLE emp IS '사원';

COMMENT ON COLUMN emp.emp_no IS '사원번호';

COMMENT ON COLUMN emp.emp_name IS '사원명';

COMMENT ON COLUMN emp.emp_tel IS '전화번호';

COMMENT ON COLUMN emp.email IS 'e-Mail';

COMMENT ON COLUMN emp.sal IS '급여';

COMMENT ON COLUMN emp.dept_code IS '부서번호';

COMMENT ON COLUMN emp.username IS '사원아이디';

COMMENT ON COLUMN emp.password IS '사원비밀번호';

COMMENT ON COLUMN emp.roles_status IS '권한구분';

COMMENT ON COLUMN emp.del_status IS '삭제구분';

COMMENT ON COLUMN emp.registrar IS '등록자';

COMMENT ON COLUMN emp.in_date IS '등록일자';

/* 게시판 *********************************************************************/
CREATE TABLE board (
	board_no NUMBER(7) NOT NULL, /* 게시판번호 */
	emp_no NUMBER(7), /* 사원번호 */
	title VARCHAR2(100), /* 게시판제목 */
	content VARCHAR2(1000), /* 게시판내용 */
	read_count NUMBER(7), /* 조회수 */
	ref NUMBER(7), /* ref */
	re_lvl NUMBER(2), /* re_lvl */
	re_step NUMBER(7), /* re_step */
	in_date DATE /* 등록일시 */
);

CREATE UNIQUE INDEX PK_board
	ON board (
		board_no ASC
	);

ALTER TABLE board
	ADD
		CONSTRAINT PK_board
		PRIMARY KEY (
			board_no
		);

COMMENT ON TABLE board IS '게시판';

COMMENT ON COLUMN board.board_no IS '게시판번호';

COMMENT ON COLUMN board.emp_no IS '사원번호';

COMMENT ON COLUMN board.title IS '게시판제목';

COMMENT ON COLUMN board.content IS '게시판내용';

COMMENT ON COLUMN board.read_count IS '조회수';

COMMENT ON COLUMN board.ref IS 'ref';

COMMENT ON COLUMN board.re_lvl IS 're_lvl';

COMMENT ON COLUMN board.re_step IS 're_step';

COMMENT ON COLUMN board.in_date IS '등록일시';

/* 부서 ***********************************************************************/
CREATE TABLE dept (
	dept_code NUMBER(4) NOT NULL, /* 부서번호 */
	dept_name VARCHAR2(100), /* 부서명 */
	dept_captain NUMBER(7), /* 부서장 */
	parent_dept_code NUMBER(4), /* 상위부서코드 */
	dept_loc VARCHAR2(100), /* 위치 */
    loc_detail VARCHAR2(50), /* 위치상세 */
	del_status NUMBER(1), /* 삭제구분 */
	registrar NUMBER(7), /* 등록자 */
	in_date DATE /* 등록일자 */
);

CREATE UNIQUE INDEX PK_dept
	ON dept (
		dept_code ASC
	);

ALTER TABLE dept
	ADD
		CONSTRAINT PK_dept
		PRIMARY KEY (
			dept_code
		);

COMMENT ON TABLE dept IS '부서';

COMMENT ON COLUMN dept.dept_code IS '부서번호';

COMMENT ON COLUMN dept.dept_name IS '부서명';

COMMENT ON COLUMN dept.dept_captain IS '부서장';

COMMENT ON COLUMN dept.parent_dept_code IS '상위부서코드';

COMMENT ON COLUMN dept.dept_loc IS '위치';

COMMENT ON COLUMN dept.loc_detail IS '위치상세';

COMMENT ON COLUMN dept.del_status IS '삭제구분';

COMMENT ON COLUMN dept.registrar IS '등록자';

COMMENT ON COLUMN dept.in_date IS '등록일자';

/* 사원 사진 ******************************************************************/
CREATE TABLE emp_image (
	emp_no NUMBER(7) NOT NULL, /* 사원번호 */
	order_num NUMBER(1) NOT NULL, /* 사진번호 */
	emp_filename VARCHAR2(500) /* 사진 */
);

CREATE UNIQUE INDEX PK_emp_image
	ON emp_image (
		emp_no ASC,
		order_num ASC
	);

ALTER TABLE emp_image
	ADD
		CONSTRAINT PK_emp_image
		PRIMARY KEY (
			emp_no,
			order_num
		);

COMMENT ON TABLE emp_image IS '사원 사진';

COMMENT ON COLUMN emp_image.emp_no IS '사원번호';

COMMENT ON COLUMN emp_image.order_num IS '사진번호';

COMMENT ON COLUMN emp_image.emp_filename IS '사진';

/* 테이블수정 ******************************************************************/
ALTER TABLE product
	ADD
		CONSTRAINT FK_emp_TO_product
		FOREIGN KEY (
			emp_no
		)
		REFERENCES emp (
			emp_no
		);

ALTER TABLE product_BOM
	ADD
		CONSTRAINT FK_product_TO_product_BOM
		FOREIGN KEY (
			product_no
		)
		REFERENCES product (
			product_no
		);

ALTER TABLE product_BOM
	ADD
		CONSTRAINT FK_parts_TO_product_BOM
		FOREIGN KEY (
			parts_no
		)
		REFERENCES parts (
			parts_no
		);

ALTER TABLE parts
	ADD
		CONSTRAINT FK_emp_TO_parts
		FOREIGN KEY (
			emp_no
		)
		REFERENCES emp (
			emp_no
		);

ALTER TABLE product_costhis
	ADD
		CONSTRAINT FK_product_TO_product_costhis
		FOREIGN KEY (
			product_no
		)
		REFERENCES product (
			product_no
		);

ALTER TABLE sales_perform
	ADD
		CONSTRAINT FK_product_TO_sales_perform
		FOREIGN KEY (
			product_no
		)
		REFERENCES product (
			product_no
		);

ALTER TABLE SALES_ORDER
	ADD
		CONSTRAINT FK_client_TO_SALES_ORDER
		FOREIGN KEY (
			client_no
		)
		REFERENCES client (
			client_no
		);
        
ALTER TABLE SALES_ORDER
	ADD
		CONSTRAINT FK_emp_TO_SALES_ORDER
		FOREIGN KEY (
			emp_no
		)
		REFERENCES emp (
			emp_no
		);
        
ALTER TABLE PURCHASE_ORDER
	ADD
		CONSTRAINT FK_client_TO_PURCHASE_ORDER
		FOREIGN KEY (
			client_no
		)
		REFERENCES client (
			client_no
		);

ALTER TABLE PURCHASE_ORDER
	ADD
		CONSTRAINT FK_emp_TO_PURCHASE_ORDER
		FOREIGN KEY (
			emp_no
		)
		REFERENCES emp (
			emp_no
		);

ALTER TABLE client
	ADD
		CONSTRAINT FK_emp_TO_client
		FOREIGN KEY (
			emp_no
		)
		REFERENCES emp (
			emp_no
		);

ALTER TABLE SALES_ITEM
	ADD
		CONSTRAINT FK_SALES_ORDER_TO_SALES_ITEM
		FOREIGN KEY (
			sales_no
		)
		REFERENCES SALES_ORDER (
			sales_no
		);

ALTER TABLE SALES_ITEM
	ADD
		CONSTRAINT FK_product_TO_SALES_ITEM
		FOREIGN KEY (
			product_no
		)
		REFERENCES product (
			product_no
		);

ALTER TABLE PURCHASE_ITEM
	ADD
		CONSTRAINT FK_PRCHS_ORDER_TO_PRCHS_ITM
		FOREIGN KEY (
			purchase_no
		)
		REFERENCES PURCHASE_ORDER (
			purchase_no
		);

ALTER TABLE PURCHASE_ITEM
	ADD
		CONSTRAINT FK_parts_TO_PURCHASE_ITEM
		FOREIGN KEY (
			parts_no
		)
		REFERENCES parts (
			parts_no
		);
        
ALTER TABLE parts_costhis
	ADD
		CONSTRAINT FK_parts_TO_parts_costhis
		FOREIGN KEY (
			parts_no
		)
		REFERENCES parts (
			parts_no
		);

ALTER TABLE purchase_perform
	ADD
		CONSTRAINT FK_parts_TO_purchase_perform
		FOREIGN KEY (
			parts_no
		)
		REFERENCES parts (
			parts_no
		);        

ALTER TABLE Client_perform
	ADD
		CONSTRAINT FK_client_TO_Client_perform
		FOREIGN KEY (
			client_no
		)
		REFERENCES client (
			client_no
		);

ALTER TABLE client_HIS
	ADD
		CONSTRAINT FK_client_TO_client_HIS
		FOREIGN KEY (
			client_no
		)
		REFERENCES client (
			client_no
		);
        
ALTER TABLE client_HIS
	ADD
		CONSTRAINT FK_emp_TO_client_HIS
		FOREIGN KEY (
			emp_no
		)
		REFERENCES emp (
			emp_no
		);    

ALTER TABLE emp
	ADD
		CONSTRAINT FK_dept_TO_emp
		FOREIGN KEY (
			dept_code
		)
		REFERENCES dept (
			dept_code
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_emp_TO_board
		FOREIGN KEY (
			emp_no
		)
		REFERENCES emp (
			emp_no
		);

ALTER TABLE emp_image
	ADD
		CONSTRAINT FK_emp_TO_emp_image
		FOREIGN KEY (
			emp_no
		)
		REFERENCES emp (
			emp_no
		);

/************************************************** 
 * TRIGGER : 트리거
 **************************************************/
-- DROP : 관련 테이블 삭제시 트리거도 함께 삭제되어 삭제 불필요
-- DROP TRIGGER TRIGGER_SALES_INVENHIS;
-- DROP TRIGGER TRIGGER_PURCHASE_INVENHIS;
/
-- inventory 트리거
CREATE OR REPLACE TRIGGER TRIGGER_SALES_INVENHIS
AFTER INSERT OR UPDATE OR DELETE ON sales_item -- 수주, 제품 판매
FOR EACH ROW
BEGIN
    -- 제품을 부품으로 변환
    DECLARE
        CURSOR cur_trans IS
            SELECT parts_no, cnt
            FROM product_bom
            WHERE product_no = :NEW.product_no;
    BEGIN
        IF INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('sales_item INSERT 발생' || :NEW.product_no);
            -- 재고 변동 없으면 처리하지 않음
            IF :NEW.sales_item_outcnt != 0 THEN
                -- 재고 조정 테이블에 부품 생산-
                FOR rec IN cur_trans LOOP
                    INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                    VALUES (inventory_adjust_seq.nextval, 4/*제조*/, 0/*부품*/, rec.parts_no, 1/*OUT*/, rec.cnt * :NEW.sales_item_outcnt, sysdate, 2/*완료*/);
                END LOOP;
                -- 재고 조정 테이블에 제품 생산+
                INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                VALUES (inventory_adjust_seq.nextval, 4/*제조*/, 1/*제품*/, :NEW.product_no, 0/*IN*/, :NEW.sales_item_outcnt, sysdate, 2/*완료*/);
                
                -- 제품을 수주 기록
                INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
                VALUES (inventory_seq.nextval, 0/*수주*/, :NEW.sales_no, 1/*제품*/, :NEW.product_no, 1/*OUT*/, :NEW.sales_item_outcnt, null, sysdate, 0/*품질*/);
            END IF;
        ELSIF UPDATING THEN
            DBMS_OUTPUT.PUT_LINE('sales_item UPDATE 발생' || :OLD.product_no || :OLD.sales_item_outcnt);
            DBMS_OUTPUT.PUT_LINE('sales_item UPDATE 발생' || :OLD.product_no || :NEW.sales_item_outcnt);
                -- 증가 : OUT 처리(정상)
            IF :NEW.sales_item_outcnt > :OLD.sales_item_outcnt THEN
                -- 재고 조정 테이블에 부품 생산-
                FOR rec IN cur_trans LOOP
                    INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                    VALUES (inventory_adjust_seq.nextval, 4/*제조*/, 0/*부품*/, rec.parts_no, 1/*OUT*/, rec.cnt * (:NEW.sales_item_outcnt - :OLD.sales_item_outcnt), sysdate, 2/*완료*/);
                END LOOP;
                -- 재고 조정 테이블에 제품 생산+
                INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                VALUES (inventory_adjust_seq.nextval, 4/*제조*/, 1/*제품*/, :NEW.product_no, 0/*IN*/, :NEW.sales_item_outcnt - :OLD.sales_item_outcnt, sysdate, 2/*완료*/);
                
                -- 제품을 수주 기록
                INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
                VALUES (inventory_seq.nextval, 0/*수주*/, :NEW.sales_no, 1/*제품*/, :NEW.product_no, 1/*OUT*/, :NEW.sales_item_outcnt - :OLD.sales_item_outcnt, null, sysdate, 0/*품질*/);
            -- 감소 : IN 처리(리콜)
            ELSIF :NEW.sales_item_outcnt < :OLD.sales_item_outcnt THEN
                -- 제품을 리콜 기록
                INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
                VALUES (inventory_seq.nextval, 2/*수주취소*/, :NEW.sales_no, 1/*제품*/, :NEW.product_no, 0/*IN*/, :OLD.sales_item_outcnt - :NEW.sales_item_outcnt, null, sysdate, 0/*품질*/);
                
                -- 재고 조정 테이블에 제품 분해-
                INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                VALUES (inventory_adjust_seq.nextval, 5/*분해*/, 1/*제품*/, :NEW.product_no, 1/*OUT*/, :OLD.sales_item_outcnt - :NEW.sales_item_outcnt, sysdate, 2/*완료*/);
                -- 재고 조정 테이블에 부품 분해+
                FOR rec IN cur_trans LOOP
                    INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                    VALUES (inventory_adjust_seq.nextval, 5/*분해*/, 0/*부품*/, rec.parts_no, 0/*IN*/, rec.cnt * (:OLD.sales_item_outcnt - :NEW.sales_item_outcnt), sysdate, 2/*완료*/);
                END LOOP;
            END IF;
        ELSIF DELETING THEN
            -- 수주, 제품 판매를 취소했으므로 다시 IN
            DBMS_OUTPUT.PUT_LINE('sales_item DELETE 발생' || :OLD.product_no);
            IF :OLD.sales_item_outcnt != 0 THEN
                -- 제품을 전량 리콜 기록
                INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
                VALUES (inventory_seq.nextval, 2/*수주취소*/, :OLD.sales_no, 1/*제품*/, :OLD.product_no, 0/*IN*/, :OLD.sales_item_outcnt, null, sysdate, 0/*품질*/);
                
                -- 재고 조정 테이블에 제품 분해-
                INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                VALUES (inventory_adjust_seq.nextval, 5/*분해*/, 1/*제품*/, :OLD.product_no, 1/*OUT*/, :OLD.sales_item_outcnt, sysdate, 2/*완료*/);
                -- 재고 조정 테이블에 부품 분해+
                FOR rec IN cur_trans LOOP
                    INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                    VALUES (inventory_adjust_seq.nextval, 5/*분해*/, 0/*부품*/, rec.parts_no, 0/*IN*/, rec.cnt * :OLD.sales_item_outcnt, sysdate, 2/*완료*/);
                END LOOP;
            END IF;
        END IF;
    END;
END;
/
CREATE OR REPLACE TRIGGER TRIGGER_PURCHASE_INVENHIS
AFTER INSERT OR UPDATE OR DELETE ON purchase_item -- 발주, 부품 구매
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('purchase_item INSERT 발생' || :NEW.parts_no);
        -- 재고 변동 없으면 처리하지 않음
        IF :NEW.purchase_item_incnt != 0 THEN
            INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
            VALUES (inventory_seq.nextval, 1/*발주*/, :NEW.purchase_no, 0/*부품*/, :NEW.parts_no, 0/*IN*/, :NEW.purchase_item_incnt, null, sysdate, 0/*품질*/);
        END IF;
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('purchase_item UPDATE 발생' || :OLD.parts_no || :OLD.purchase_item_incnt);
        DBMS_OUTPUT.PUT_LINE('purchase_item UPDATE 발생' || :OLD.parts_no || :NEW.purchase_item_incnt);
        IF :NEW.purchase_item_incnt > :OLD.purchase_item_incnt THEN
            -- 증가: IN 처리
            INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
            VALUES (inventory_seq.nextval, 1/*발주*/, :NEW.purchase_no, 0/*부품*/, :NEW.parts_no, 0/*IN*/, :NEW.purchase_item_incnt - :OLD.purchase_item_incnt, null, sysdate, 0/*품질*/);
        ELSIF :NEW.purchase_item_incnt < :OLD.purchase_item_incnt THEN
            -- 감소: OUT 처리
            INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
            VALUES (inventory_seq.nextval, 1/*발주*/, :NEW.purchase_no, 0/*부품*/, :NEW.parts_no, 1/*OUT*/, :OLD.purchase_item_incnt - :NEW.purchase_item_incnt, null, sysdate, 0/*품질*/);
        END IF;
    ELSIF DELETING THEN
        -- 발주, 부품 판매를 취소했으므로 다시 OUT
        DBMS_OUTPUT.PUT_LINE('purchase_item DELETE 발생' || :OLD.parts_no);
        IF :OLD.purchase_item_incnt != 0 THEN
            -- 이전 부품,부품번호의 incnt만큼 OUT
            INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
            VALUES (inventory_seq.nextval, 1/*발주*/, :OLD.purchase_no, 0/*부품*/, :OLD.parts_no, 1/*OUT*/, :OLD.purchase_item_incnt, null, sysdate, 0/*품질*/);
        END IF;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TRIGGER_ADJUST_INVENHIS
AFTER INSERT ON inventory_adjust -- 조정, 생산, 분해 INSERT
FOR EACH ROW
BEGIN
    INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
    VALUES (inventory_seq.nextval, :NEW.adjust_status, -1/*order_no없음*/, :NEW.item_status, :NEW.item_no, :NEW.inout_status, :NEW.item_cnt, null, sysdate, 0/*품질*/);
END;
/
/************************************************** 
 * FUNCTION : 함수
 **************************************************/
-- DROP
--DROP FUNCTION calc_real_inventory;
--DROP FUNCTION calc_real_inventory_all;
DROP TYPE table_calc_real_inventory;
DROP TYPE table_calc_real_inventory_all;
DROP TYPE type_calc_real_inventory;
DROP TYPE type_calc_real_inventory_all;
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
CREATE OR REPLACE TYPE type_calc_real_inventory_all AS OBJECT (
    item_status NUMBER,
    item_no NUMBER,
    cnt NUMBER
);
/
-- 객체 타입의 테이블 타입 정의 (여러 행)
CREATE OR REPLACE TYPE table_calc_real_inventory AS TABLE OF type_calc_real_inventory;
/
CREATE OR REPLACE TYPE table_calc_real_inventory_all AS TABLE OF type_calc_real_inventory_all;
/
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
create or replace FUNCTION calc_real_inventory_all
RETURN table_calc_real_inventory_all PIPELINED -- PIPELINED : 한 행씩 순차적으로 반환할 수 있게 해주는 함수로 지정
IS
    -- 속성변수
    v_inven_status NUMBER; -- 부품/제품 구분
    v_item_no NUMBER; -- 재고번호
    v_item_status VARCHAR2(255); -- 재고분류
    v_name VARCHAR2(255); -- 재고명
    v_total_cnt NUMBER; -- 총 수량
    v_inventory_cnt NUMBER; -- 기말 수량
    v_purchase_cnt NUMBER; -- 구매 수량
    v_sales_cnt NUMBER; -- 판매 수량
    v_in_cnt NUMBER; -- 조정+ 수량
    v_out_cnt NUMBER; -- 조정- 수량
    
    -- 현 재고 실수량 가져오기
    CURSOR cur_real_inventory IS
        SELECT 
            M.item_status,
            M.item_no, 
            SUM(M.cnt) AS inventory_cnt, 
            NVL(SUM(P.cnt),0) AS purchase_cnt, 
            NVL(SUM(S.cnt),0) AS sales_cnt, 
            NVL(AVG(II.cnt),0) AS item_in, 
            NVL(AVG(IO.cnt),0) AS item_out
        FROM 
            (SELECT item_status, item_no, cnt
            FROM month_inventory
            WHERE yearmonth = (SELECT MAX(yearmonth) FROM month_inventory) -- 최근 년월
            AND startend_status = 1 -- 기말재고
            ) M 
            -- 수주
            LEFT JOIN
            (SELECT 1 AS item_status, product_no AS item_no, sales_item_outcnt AS cnt FROM sales_item 
            WHERE sales_no IN ( 
                SELECT sales_no FROM sales_order WHERE out_status IN (2/*완료*/)
                )
            ) S 
            ON M.item_status = S.item_status
            AND M.item_no = S.item_no
            -- 발주
            LEFT JOIN 
            (SELECT 0 AS item_status, parts_no AS item_no, purchase_item_incnt AS cnt FROM purchase_item 
            WHERE purchase_no IN (
                SELECT purchase_no FROM purchase_order WHERE in_status IN (2/*완료*/)
                )
            ) P 
            ON M.item_status = P.item_status
            AND M.item_no = P.item_no
            -- 조정(+)
            LEFT JOIN 
            (SELECT item_status, item_no, item_cnt AS cnt FROM inventory_adjust 
            WHERE item_close_status IN (2/*완료*/)
            AND inout_status = 0/*IN*/
            ) II 
            ON M.item_status = II.item_status
            AND M.item_no = II.item_no
            -- 조정(-)
            LEFT JOIN 
            (SELECT item_status, item_no, item_cnt AS cnt FROM inventory_adjust 
            WHERE item_close_status IN (2/*완료*/)
            AND inout_status = 1/*OUT*/
            ) IO 
            ON M.item_status = IO.item_status
            AND M.item_no = IO.item_no
        GROUP BY M.item_status, M.item_no;

BEGIN
    OPEN cur_real_inventory;

    LOOP
        FETCH cur_real_inventory INTO v_item_status, v_item_no, v_inventory_cnt, v_purchase_cnt, v_sales_cnt, v_in_cnt, v_out_cnt;
        
        -- 없으면 LOOP 종료
        EXIT WHEN cur_real_inventory%NOTFOUND;
        
        PIPE ROW(type_calc_real_inventory_all(v_item_status, v_item_no, v_inventory_cnt + v_purchase_cnt - v_sales_cnt + v_in_cnt - v_out_cnt));
    END LOOP;

    RETURN;
END;
/
/************************************************** 
 * PROCEDURE : 프로시저
 **************************************************/
-- DROP PROCEDURE create_item_to_inventory;
CREATE OR REPLACE PROCEDURE create_item_to_inventory(p_yearMonth IN VARCHAR2)
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
            WHERE YEARMONTH = p_yearMonth
            AND item_no = part_rec.parts_no
            AND ITEM_STATUS = 0;

            IF v_exists > 0 THEN
                DBMS_OUTPUT.PUT_LINE('존재');
            ELSE
                DBMS_OUTPUT.PUT_LINE('미존재');
                -- INSERT
                INSERT INTO month_inventory(YEARMONTH, STARTEND_STATUS, ITEM_STATUS, ITEM_NO, CNT, IN_DATE) VALUES (p_yearMonth, 0, 0, part_rec.parts_no, 0, sysdate);
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
            WHERE YEARMONTH = p_yearMonth
            AND item_no = product_rec.product_no
            AND ITEM_STATUS = 1;

            IF v_exists > 0 THEN
                DBMS_OUTPUT.PUT_LINE('존재');
            ELSE
                DBMS_OUTPUT.PUT_LINE('미존재');
                -- INSERT
                INSERT INTO month_inventory(YEARMONTH, STARTEND_STATUS, ITEM_STATUS, ITEM_NO, CNT, IN_DATE) VALUES (p_yearMonth, 0, 1, product_rec.product_no, 0, sysdate);
            END IF;
        END;
    END LOOP;
    COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE procedure_clac_inventory_tot
IS
    -- v_totalcnt_map(item_status)(item_no)에 따른 누적합 맵
    TYPE t_totalcnt_map_of_status IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_totalcnt_map_of_status t_totalcnt_map_of_status;
    TYPE t_totalcnt_map IS TABLE OF t_totalcnt_map_of_status INDEX BY PLS_INTEGER;
    v_totalcnt_map t_totalcnt_map;
    
    -- 재고 변동 이력 시퀀스 순서대로 정렬 커서
    CURSOR cur_inven IS
        SELECT * FROM inventory
        WHERE item_totalcnt IS NULL
        ORDER BY inventory_his_no;
BEGIN
    FOR rec_inven IN cur_inven LOOP
        -- 최초 맵 초기화
        -- 맵에 item_status가 존재하는지 확인
        IF NOT v_totalcnt_map.EXISTS(rec_inven.item_status) THEN
            v_totalcnt_map(rec_inven.item_status) := v_totalcnt_map_of_status;
        END IF;
        -- 내부 맵에 item_no가 존재하는지 확인
        IF NOT v_totalcnt_map(rec_inven.item_status).EXISTS(rec_inven.item_no) THEN
            -- DB에서 가장 최근 totalcnt 가져오기
            SELECT NVL(MAX(ITEM_TOTALCNT), 0)
            INTO v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no)
            FROM inventory
            WHERE item_status = rec_inven.item_status
              AND item_no = rec_inven.item_no
              AND inventory_his_no < rec_inven.inventory_his_no;
        END IF;
        
        -- 입고 : 누적합에 더하기
        IF rec_inven.inout_status = 0 THEN
            v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no) := v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no) + rec_inven.item_cnt;
        -- 출고 : 누적합에서 빼기
        ELSIF rec_inven.inout_status = 1 THEN
            v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no) := v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no) - rec_inven.item_cnt;
        END IF;
                
        -- 계산한 누적합으로 업데이트
        UPDATE inventory
        SET ITEM_TOTALCNT = v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no)
        WHERE INVENTORY_HIS_NO = rec_inven.INVENTORY_HIS_NO;
    END LOOP;
    
    COMMIT;
END;
/
/************************************************** 
 * PACKAGE : 패키지
 **************************************************/
-- DROP PACKAGE BODY month_close;
-- DROP PACKAGE month_close;
-- 월마감 패키지
CREATE OR REPLACE PACKAGE month_close AS
    g_in_empno emp.emp_no%TYPE := '1001';
    g_prod_cnt NUMBER(9) := 0;
    
    -- 월마감0 : 메인
    PROCEDURE month_close_main(
    p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2, p_real in VARCHAR2, 
    p_result OUT VARCHAR2);
    
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
    PROCEDURE month_close_end (p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2, p_real in VARCHAR2);
END;
-- PACKAGE와 PACKAGE BODY 구분
/
CREATE OR REPLACE PACKAGE BODY month_close AS
    PROCEDURE month_close_main(
    p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2, p_real in VARCHAR2, 
    p_result OUT VARCHAR2) 
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
        month_close_end(p_sum_yymm, p_regi_emp_no, p_real);
        
        p_result := 'true';
        COMMIT;
        
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                p_result := 'false';
                
                DECLARE
                    v_code VARCHAR2(4000) := SQLCODE;
                    v_msg  VARCHAR2(4000) := SQLERRM;
                BEGIN
                    INSERT INTO error_log(error_no,error_code,error_coment,error_date)
                    VALUES (error_log_seq.NEXTVAL,
                        v_code,
                        v_msg,
                        sysdate
                    );
                END;
                
                RAISE;
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
        
        COMMIT;
        
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
        AND startend_status = '1';
        -- 지난달 기말재고 복사하여 이번달 기초재고 등록
        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('복사시작');
            INSERT INTO month_inventory(YEARMONTH,STARTEND_STATUS,ITEM_STATUS,ITEM_NO,CNT,IN_DATE)
            SELECT p_sum_yymm,'0'/*기초*/,ITEM_STATUS,ITEM_NO,CNT,SYSDATE 
            FROM     month_inventory
            WHERE    YEARMONTH  = TO_CHAR(ADD_MONTHS (TO_DATE(p_sum_yymm,'YYMM'),-1),'YYMM')
            AND      startend_status = '1' -- 기말
            ;
            DBMS_OUTPUT.PUT_LINE('복사끝');
        -- 지난달 기말재고 없음
        ELSE
            DBMS_OUTPUT.PUT_LINE('지난달 기말 재고가 존재하지 않습니다.');
        END IF;
        
        dbms_output.put_line('신규 재고 등록');
        create_item_to_inventory(p_sum_yymm);
        
        COMMIT;
        
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
        SELECT 
            M.yearmonth,
            M.item_status,
            M.item_no, 
            SUM(M.cnt) AS inventory_cnt, 
            -- 도건 연구 필요1 : JOIN 중 항목 개수가 많아지면 값이 이상해짐...
            NVL(SUM(P.purchase_item_cnt),0) AS purchase_cnt, -- 도건 연구 필요1
            NVL(SUM(S.sales_item_cnt),0) AS sales_cnt, -- 도건 연구 필요1
            NVL(AVG(II.item_in),0) AS item_in, -- 도건 연구 필요1
            NVL(AVG(IO.item_out),0) AS item_out -- 도건 연구 필요1
        FROM (SELECT yearmonth, item_status, item_no, cnt FROM month_inventory 
            WHERE    yearmonth = p_sum_yymm
            AND      startend_status = '0' -- 기초 재고에 한해
        ) M -- 월재고
        LEFT JOIN
        -- 부품 구매 내역
        (SELECT 0 AS item_status, parts_no AS item_no, PURCHASE_ITEM_CNT FROM purchase_item 
        WHERE purchase_no IN (
            SELECT purchase_no FROM purchase_order 
            WHERE TO_CHAR(purchase_date, 'YYMM') = p_sum_yymm
            AND in_status IN (2,3) -- 완료, 마감
            )
        ) P -- 구매 실적
        ON M.item_status = P.item_status
        AND M.item_no = P.item_no
        LEFT JOIN
        -- 제품 판매 내역
        (SELECT 1 AS item_status, product_no AS item_no, sales_item_cnt FROM sales_item
        WHERE sales_no IN (
            SELECT sales_no FROM sales_order
            WHERE TO_CHAR(sales_date, 'YYMM') = p_sum_yymm
            AND out_status IN (2,3) -- 완료, 마감
            )
        ) S
        ON M.item_status = S.item_status
        AND M.item_no = S.item_no
        LEFT JOIN
        -- 재고 조정IN 내역(제조, 분해, 조정)
        (SELECT item_status, item_no, SUM(item_cnt)/* 도건 연구 필요1 */ AS item_in FROM inventory_adjust
        WHERE TO_CHAR(inout_date, 'YYMM') = p_sum_yymm
        AND item_close_status IN (2,3) -- 완료, 마감
        AND inout_status = 0 -- IN
        GROUP BY item_status, item_no
        ) II
        ON M.item_status = II.item_status
        AND M.item_no = II.item_no
        LEFT JOIN
        -- 재고 조정OUT 내역(제조, 분해, 조정)
        (SELECT item_status, item_no, SUM(item_cnt)/* 도건 연구 필요1 */ AS item_out FROM inventory_adjust
        WHERE TO_CHAR(inout_date, 'YYMM') = p_sum_yymm
        AND item_close_status IN (2,3) -- 완료, 마감
        AND inout_status = 1 -- OUT
        GROUP BY item_status, item_no
        ) IO
        ON M.item_status = IO.item_status
        AND M.item_no = IO.item_no
        GROUP BY M.yearmonth,M.item_status,M.item_no;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_prc2 START p_sum_yymm ' || p_sum_yymm);
        
        -- 이번달 발주, 수주, (폐기), (생산) 반영 하기
        FOR rec_close_clac IN cur_close_clac LOOP
            -- 수량 계산
            DECLARE
                v_cnt VARCHAR2(4000) := rec_close_clac.inventory_cnt; -- 기초 재고
            BEGIN
                v_cnt := v_cnt + rec_close_clac.purchase_cnt; -- 구매
                v_cnt := v_cnt - rec_close_clac.sales_cnt; -- 판매
                v_cnt := v_cnt + rec_close_clac.item_in; -- 조정(+)
                v_cnt := v_cnt - rec_close_clac.item_out; -- 조정(-)
                
                IF rec_close_clac.item_no = 8 THEN
                    dbms_output.put_line(rec_close_clac.item_status || '/' || rec_close_clac.item_no || ' : ' || v_cnt);
                    dbms_output.put_line('rec_close_clac.purchase_cnt : ' || rec_close_clac.purchase_cnt);
                    dbms_output.put_line('rec_close_clac.sales_cnt : ' || rec_close_clac.sales_cnt);
                    dbms_output.put_line('rec_close_clac.item_in : ' || rec_close_clac.item_in);
                    dbms_output.put_line('rec_close_clac.item_out : ' || rec_close_clac.item_out);
                END IF;
                ------------------------------------------------------------------
                --    만약 창고 기초재고가 판매량보다 크다면 기말재고 입력 
                ------------------------------------------------------------------
                IF v_cnt >= 0 THEN  
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
                        , v_cnt
                        , SYSDATE
                    );
                ELSE
                    --부족한 개수
                    g_prod_cnt := -v_cnt;
                    --에러 기록
                    INSERT INTO error_log(error_no, error_code, error_coment, error_date) VALUES(error_log_seq.nextval, 
                    'ERR-1001 : month_close.month_close_prc2', 
                    '월마감 진행중 ' || rec_close_clac.yearmonth || '에 ' || rec_close_clac.item_status || '(부품/제품):' || rec_close_clac.item_no || '재고 ' ||  g_prod_cnt || '개수 부족', 
                    sysdate);
                END IF;
            END;
        END LOOP;
        
        COMMIT;
        
        dbms_output.put_line('month_close_prc2 END');
        EXCEPTION
            WHEN OTHERS THEN
                DECLARE
                    v_code VARCHAR2(4000) := SQLCODE;
                    v_msg  VARCHAR2(4000) := SQLERRM;
                BEGIN
                    INSERT INTO error_log(error_no,error_code,error_coment,error_date)
                    VALUES (error_log_seq.NEXTVAL,
                        v_code,
                        v_msg,
                        sysdate
                    );
                END;
    END;
    
    /***************************************************************************
    Procedure Name : month_close_end
    Description    : 수불마감 끝 이력 등록
    ***************************************************************************/
    PROCEDURE month_close_end(p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2, p_real in VARCHAR2)
    IS
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_end START p_sum_yymm/p_regi_emp_no ' || p_sum_yymm || '/' || p_regi_emp_no);
        
        -- 수주 테이블 완료 -> 마감 처리
        UPDATE sales_order SET out_status = 3
        WHERE out_status = 2
        AND TO_CHAR(in_date, 'YYMM') = p_sum_yymm;
        -- 발주 테이블 완료 -> 마감 처리
        UPDATE purchase_order SET in_status = 3
        WHERE in_status = 2
        AND TO_CHAR(in_date, 'YYMM') = p_sum_yymm;
        -- 조정 테이블 완료 -> 마감 처리
        UPDATE inventory_adjust SET item_close_status = 3
        WHERE item_close_status = 2
        AND TO_CHAR(inout_date, 'YYMM') = p_sum_yymm;
        
        -- 수불마감 끝 이력 등록
        UPDATE inventory_close SET CLOSE_STATUS = p_real, CLOSE_ENDDATE = sysdate
        WHERE yearmonth = p_sum_yymm;
        
        COMMIT;
        
        dbms_output.put_line('month_close_end END');
    END;
END;
/