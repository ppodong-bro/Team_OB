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
 *  SEQUENCE : ������
 **************************************************/
-- ���(EMP) ������
DROP SEQUENCE EMP_NO_SEQ;
CREATE SEQUENCE EMP_NO_SEQ
START WITH 1001 -- ���� ����
INCREMENT BY 1   -- ���� ��
NOCACHE         -- ĳ�� ��� �� ��
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

-- �μ�(DEPT) ������
DROP SEQUENCE DEPT_CODE_SEQ;
CREATE SEQUENCE DEPT_CODE_SEQ
START WITH 1001 -- ���� ����
INCREMENT BY 1   -- ���� ��
NOCACHE         -- ĳ�� ��� �� ��
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

-- �Խ���(BOARD) ������
DROP SEQUENCE BOARD_NO_SEQ;
CREATE SEQUENCE BOARD_NO_SEQ
START WITH 1 -- ���� ����
INCREMENT BY 1   -- ���� ��
NOCACHE         -- ĳ�� ��� �� ��
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

-- ����(ERROR_LOG) ������
DROP SEQUENCE ERROR_LOG_SEQ;
CREATE SEQUENCE ERROR_LOG_SEQ
START WITH 1 -- ���� ����
INCREMENT BY 1 -- ������
NOCACHE -- ĳ�� �� �� (�ɼ�)
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

-- ���(INVENTORY) ������
DROP SEQUENCE INVENTORY_SEQ;
CREATE SEQUENCE INVENTORY_SEQ
START WITH 1 -- ���� ����
INCREMENT BY 1 -- ������
NOCACHE -- ĳ�� �� �� (�ɼ�)
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

-- ���(INVENTORY) ������
DROP SEQUENCE INVENTORY_ADJUST_SEQ;
CREATE SEQUENCE INVENTORY_ADJUST_SEQ
START WITH 1 -- ���� ����
INCREMENT BY 1 -- ������
NOCACHE -- ĳ�� �� �� (�ɼ�)
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

-- ��ǰ���ݺ����̷�(PRODUCT_PRICE_his) ������
DROP SEQUENCE PRODUCT_PRICE_his_SEQ;
CREATE SEQUENCE PRODUCT_PRICE_his_SEQ
START WITH 1 -- ���� ����
INCREMENT BY 1 -- ������
NOCACHE -- ĳ�� �� �� (�ɼ�)
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

-- ��ǰ���ݺ����̷�(PARTS_PRICE_HIS) ������
DROP SEQUENCE PARTS_PRICE_his_SEQ;
CREATE SEQUENCE PARTS_PRICE_his_SEQ
START WITH 1 -- ���� ����
INCREMENT BY 1 -- ������
NOCACHE -- ĳ�� �� �� (�ɼ�)
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

-- ��ǰ(PARTS) ������
DROP SEQUENCE PARTS_SEQ;
CREATE SEQUENCE PARTS_SEQ
START WITH 1 -- ���� ����
INCREMENT BY 1 -- ������
NOCACHE -- ĳ�� �� �� (�ɼ�)
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����

--  ��ǰ(PRODUCT) ������
DROP SEQUENCE PRODUCT_SEQ;
CREATE SEQUENCE PRODUCT_SEQ
START WITH 1 -- ���� ����
INCREMENT BY 1 -- ������
NOCACHE -- ĳ�� �� �� (�ɼ�)
NOCYCLE; -- ������ �� ���� �ٽ� 1�� ���ư��� ����


/************************************************** 
 *  CREATE TABLE
 **************************************************/
 
/* ��ǰ ***********************************************************************/
CREATE TABLE product (
	product_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	product_status NUMBER(1), /* �з���ȣ */
	product_name VARCHAR2(100), /* ��ǰ�� */
	product_context VARCHAR2(1000), /* ��ǰ���� */
	filename VARCHAR2(1000), /* ���� */
	del_status NUMBER(1), /* �������� */
	emp_no NUMBER(7), /* �����ȣ */
	in_date TIMESTAMP /* ������� */
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

COMMENT ON TABLE product IS '��ǰ';

COMMENT ON COLUMN product.product_no IS '��ǰ��ȣ';

COMMENT ON COLUMN product.product_status IS '�з���ȣ';

COMMENT ON COLUMN product.product_name IS '��ǰ��';

COMMENT ON COLUMN product.product_context IS '��ǰ����';

COMMENT ON COLUMN product.filename IS '����';

COMMENT ON COLUMN product.del_status IS '��������';

COMMENT ON COLUMN product.emp_no IS '�����ȣ';

COMMENT ON COLUMN product.in_date IS '�������';

/* ��ǰ_BOM *******************************************************************/
CREATE TABLE product_BOM (
	product_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	parts_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	cnt NUMBER(10) /* ��ǰ���� */
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

COMMENT ON TABLE product_BOM IS '��ǰ_BOM';

COMMENT ON COLUMN product_BOM.product_no IS '��ǰ��ȣ';

COMMENT ON COLUMN product_BOM.parts_no IS '��ǰ��ȣ';

COMMENT ON COLUMN product_BOM.cnt IS '��ǰ����';

/* ��ǰ ***********************************************************************/
CREATE TABLE parts (
	parts_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	parts_status NUMBER(1), /* �з���ȣ */
	parts_name VARCHAR2(100), /* ��ǰ�� */
	parts_context VARCHAR2(1000), /* ��ǰ���� */
	manufacture VARCHAR2(100), /* ������ */
	filename VARCHAR2(1000), /* ���� */
	del_status NUMBER(1), /* �������� */
	emp_no NUMBER(7), /* �����ȣ */
	in_date DATE /* ������� */
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

COMMENT ON TABLE parts IS '��ǰ';

COMMENT ON COLUMN parts.parts_no IS '��ǰ��ȣ';

COMMENT ON COLUMN parts.parts_status IS '�з���ȣ';

COMMENT ON COLUMN parts.parts_name IS '��ǰ��';

COMMENT ON COLUMN parts.parts_context IS '��ǰ����';

COMMENT ON COLUMN parts.manufacture IS '������';

COMMENT ON COLUMN parts.filename IS '����';

COMMENT ON COLUMN parts.del_status IS '��������';

COMMENT ON COLUMN parts.emp_no IS '�����ȣ';

COMMENT ON COLUMN parts.in_date IS '�������';

/* ���� ***********************************************************************/
CREATE TABLE error_log (
	error_no NUMBER(7) NOT NULL, /* ���� ��ȣ */
	error_code VARCHAR2(4000), /* ���� �ڵ� */
	error_coment VARCHAR2(4000), /* ���� ���� */
	error_date DATE NOT NULL /* ���� �Ͻ� */
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

COMMENT ON TABLE error_log IS '����';

COMMENT ON COLUMN error_log.error_no IS '���� ��ȣ';

COMMENT ON COLUMN error_log.error_code IS '���� �ڵ�';

COMMENT ON COLUMN error_log.error_coment IS '���� ����';

COMMENT ON COLUMN error_log.error_date IS '���� �Ͻ�';

/* ��� ***********************************************************************/
CREATE TABLE inventory (
	inventory_his_no NUMBER(7) NOT NULL, /* ������̷¹�ȣ */
	order_status NUMBER(1) NOT NULL, /* ����/���� ���� */
	order_no NUMBER(7) NOT NULL, /* ����/���ֹ�ȣ */
	item_status NUMBER(1) NOT NULL, /* ��ǰ/��ǰ ���� */
	item_no NUMBER(7) NOT NULL, /* ��ǰ/��ǰ��ȣ */
	inout_status NUMBER(1) NOT NULL, /* ��/��� ���� */
	inout_date DATE NOT NULL, /* ��/����Ͻ� */
	item_cnt NUMBER(10), /* ���� ���� */
	item_totalcnt NUMBER(10), /* �� ���� */
	item_quality NUMBER(1) /* ǰ�� */
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

COMMENT ON TABLE inventory IS '���';

COMMENT ON COLUMN inventory.inventory_his_no IS '������̷¹�ȣ';

COMMENT ON COLUMN inventory.order_status IS '����/���� ����';

COMMENT ON COLUMN inventory.order_no IS '����/���ֹ�ȣ';

COMMENT ON COLUMN inventory.item_status IS '��ǰ/��ǰ ����';

COMMENT ON COLUMN inventory.item_no IS '��ǰ/��ǰ��ȣ';

COMMENT ON COLUMN inventory.inout_status IS '��/��� ����';

COMMENT ON COLUMN inventory.inout_date IS '��/����Ͻ�';

COMMENT ON COLUMN inventory.item_cnt IS '���� ����';

COMMENT ON COLUMN inventory.item_totalcnt IS '�� ����';

COMMENT ON COLUMN inventory.item_quality IS 'ǰ��';

/* ��� ���� ***********************************************************************/
CREATE TABLE inventory_adjust (
	inventory_adjust_no NUMBER(7) NOT NULL, /* ���������ȣ */
	adjust_status NUMBER(1) NOT NULL, /* ���� ���� */
	item_status NUMBER(1) NOT NULL, /* ��ǰ/��ǰ ���� */
	item_no NUMBER(7) NOT NULL, /* ��ǰ/��ǰ��ȣ */
	inout_status NUMBER(1) NOT NULL, /* ��/��� ���� */
	item_cnt NUMBER(10), /* ���� ���� */
	inout_date DATE NOT NULL, /* ��/����Ͻ� */
    item_close_status NUMBER(1) NOT NULL /* ���� ���� */
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

COMMENT ON TABLE inventory_adjust IS '��� ����';

COMMENT ON COLUMN inventory_adjust.inventory_adjust_no IS '���������ȣ';

COMMENT ON COLUMN inventory_adjust.adjust_status IS '���� ����';

COMMENT ON COLUMN inventory_adjust.item_status IS '��ǰ/��ǰ ����';

COMMENT ON COLUMN inventory_adjust.item_no IS '��ǰ/��ǰ��ȣ';

COMMENT ON COLUMN inventory_adjust.inout_status IS '��/��� ����';

COMMENT ON COLUMN inventory_adjust.item_cnt IS '���� ����';

COMMENT ON COLUMN inventory_adjust.inout_date IS '��/����Ͻ�';

COMMENT ON COLUMN inventory_adjust.item_close_status IS '���� ����';

/* �� ��� ********************************************************************/
CREATE TABLE month_inventory (
	yearmonth VARCHAR2(4) NOT NULL, /* ��� */
	startend_status NUMBER(1) NOT NULL, /* ����/�⸻ ���� */
	item_status NUMBER(1) NOT NULL, /* ��ǰ/��ǰ ���� */
	item_no NUMBER(7) NOT NULL, /* ��ǰ/��ǰ��ȣ */
	cnt NUMBER(10), /* ���� */
	in_date DATE /* ������� */
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

COMMENT ON TABLE month_inventory IS '�� ���';

COMMENT ON COLUMN month_inventory.yearmonth IS '���';

COMMENT ON COLUMN month_inventory.startend_status IS '����/�⸻ ����';

COMMENT ON COLUMN month_inventory.item_status IS '��ǰ/��ǰ ����';

COMMENT ON COLUMN month_inventory.item_no IS '��ǰ/��ǰ��ȣ';

COMMENT ON COLUMN month_inventory.cnt IS '����';

COMMENT ON COLUMN month_inventory.in_date IS '�������';

/* ��ǰ���ݺ����̷� ***********************************************************/
CREATE TABLE product_costhis (
	product_costhis_no NUMBER(7) NOT NULL, /* ��ǰ���ݺ����̷� */
	product_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	start_date DATE NOT NULL, /* �������� */
	end_date DATE, /* �������� */
	price NUMBER(19) /* ���� */
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

COMMENT ON TABLE product_costhis IS '��ǰ���ݺ����̷�';

COMMENT ON COLUMN product_costhis.product_costhis_no IS '��ǰ���ݺ����̷�';

COMMENT ON COLUMN product_costhis.product_no IS '��ǰ��ȣ';

COMMENT ON COLUMN product_costhis.start_date IS '��������';

COMMENT ON COLUMN product_costhis.end_date IS '��������';

COMMENT ON COLUMN product_costhis.price IS '����';

/* ������� *******************************************************************/
CREATE TABLE sales_perform (
	yearmonth VARCHAR2(4) NOT NULL, /* ��� */
	product_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	cnt NUMBER(10), /* ���� */
	total NUMBER(19) /* �Ѿ� */
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

COMMENT ON TABLE sales_perform IS '�������';

COMMENT ON COLUMN sales_perform.yearmonth IS '���';

COMMENT ON COLUMN sales_perform.product_no IS '��ǰ��ȣ';

COMMENT ON COLUMN sales_perform.cnt IS '����';

COMMENT ON COLUMN sales_perform.total IS '�Ѿ�';

/* ���� ***********************************************************************/
CREATE TABLE SALES_ORDER (
	sales_no NUMBER(7) NOT NULL, /* ���ֹ�ȣ */
	client_no NUMBER(7), /* �ŷ�ó��ȣ */
    emp_no NUMBER(7), /* �����ȣ */
	sales_date DATE, /* ����Ϸ��� */
	out_status NUMBER(1), /* ������ */
	del_status NUMBER(1), /* �������� */
	in_date DATE /* ����Ͻ� */
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

COMMENT ON TABLE SALES_ORDER IS '����';

COMMENT ON COLUMN SALES_ORDER.sales_no IS '���ֹ�ȣ';

COMMENT ON COLUMN SALES_ORDER.client_no IS '�ŷ�ó��ȣ';

COMMENT ON COLUMN SALES_ORDER.emp_no IS '�����ȣ';

COMMENT ON COLUMN SALES_ORDER.sales_date IS '����Ϸ���';

COMMENT ON COLUMN SALES_ORDER.out_status IS '������';

COMMENT ON COLUMN SALES_ORDER.del_status IS '��������';

COMMENT ON COLUMN SALES_ORDER.in_date IS '����Ͻ�';

/* ���� ***********************************************************************/
CREATE TABLE PURCHASE_ORDER (
	purchase_no NUMBER(7) NOT NULL, /* ���ֹ�ȣ */
	client_no NUMBER(7), /* �ŷ�ó��ȣ */
	emp_no NUMBER(7), /* �����ȣ */
	purchase_date DATE, /* ����Ϸ��� */
	in_status NUMBER(1), /* �԰���� */
	del_status NUMBER(1), /* �������� */
	in_date DATE /* ����Ͻ� */
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

COMMENT ON TABLE PURCHASE_ORDER IS '����';

COMMENT ON COLUMN PURCHASE_ORDER.purchase_no IS '���ֹ�ȣ';

COMMENT ON COLUMN PURCHASE_ORDER.client_no IS '�ŷ�ó��ȣ';

COMMENT ON COLUMN PURCHASE_ORDER.emp_no IS '�����ȣ';

COMMENT ON COLUMN PURCHASE_ORDER.purchase_date IS '����Ϸ���';

COMMENT ON COLUMN PURCHASE_ORDER.in_status IS '�԰����';

COMMENT ON COLUMN PURCHASE_ORDER.del_status IS '��������';

COMMENT ON COLUMN PURCHASE_ORDER.in_date IS '����Ͻ�';

/* �ŷ�ó *********************************************************************/
CREATE TABLE client (
	client_no NUMBER(7) NOT NULL, /* �ŷ�ó��ȣ */
	emp_no NUMBER(7), /* �����ȣ */
	client_name VARCHAR2(100), /* �ŷ�ó�� */
	client_gubun NUMBER(1), /* �ŷ�ó���� */
	client_email VARCHAR2(100), /* �ŷ�ó�̸��� */
    client_tel VARCHAR2(13), /* �ŷ�ó��ȭ��ȣ */
	client_man VARCHAR2(100), /* �ŷ�ó����ڸ� */
	client_address VARCHAR2(100), /* �ŷ�ó�ּ� */
	del_status NUMBER(1), /* �������� */
	modify_date DATE, /* �������� */
	in_date DATE /* ������� */
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

COMMENT ON TABLE client IS '�ŷ�ó';

COMMENT ON COLUMN client.client_no IS '�ŷ�ó��ȣ';

COMMENT ON COLUMN client.emp_no IS '�����ȣ';

COMMENT ON COLUMN client.client_name IS '�ŷ�ó��';

COMMENT ON COLUMN client.client_gubun IS '�ŷ�ó����';

COMMENT ON COLUMN client.client_email IS '�ŷ�ó�̸���';

COMMENT ON COLUMN client.client_tel IS '�ŷ�ó��ȭ��ȣ';

COMMENT ON COLUMN client.client_man IS '�ŷ�ó����ڸ�';

COMMENT ON COLUMN client.client_address IS '�ŷ�ó�ּ�';

COMMENT ON COLUMN client.del_status IS '��������';

COMMENT ON COLUMN client.modify_date IS '��������';

COMMENT ON COLUMN client.in_date IS '�������';

/* ���� ��ǰ ******************************************************************/
CREATE TABLE SALES_ITEM (
	sales_no NUMBER(7) NOT NULL, /* ���ֹ�ȣ */
	product_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	sales_item_cnt NUMBER(10), /* ��û���� */
	sales_item_outcnt NUMBER(10), /* ������ */
	sales_item_cost NUMBER(10) /* �ܰ� */
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

COMMENT ON TABLE SALES_ITEM IS '���� ��ǰ';

COMMENT ON COLUMN SALES_ITEM.sales_no IS '���ֹ�ȣ';

COMMENT ON COLUMN SALES_ITEM.product_no IS '��ǰ��ȣ';

COMMENT ON COLUMN SALES_ITEM.sales_item_cnt IS '��û����';

COMMENT ON COLUMN SALES_ITEM.sales_item_outcnt IS '������';

COMMENT ON COLUMN SALES_ITEM.sales_item_cost IS '�ܰ�';

/* ���� ��ǰ */
CREATE TABLE PURCHASE_ITEM (
	purchase_no NUMBER(7) NOT NULL, /* ���ֹ�ȣ */
	parts_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	purchase_item_cnt NUMBER(10), /* ��û���� */
	purchase_item_incnt NUMBER(10), /* �԰���� */
	purchase_item_cost NUMBER(10) /* �ܰ� */
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

COMMENT ON TABLE PURCHASE_ITEM IS '���� ��ǰ';

COMMENT ON COLUMN PURCHASE_ITEM.purchase_no IS '���ֹ�ȣ';

COMMENT ON COLUMN PURCHASE_ITEM.parts_no IS '��ǰ��ȣ';

COMMENT ON COLUMN PURCHASE_ITEM.purchase_item_cnt IS '��û����';

COMMENT ON COLUMN PURCHASE_ITEM.purchase_item_incnt IS '�԰����';

COMMENT ON COLUMN PURCHASE_ITEM.purchase_item_cost IS '�ܰ�';

/* ���� ***********************************************************************/
CREATE TABLE common (
	big_status NUMBER(4) NOT NULL, /* ��з� */
	middle_status NUMBER(4) NOT NULL, /* �ߺз� */
	context VARCHAR2(100) /* ���� */
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

COMMENT ON TABLE common IS '����';

COMMENT ON COLUMN common.big_status IS '��з�';

COMMENT ON COLUMN common.middle_status IS '�ߺз�';

COMMENT ON COLUMN common.context IS '����';

/* ��ǰ���ݺ����̷� ***********************************************************/
CREATE TABLE parts_costhis (
	parts_costhis_no NUMBER(7) NOT NULL, /* ��ǰ���ݺ����̷¹�ȣ */
	parts_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	start_date DATE NOT NULL, /* �������� */
	end_date DATE, /* �������� */
	price NUMBER(19) /* ���� */
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

COMMENT ON TABLE parts_costhis IS '��ǰ���ݺ����̷�';

COMMENT ON COLUMN parts_costhis.parts_costhis_no IS '��ǰ���ݺ����̷¹�ȣ';

COMMENT ON COLUMN parts_costhis.parts_no IS '��ǰ��ȣ';

COMMENT ON COLUMN parts_costhis.start_date IS '��������';

COMMENT ON COLUMN parts_costhis.end_date IS '��������';

COMMENT ON COLUMN parts_costhis.price IS '����';

/* ���Խ��� *******************************************************************/
CREATE TABLE purchase_perform (
	yearmonth VARCHAR2(4) NOT NULL, /* ��� */
	parts_no NUMBER(7) NOT NULL, /* ��ǰ��ȣ */
	cnt NUMBER(10), /* ���� */
	total NUMBER(19) /* �Ѿ� */
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

COMMENT ON TABLE purchase_perform IS '���Խ���';

COMMENT ON COLUMN purchase_perform.yearmonth IS '���';

COMMENT ON COLUMN purchase_perform.parts_no IS '��ǰ��ȣ';

COMMENT ON COLUMN purchase_perform.cnt IS '����';

COMMENT ON COLUMN purchase_perform.total IS '�Ѿ�';

/* �ŷ�ó�� ���� **************************************************************/
CREATE TABLE Client_perform (
	yearmonth VARCHAR2(4) NOT NULL, /* ��� */
	client_no NUMBER(7) NOT NULL, /* �ŷ�ó��ȣ */
	cnt NUMBER(10), /* �Ǽ� */
	total_amt NUMBER(19) /* �Ѿ� */
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

COMMENT ON TABLE Client_perform IS '�ŷ�ó�� ����';

COMMENT ON COLUMN Client_perform.yearmonth IS '���';

COMMENT ON COLUMN Client_perform.client_no IS '�ŷ�ó��ȣ';

COMMENT ON COLUMN Client_perform.cnt IS '�Ǽ�';

COMMENT ON COLUMN Client_perform.total_amt IS '�Ѿ�';

/* ���Ҹ��� *******************************************************************/
CREATE TABLE inventory_close (
	yearmonth VARCHAR2(4) NOT NULL, /* ��� */
	close_status NUMBER(1), /* �����ϷῩ�� */
	close_startdate DATE, /* ���������Ͻ� */
	close_enddate DATE, /* ���������Ͻ� */
	emp_no NUMBER(7) /* ����ó������� */
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

COMMENT ON TABLE inventory_close IS '���Ҹ���';

COMMENT ON COLUMN inventory_close.yearmonth IS '���';

COMMENT ON COLUMN inventory_close.close_status IS '�����ϷῩ��';

COMMENT ON COLUMN inventory_close.close_startdate IS '���������Ͻ�';

COMMENT ON COLUMN inventory_close.close_enddate IS '���������Ͻ�';

COMMENT ON COLUMN inventory_close.emp_no IS '����ó�������';

/* �ŷ�ó �̷� ****************************************************************/
CREATE TABLE client_HIS (
	client_no NUMBER(7) NOT NULL, /* �ŷ�ó��ȣ */
	start_date VARCHAR2(8) NOT NULL, /* �������� */
	end_date VARCHAR2(8) NOT NULL, /* �������� */
	emp_no NUMBER(7), /* �����ȣ */
	client_name VARCHAR2(100), /* �ŷ�ó�� */
	client_gubun NUMBER(1), /* �ŷ�ó���� */
    client_man VARCHAR2(100), /* �ŷ�ó����ڸ� */
	client_email VARCHAR2(100), /* �ŷ�ó�̸��� */
    client_tel VARCHAR2(13), /* �ŷ�ó��ȭ��ȣ */
	client_address VARCHAR2(100), /* �ŷ�ó�ּ� */
	in_date DATE /* ������� */
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

COMMENT ON TABLE client_HIS IS '�ŷ�ó �̷�';

COMMENT ON COLUMN client_HIS.client_no IS '�ŷ�ó��ȣ';

COMMENT ON COLUMN client_HIS.start_date IS '��������';

COMMENT ON COLUMN client_HIS.end_date IS '��������';

COMMENT ON COLUMN client_HIS.emp_no IS '�����ȣ';

COMMENT ON COLUMN client_HIS.client_name IS '�ŷ�ó��';

COMMENT ON COLUMN client_HIS.client_gubun IS '�ŷ�ó����';

COMMENT ON COLUMN client.client_man IS '�ŷ�ó����ڸ�';

COMMENT ON COLUMN client_HIS.client_email IS '�ŷ�ó�̸���';

COMMENT ON COLUMN client_HIS.client_tel IS '�ŷ�ó��ȭ��ȣ';

COMMENT ON COLUMN client_HIS.client_address IS '�ŷ�ó�ּ�';

COMMENT ON COLUMN client_HIS.in_date IS '�������';

/* ��� ***********************************************************************/
CREATE TABLE emp (
	emp_no NUMBER(7) NOT NULL, /* �����ȣ */
	emp_name VARCHAR2(100), /* ����� */
	emp_tel VARCHAR2(13), /* ��ȭ��ȣ */
	email VARCHAR2(50), /* e-Mail */
	sal NUMBER(10), /* �޿� */
	dept_code NUMBER(4), /* �μ���ȣ */
	username VARCHAR2(100), /* ������̵� */
	password VARCHAR2(1000), /* �����й�ȣ */
	roles_status VARCHAR2(20), /* ���ѱ��� */
	del_status NUMBER(1), /* �������� */
	registrar NUMBER(7), /* ����� */
	in_date DATE /* ������� */
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

COMMENT ON TABLE emp IS '���';

COMMENT ON COLUMN emp.emp_no IS '�����ȣ';

COMMENT ON COLUMN emp.emp_name IS '�����';

COMMENT ON COLUMN emp.emp_tel IS '��ȭ��ȣ';

COMMENT ON COLUMN emp.email IS 'e-Mail';

COMMENT ON COLUMN emp.sal IS '�޿�';

COMMENT ON COLUMN emp.dept_code IS '�μ���ȣ';

COMMENT ON COLUMN emp.username IS '������̵�';

COMMENT ON COLUMN emp.password IS '�����й�ȣ';

COMMENT ON COLUMN emp.roles_status IS '���ѱ���';

COMMENT ON COLUMN emp.del_status IS '��������';

COMMENT ON COLUMN emp.registrar IS '�����';

COMMENT ON COLUMN emp.in_date IS '�������';

/* �Խ��� *********************************************************************/
CREATE TABLE board (
	board_no NUMBER(7) NOT NULL, /* �Խ��ǹ�ȣ */
	emp_no NUMBER(7), /* �����ȣ */
	title VARCHAR2(100), /* �Խ������� */
	content VARCHAR2(1000), /* �Խ��ǳ��� */
	read_count NUMBER(7), /* ��ȸ�� */
	ref NUMBER(7), /* ref */
	re_lvl NUMBER(2), /* re_lvl */
	re_step NUMBER(7), /* re_step */
	in_date DATE /* ����Ͻ� */
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

COMMENT ON TABLE board IS '�Խ���';

COMMENT ON COLUMN board.board_no IS '�Խ��ǹ�ȣ';

COMMENT ON COLUMN board.emp_no IS '�����ȣ';

COMMENT ON COLUMN board.title IS '�Խ�������';

COMMENT ON COLUMN board.content IS '�Խ��ǳ���';

COMMENT ON COLUMN board.read_count IS '��ȸ��';

COMMENT ON COLUMN board.ref IS 'ref';

COMMENT ON COLUMN board.re_lvl IS 're_lvl';

COMMENT ON COLUMN board.re_step IS 're_step';

COMMENT ON COLUMN board.in_date IS '����Ͻ�';

/* �μ� ***********************************************************************/
CREATE TABLE dept (
	dept_code NUMBER(4) NOT NULL, /* �μ���ȣ */
	dept_name VARCHAR2(100), /* �μ��� */
	dept_captain NUMBER(7), /* �μ��� */
	parent_dept_code NUMBER(4), /* �����μ��ڵ� */
	dept_loc VARCHAR2(100), /* ��ġ */
    loc_detail VARCHAR2(50), /* ��ġ�� */
	del_status NUMBER(1), /* �������� */
	registrar NUMBER(7), /* ����� */
	in_date DATE /* ������� */
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

COMMENT ON TABLE dept IS '�μ�';

COMMENT ON COLUMN dept.dept_code IS '�μ���ȣ';

COMMENT ON COLUMN dept.dept_name IS '�μ���';

COMMENT ON COLUMN dept.dept_captain IS '�μ���';

COMMENT ON COLUMN dept.parent_dept_code IS '�����μ��ڵ�';

COMMENT ON COLUMN dept.dept_loc IS '��ġ';

COMMENT ON COLUMN dept.loc_detail IS '��ġ��';

COMMENT ON COLUMN dept.del_status IS '��������';

COMMENT ON COLUMN dept.registrar IS '�����';

COMMENT ON COLUMN dept.in_date IS '�������';

/* ��� ���� ******************************************************************/
CREATE TABLE emp_image (
	emp_no NUMBER(7) NOT NULL, /* �����ȣ */
	order_num NUMBER(1) NOT NULL, /* ������ȣ */
	emp_filename VARCHAR2(500) /* ���� */
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

COMMENT ON TABLE emp_image IS '��� ����';

COMMENT ON COLUMN emp_image.emp_no IS '�����ȣ';

COMMENT ON COLUMN emp_image.order_num IS '������ȣ';

COMMENT ON COLUMN emp_image.emp_filename IS '����';

/* ���̺���� ******************************************************************/
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
 * TRIGGER : Ʈ����
 **************************************************/
-- DROP : ���� ���̺� ������ Ʈ���ŵ� �Բ� �����Ǿ� ���� ���ʿ�
-- DROP TRIGGER TRIGGER_SALES_INVENHIS;
-- DROP TRIGGER TRIGGER_PURCHASE_INVENHIS;
/
-- inventory Ʈ����
CREATE OR REPLACE TRIGGER TRIGGER_SALES_INVENHIS
AFTER INSERT OR UPDATE OR DELETE ON sales_item -- ����, ��ǰ �Ǹ�
FOR EACH ROW
BEGIN
    -- ��ǰ�� ��ǰ���� ��ȯ
    DECLARE
        CURSOR cur_trans IS
            SELECT parts_no, cnt
            FROM product_bom
            WHERE product_no = :NEW.product_no;
    BEGIN
        IF INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('sales_item INSERT �߻�' || :NEW.product_no);
            -- ��� ���� ������ ó������ ����
            IF :NEW.sales_item_outcnt != 0 THEN
                -- ��� ���� ���̺� ��ǰ ����-
                FOR rec IN cur_trans LOOP
                    INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                    VALUES (inventory_adjust_seq.nextval, 4/*����*/, 0/*��ǰ*/, rec.parts_no, 1/*OUT*/, rec.cnt * :NEW.sales_item_outcnt, sysdate, 2/*�Ϸ�*/);
                END LOOP;
                -- ��� ���� ���̺� ��ǰ ����+
                INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                VALUES (inventory_adjust_seq.nextval, 4/*����*/, 1/*��ǰ*/, :NEW.product_no, 0/*IN*/, :NEW.sales_item_outcnt, sysdate, 2/*�Ϸ�*/);
                
                -- ��ǰ�� ���� ���
                INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
                VALUES (inventory_seq.nextval, 0/*����*/, :NEW.sales_no, 1/*��ǰ*/, :NEW.product_no, 1/*OUT*/, :NEW.sales_item_outcnt, null, sysdate, 0/*ǰ��*/);
            END IF;
        ELSIF UPDATING THEN
            DBMS_OUTPUT.PUT_LINE('sales_item UPDATE �߻�' || :OLD.product_no || :OLD.sales_item_outcnt);
            DBMS_OUTPUT.PUT_LINE('sales_item UPDATE �߻�' || :OLD.product_no || :NEW.sales_item_outcnt);
                -- ���� : OUT ó��(����)
            IF :NEW.sales_item_outcnt > :OLD.sales_item_outcnt THEN
                -- ��� ���� ���̺� ��ǰ ����-
                FOR rec IN cur_trans LOOP
                    INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                    VALUES (inventory_adjust_seq.nextval, 4/*����*/, 0/*��ǰ*/, rec.parts_no, 1/*OUT*/, rec.cnt * (:NEW.sales_item_outcnt - :OLD.sales_item_outcnt), sysdate, 2/*�Ϸ�*/);
                END LOOP;
                -- ��� ���� ���̺� ��ǰ ����+
                INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                VALUES (inventory_adjust_seq.nextval, 4/*����*/, 1/*��ǰ*/, :NEW.product_no, 0/*IN*/, :NEW.sales_item_outcnt - :OLD.sales_item_outcnt, sysdate, 2/*�Ϸ�*/);
                
                -- ��ǰ�� ���� ���
                INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
                VALUES (inventory_seq.nextval, 0/*����*/, :NEW.sales_no, 1/*��ǰ*/, :NEW.product_no, 1/*OUT*/, :NEW.sales_item_outcnt - :OLD.sales_item_outcnt, null, sysdate, 0/*ǰ��*/);
            -- ���� : IN ó��(����)
            ELSIF :NEW.sales_item_outcnt < :OLD.sales_item_outcnt THEN
                -- ��ǰ�� ���� ���
                INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
                VALUES (inventory_seq.nextval, 2/*�������*/, :NEW.sales_no, 1/*��ǰ*/, :NEW.product_no, 0/*IN*/, :OLD.sales_item_outcnt - :NEW.sales_item_outcnt, null, sysdate, 0/*ǰ��*/);
                
                -- ��� ���� ���̺� ��ǰ ����-
                INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                VALUES (inventory_adjust_seq.nextval, 5/*����*/, 1/*��ǰ*/, :NEW.product_no, 1/*OUT*/, :OLD.sales_item_outcnt - :NEW.sales_item_outcnt, sysdate, 2/*�Ϸ�*/);
                -- ��� ���� ���̺� ��ǰ ����+
                FOR rec IN cur_trans LOOP
                    INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                    VALUES (inventory_adjust_seq.nextval, 5/*����*/, 0/*��ǰ*/, rec.parts_no, 0/*IN*/, rec.cnt * (:OLD.sales_item_outcnt - :NEW.sales_item_outcnt), sysdate, 2/*�Ϸ�*/);
                END LOOP;
            END IF;
        ELSIF DELETING THEN
            -- ����, ��ǰ �ǸŸ� ��������Ƿ� �ٽ� IN
            DBMS_OUTPUT.PUT_LINE('sales_item DELETE �߻�' || :OLD.product_no);
            IF :OLD.sales_item_outcnt != 0 THEN
                -- ��ǰ�� ���� ���� ���
                INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
                VALUES (inventory_seq.nextval, 2/*�������*/, :OLD.sales_no, 1/*��ǰ*/, :OLD.product_no, 0/*IN*/, :OLD.sales_item_outcnt, null, sysdate, 0/*ǰ��*/);
                
                -- ��� ���� ���̺� ��ǰ ����-
                INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                VALUES (inventory_adjust_seq.nextval, 5/*����*/, 1/*��ǰ*/, :OLD.product_no, 1/*OUT*/, :OLD.sales_item_outcnt, sysdate, 2/*�Ϸ�*/);
                -- ��� ���� ���̺� ��ǰ ����+
                FOR rec IN cur_trans LOOP
                    INSERT INTO inventory_adjust (inventory_adjust_no, adjust_status, item_status, item_no, inout_status, item_cnt, inout_date, item_close_status) 
                    VALUES (inventory_adjust_seq.nextval, 5/*����*/, 0/*��ǰ*/, rec.parts_no, 0/*IN*/, rec.cnt * :OLD.sales_item_outcnt, sysdate, 2/*�Ϸ�*/);
                END LOOP;
            END IF;
        END IF;
    END;
END;
/
CREATE OR REPLACE TRIGGER TRIGGER_PURCHASE_INVENHIS
AFTER INSERT OR UPDATE OR DELETE ON purchase_item -- ����, ��ǰ ����
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('purchase_item INSERT �߻�' || :NEW.parts_no);
        -- ��� ���� ������ ó������ ����
        IF :NEW.purchase_item_incnt != 0 THEN
            INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
            VALUES (inventory_seq.nextval, 1/*����*/, :NEW.purchase_no, 0/*��ǰ*/, :NEW.parts_no, 0/*IN*/, :NEW.purchase_item_incnt, null, sysdate, 0/*ǰ��*/);
        END IF;
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('purchase_item UPDATE �߻�' || :OLD.parts_no || :OLD.purchase_item_incnt);
        DBMS_OUTPUT.PUT_LINE('purchase_item UPDATE �߻�' || :OLD.parts_no || :NEW.purchase_item_incnt);
        IF :NEW.purchase_item_incnt > :OLD.purchase_item_incnt THEN
            -- ����: IN ó��
            INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
            VALUES (inventory_seq.nextval, 1/*����*/, :NEW.purchase_no, 0/*��ǰ*/, :NEW.parts_no, 0/*IN*/, :NEW.purchase_item_incnt - :OLD.purchase_item_incnt, null, sysdate, 0/*ǰ��*/);
        ELSIF :NEW.purchase_item_incnt < :OLD.purchase_item_incnt THEN
            -- ����: OUT ó��
            INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
            VALUES (inventory_seq.nextval, 1/*����*/, :NEW.purchase_no, 0/*��ǰ*/, :NEW.parts_no, 1/*OUT*/, :OLD.purchase_item_incnt - :NEW.purchase_item_incnt, null, sysdate, 0/*ǰ��*/);
        END IF;
    ELSIF DELETING THEN
        -- ����, ��ǰ �ǸŸ� ��������Ƿ� �ٽ� OUT
        DBMS_OUTPUT.PUT_LINE('purchase_item DELETE �߻�' || :OLD.parts_no);
        IF :OLD.purchase_item_incnt != 0 THEN
            -- ���� ��ǰ,��ǰ��ȣ�� incnt��ŭ OUT
            INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
            VALUES (inventory_seq.nextval, 1/*����*/, :OLD.purchase_no, 0/*��ǰ*/, :OLD.parts_no, 1/*OUT*/, :OLD.purchase_item_incnt, null, sysdate, 0/*ǰ��*/);
        END IF;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TRIGGER_ADJUST_INVENHIS
AFTER INSERT ON inventory_adjust -- ����, ����, ���� INSERT
FOR EACH ROW
BEGIN
    INSERT INTO inventory (inventory_his_no, order_status, order_no, item_status, item_no, inout_status, item_cnt, item_totalcnt, inout_date, item_quality) 
    VALUES (inventory_seq.nextval, :NEW.adjust_status, -1/*order_no����*/, :NEW.item_status, :NEW.item_no, :NEW.inout_status, :NEW.item_cnt, null, sysdate, 0/*ǰ��*/);
END;
/
/************************************************** 
 * FUNCTION : �Լ�
 **************************************************/
-- DROP
--DROP FUNCTION calc_real_inventory;
--DROP FUNCTION calc_real_inventory_all;
DROP TYPE table_calc_real_inventory;
DROP TYPE table_calc_real_inventory_all;
DROP TYPE type_calc_real_inventory;
DROP TYPE type_calc_real_inventory_all;
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
CREATE OR REPLACE TYPE type_calc_real_inventory_all AS OBJECT (
    item_status NUMBER,
    item_no NUMBER,
    cnt NUMBER
);
/
-- ��ü Ÿ���� ���̺� Ÿ�� ���� (���� ��)
CREATE OR REPLACE TYPE table_calc_real_inventory AS TABLE OF type_calc_real_inventory;
/
CREATE OR REPLACE TYPE table_calc_real_inventory_all AS TABLE OF type_calc_real_inventory_all;
/
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
create or replace FUNCTION calc_real_inventory_all
RETURN table_calc_real_inventory_all PIPELINED -- PIPELINED : �� �྿ ���������� ��ȯ�� �� �ְ� ���ִ� �Լ��� ����
IS
    -- �Ӽ�����
    v_inven_status NUMBER; -- ��ǰ/��ǰ ����
    v_item_no NUMBER; -- ����ȣ
    v_item_status VARCHAR2(255); -- ���з�
    v_name VARCHAR2(255); -- ����
    v_total_cnt NUMBER; -- �� ����
    v_inventory_cnt NUMBER; -- �⸻ ����
    v_purchase_cnt NUMBER; -- ���� ����
    v_sales_cnt NUMBER; -- �Ǹ� ����
    v_in_cnt NUMBER; -- ����+ ����
    v_out_cnt NUMBER; -- ����- ����
    
    -- �� ��� �Ǽ��� ��������
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
            WHERE yearmonth = (SELECT MAX(yearmonth) FROM month_inventory) -- �ֱ� ���
            AND startend_status = 1 -- �⸻���
            ) M 
            -- ����
            LEFT JOIN
            (SELECT 1 AS item_status, product_no AS item_no, sales_item_outcnt AS cnt FROM sales_item 
            WHERE sales_no IN ( 
                SELECT sales_no FROM sales_order WHERE out_status IN (2/*�Ϸ�*/)
                )
            ) S 
            ON M.item_status = S.item_status
            AND M.item_no = S.item_no
            -- ����
            LEFT JOIN 
            (SELECT 0 AS item_status, parts_no AS item_no, purchase_item_incnt AS cnt FROM purchase_item 
            WHERE purchase_no IN (
                SELECT purchase_no FROM purchase_order WHERE in_status IN (2/*�Ϸ�*/)
                )
            ) P 
            ON M.item_status = P.item_status
            AND M.item_no = P.item_no
            -- ����(+)
            LEFT JOIN 
            (SELECT item_status, item_no, item_cnt AS cnt FROM inventory_adjust 
            WHERE item_close_status IN (2/*�Ϸ�*/)
            AND inout_status = 0/*IN*/
            ) II 
            ON M.item_status = II.item_status
            AND M.item_no = II.item_no
            -- ����(-)
            LEFT JOIN 
            (SELECT item_status, item_no, item_cnt AS cnt FROM inventory_adjust 
            WHERE item_close_status IN (2/*�Ϸ�*/)
            AND inout_status = 1/*OUT*/
            ) IO 
            ON M.item_status = IO.item_status
            AND M.item_no = IO.item_no
        GROUP BY M.item_status, M.item_no;

BEGIN
    OPEN cur_real_inventory;

    LOOP
        FETCH cur_real_inventory INTO v_item_status, v_item_no, v_inventory_cnt, v_purchase_cnt, v_sales_cnt, v_in_cnt, v_out_cnt;
        
        -- ������ LOOP ����
        EXIT WHEN cur_real_inventory%NOTFOUND;
        
        PIPE ROW(type_calc_real_inventory_all(v_item_status, v_item_no, v_inventory_cnt + v_purchase_cnt - v_sales_cnt + v_in_cnt - v_out_cnt));
    END LOOP;

    RETURN;
END;
/
/************************************************** 
 * PROCEDURE : ���ν���
 **************************************************/
-- DROP PROCEDURE create_item_to_inventory;
CREATE OR REPLACE PROCEDURE create_item_to_inventory(p_yearMonth IN VARCHAR2)
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
            WHERE YEARMONTH = p_yearMonth
            AND item_no = part_rec.parts_no
            AND ITEM_STATUS = 0;

            IF v_exists > 0 THEN
                DBMS_OUTPUT.PUT_LINE('����');
            ELSE
                DBMS_OUTPUT.PUT_LINE('������');
                -- INSERT
                INSERT INTO month_inventory(YEARMONTH, STARTEND_STATUS, ITEM_STATUS, ITEM_NO, CNT, IN_DATE) VALUES (p_yearMonth, 0, 0, part_rec.parts_no, 0, sysdate);
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
            WHERE YEARMONTH = p_yearMonth
            AND item_no = product_rec.product_no
            AND ITEM_STATUS = 1;

            IF v_exists > 0 THEN
                DBMS_OUTPUT.PUT_LINE('����');
            ELSE
                DBMS_OUTPUT.PUT_LINE('������');
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
    -- v_totalcnt_map(item_status)(item_no)�� ���� ������ ��
    TYPE t_totalcnt_map_of_status IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    v_totalcnt_map_of_status t_totalcnt_map_of_status;
    TYPE t_totalcnt_map IS TABLE OF t_totalcnt_map_of_status INDEX BY PLS_INTEGER;
    v_totalcnt_map t_totalcnt_map;
    
    -- ��� ���� �̷� ������ ������� ���� Ŀ��
    CURSOR cur_inven IS
        SELECT * FROM inventory
        WHERE item_totalcnt IS NULL
        ORDER BY inventory_his_no;
BEGIN
    FOR rec_inven IN cur_inven LOOP
        -- ���� �� �ʱ�ȭ
        -- �ʿ� item_status�� �����ϴ��� Ȯ��
        IF NOT v_totalcnt_map.EXISTS(rec_inven.item_status) THEN
            v_totalcnt_map(rec_inven.item_status) := v_totalcnt_map_of_status;
        END IF;
        -- ���� �ʿ� item_no�� �����ϴ��� Ȯ��
        IF NOT v_totalcnt_map(rec_inven.item_status).EXISTS(rec_inven.item_no) THEN
            -- DB���� ���� �ֱ� totalcnt ��������
            SELECT NVL(MAX(ITEM_TOTALCNT), 0)
            INTO v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no)
            FROM inventory
            WHERE item_status = rec_inven.item_status
              AND item_no = rec_inven.item_no
              AND inventory_his_no < rec_inven.inventory_his_no;
        END IF;
        
        -- �԰� : �����տ� ���ϱ�
        IF rec_inven.inout_status = 0 THEN
            v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no) := v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no) + rec_inven.item_cnt;
        -- ��� : �����տ��� ����
        ELSIF rec_inven.inout_status = 1 THEN
            v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no) := v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no) - rec_inven.item_cnt;
        END IF;
                
        -- ����� ���������� ������Ʈ
        UPDATE inventory
        SET ITEM_TOTALCNT = v_totalcnt_map(rec_inven.item_status)(rec_inven.item_no)
        WHERE INVENTORY_HIS_NO = rec_inven.INVENTORY_HIS_NO;
    END LOOP;
    
    COMMIT;
END;
/
/************************************************** 
 * PACKAGE : ��Ű��
 **************************************************/
-- DROP PACKAGE BODY month_close;
-- DROP PACKAGE month_close;
-- ������ ��Ű��
CREATE OR REPLACE PACKAGE month_close AS
    g_in_empno emp.emp_no%TYPE := '1001';
    g_prod_cnt NUMBER(9) := 0;
    
    -- ������0 : ����
    PROCEDURE month_close_main(
    p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2, p_real in VARCHAR2, 
    p_result OUT VARCHAR2);
    
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
    PROCEDURE month_close_end (p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2, p_real in VARCHAR2);
END;
-- PACKAGE�� PACKAGE BODY ����
/
CREATE OR REPLACE PACKAGE BODY month_close AS
    PROCEDURE month_close_main(
    p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2, p_real in VARCHAR2, 
    p_result OUT VARCHAR2) 
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
        
        COMMIT;
        
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
        AND startend_status = '1';
        -- ������ �⸻��� �����Ͽ� �̹��� ������� ���
        IF v_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('�������');
            INSERT INTO month_inventory(YEARMONTH,STARTEND_STATUS,ITEM_STATUS,ITEM_NO,CNT,IN_DATE)
            SELECT p_sum_yymm,'0'/*����*/,ITEM_STATUS,ITEM_NO,CNT,SYSDATE 
            FROM     month_inventory
            WHERE    YEARMONTH  = TO_CHAR(ADD_MONTHS (TO_DATE(p_sum_yymm,'YYMM'),-1),'YYMM')
            AND      startend_status = '1' -- �⸻
            ;
            DBMS_OUTPUT.PUT_LINE('���糡');
        -- ������ �⸻��� ����
        ELSE
            DBMS_OUTPUT.PUT_LINE('������ �⸻ ��� �������� �ʽ��ϴ�.');
        END IF;
        
        dbms_output.put_line('�ű� ��� ���');
        create_item_to_inventory(p_sum_yymm);
        
        COMMIT;
        
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
        SELECT 
            M.yearmonth,
            M.item_status,
            M.item_no, 
            SUM(M.cnt) AS inventory_cnt, 
            -- ���� ���� �ʿ�1 : JOIN �� �׸� ������ �������� ���� �̻�����...
            NVL(SUM(P.purchase_item_cnt),0) AS purchase_cnt, -- ���� ���� �ʿ�1
            NVL(SUM(S.sales_item_cnt),0) AS sales_cnt, -- ���� ���� �ʿ�1
            NVL(AVG(II.item_in),0) AS item_in, -- ���� ���� �ʿ�1
            NVL(AVG(IO.item_out),0) AS item_out -- ���� ���� �ʿ�1
        FROM (SELECT yearmonth, item_status, item_no, cnt FROM month_inventory 
            WHERE    yearmonth = p_sum_yymm
            AND      startend_status = '0' -- ���� ��� ����
        ) M -- �����
        LEFT JOIN
        -- ��ǰ ���� ����
        (SELECT 0 AS item_status, parts_no AS item_no, PURCHASE_ITEM_CNT FROM purchase_item 
        WHERE purchase_no IN (
            SELECT purchase_no FROM purchase_order 
            WHERE TO_CHAR(purchase_date, 'YYMM') = p_sum_yymm
            AND in_status IN (2,3) -- �Ϸ�, ����
            )
        ) P -- ���� ����
        ON M.item_status = P.item_status
        AND M.item_no = P.item_no
        LEFT JOIN
        -- ��ǰ �Ǹ� ����
        (SELECT 1 AS item_status, product_no AS item_no, sales_item_cnt FROM sales_item
        WHERE sales_no IN (
            SELECT sales_no FROM sales_order
            WHERE TO_CHAR(sales_date, 'YYMM') = p_sum_yymm
            AND out_status IN (2,3) -- �Ϸ�, ����
            )
        ) S
        ON M.item_status = S.item_status
        AND M.item_no = S.item_no
        LEFT JOIN
        -- ��� ����IN ����(����, ����, ����)
        (SELECT item_status, item_no, SUM(item_cnt)/* ���� ���� �ʿ�1 */ AS item_in FROM inventory_adjust
        WHERE TO_CHAR(inout_date, 'YYMM') = p_sum_yymm
        AND item_close_status IN (2,3) -- �Ϸ�, ����
        AND inout_status = 0 -- IN
        GROUP BY item_status, item_no
        ) II
        ON M.item_status = II.item_status
        AND M.item_no = II.item_no
        LEFT JOIN
        -- ��� ����OUT ����(����, ����, ����)
        (SELECT item_status, item_no, SUM(item_cnt)/* ���� ���� �ʿ�1 */ AS item_out FROM inventory_adjust
        WHERE TO_CHAR(inout_date, 'YYMM') = p_sum_yymm
        AND item_close_status IN (2,3) -- �Ϸ�, ����
        AND inout_status = 1 -- OUT
        GROUP BY item_status, item_no
        ) IO
        ON M.item_status = IO.item_status
        AND M.item_no = IO.item_no
        GROUP BY M.yearmonth,M.item_status,M.item_no;
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_prc2 START p_sum_yymm ' || p_sum_yymm);
        
        -- �̹��� ����, ����, (���), (����) �ݿ� �ϱ�
        FOR rec_close_clac IN cur_close_clac LOOP
            -- ���� ���
            DECLARE
                v_cnt VARCHAR2(4000) := rec_close_clac.inventory_cnt; -- ���� ���
            BEGIN
                v_cnt := v_cnt + rec_close_clac.purchase_cnt; -- ����
                v_cnt := v_cnt - rec_close_clac.sales_cnt; -- �Ǹ�
                v_cnt := v_cnt + rec_close_clac.item_in; -- ����(+)
                v_cnt := v_cnt - rec_close_clac.item_out; -- ����(-)
                
                IF rec_close_clac.item_no = 8 THEN
                    dbms_output.put_line(rec_close_clac.item_status || '/' || rec_close_clac.item_no || ' : ' || v_cnt);
                    dbms_output.put_line('rec_close_clac.purchase_cnt : ' || rec_close_clac.purchase_cnt);
                    dbms_output.put_line('rec_close_clac.sales_cnt : ' || rec_close_clac.sales_cnt);
                    dbms_output.put_line('rec_close_clac.item_in : ' || rec_close_clac.item_in);
                    dbms_output.put_line('rec_close_clac.item_out : ' || rec_close_clac.item_out);
                END IF;
                ------------------------------------------------------------------
                --    ���� â�� ������� �Ǹŷ����� ũ�ٸ� �⸻��� �Է� 
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
                        , 1 -- �⸻���
                        , rec_close_clac.item_status
                        , rec_close_clac.item_no
                        , v_cnt
                        , SYSDATE
                    );
                ELSE
                    --������ ����
                    g_prod_cnt := -v_cnt;
                    --���� ���
                    INSERT INTO error_log(error_no, error_code, error_coment, error_date) VALUES(error_log_seq.nextval, 
                    'ERR-1001 : month_close.month_close_prc2', 
                    '������ ������ ' || rec_close_clac.yearmonth || '�� ' || rec_close_clac.item_status || '(��ǰ/��ǰ):' || rec_close_clac.item_no || '��� ' ||  g_prod_cnt || '���� ����', 
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
    Description    : ���Ҹ��� �� �̷� ���
    ***************************************************************************/
    PROCEDURE month_close_end(p_sum_yymm in VARCHAR2, p_regi_emp_no in VARCHAR2, p_real in VARCHAR2)
    IS
    BEGIN
        DBMS_OUTPUT.ENABLE;
        dbms_output.put_line('month_close_end START p_sum_yymm/p_regi_emp_no ' || p_sum_yymm || '/' || p_regi_emp_no);
        
        -- ���� ���̺� �Ϸ� -> ���� ó��
        UPDATE sales_order SET out_status = 3
        WHERE out_status = 2
        AND TO_CHAR(in_date, 'YYMM') = p_sum_yymm;
        -- ���� ���̺� �Ϸ� -> ���� ó��
        UPDATE purchase_order SET in_status = 3
        WHERE in_status = 2
        AND TO_CHAR(in_date, 'YYMM') = p_sum_yymm;
        -- ���� ���̺� �Ϸ� -> ���� ó��
        UPDATE inventory_adjust SET item_close_status = 3
        WHERE item_close_status = 2
        AND TO_CHAR(inout_date, 'YYMM') = p_sum_yymm;
        
        -- ���Ҹ��� �� �̷� ���
        UPDATE inventory_close SET CLOSE_STATUS = p_real, CLOSE_ENDDATE = sysdate
        WHERE yearmonth = p_sum_yymm;
        
        COMMIT;
        
        dbms_output.put_line('month_close_end END');
    END;
END;
/