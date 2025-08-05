/************************************************** 
 *   ALL TABLE DELETE 
 **************************************************/
DELETE FROM BOARD;
DELETE FROM CLIENT;
DELETE FROM CLIENT_HIS;
DELETE FROM CLIENT_PERFORM;
DELETE FROM COMMON;
DELETE FROM DEPT;
DELETE FROM EMP;
DELETE FROM EMP_IMAGE;
DELETE FROM INVENTORY;
DELETE FROM INVENTORY_CLOSE;
DELETE FROM MONTH_INVENTORY;
DELETE FROM PARTS;
DELETE FROM PARTS_PRICE_HIS;
DELETE FROM PRODUCT;
DELETE FROM PRODUCT_BOM;
DELETE FROM PRODUCT_PRICE_HIS;
DELETE FROM PURCHASE_ITEM ;
DELETE FROM PURCHASE_ORDER ;
DELETE FROM PURCHASE_PERFORM ;
DELETE FROM SALES_ITEM;
DELETE FROM SALES_ORDER;
DELETE FROM SALES_PERFORM;
-------------------------------------------------------------------------------

/************************************************** 
 *  ���� : COMMON
 **************************************************/
INSERT INTO common VALUES (100, 999, '��������');
INSERT INTO common VALUES (100, 0, 'Ȱ��');
INSERT INTO common VALUES (100, 1, '����');

INSERT INTO common VALUES (200, 999, '����');
INSERT INTO common VALUES (200, 0, 'ROLE_ADMIN');
INSERT INTO common VALUES (200, 1, 'ROLE_MANAGER');
INSERT INTO common VALUES (200, 2, 'ROLE_USER');

INSERT INTO common VALUES (300, 999, '�ŷ�ó����');
INSERT INTO common VALUES (300, 0, '����ó');
INSERT INTO common VALUES (300, 1, '�Ǹ�ó');

INSERT INTO common VALUES (400, 999, '���ֻ���');
INSERT INTO common VALUES (400, 0, '��û');
INSERT INTO common VALUES (400, 1, '����');
INSERT INTO common VALUES (400, 2, '�Ϸ�');
INSERT INTO common VALUES (400, 3, '����');

INSERT INTO common VALUES (500, 999, '���ֻ���');
INSERT INTO common VALUES (500, 0, '��û');
INSERT INTO common VALUES (500, 1, '����');
INSERT INTO common VALUES (500, 2, '�Ϸ�');
INSERT INTO common VALUES (500, 3, '����');

INSERT INTO common VALUES (600, 999, '��ǰ/��ǰ ����');
INSERT INTO common VALUES (600, 0, '��ǰ');
INSERT INTO common VALUES (600, 1, '��ǰ');

INSERT INTO common VALUES (700, 999, '���� ����');
INSERT INTO common VALUES (700, 0, '��������');
INSERT INTO common VALUES (700, 1, '�����Ϸ�');
INSERT INTO common VALUES (700, 2, '�������Ϸ�');

INSERT INTO common VALUES (800, 999, '��ǰ �з�');
INSERT INTO common VALUES (800, 0, '����ũž');
INSERT INTO common VALUES (800, 1, '��Ʈ��');
INSERT INTO common VALUES (800, 2, '��ũ�����̼�');

INSERT INTO common VALUES (900, 999, '��ǰ �з�');
INSERT INTO common VALUES (900, 0, '���κ���');
INSERT INTO common VALUES (900, 1, 'CPU');
INSERT INTO common VALUES (900, 2, 'GPU');
INSERT INTO common VALUES (900, 3, '�޸�;');
INSERT INTO common VALUES (900, 4, 'POWER');
INSERT INTO common VALUES (900, 5, 'HDD');
INSERT INTO common VALUES (900, 6, 'SSD');
INSERT INTO common VALUES (900, 7, 'CASE');
INSERT INTO common VALUES (900, 8, 'COOLER');

INSERT INTO common VALUES (1000, 999, 'ȣȯ�� ����');
INSERT INTO common VALUES (1000, 0, '��Ȯ��');
INSERT INTO common VALUES (1000, 1, 'ȣȯ����');
INSERT INTO common VALUES (1000, 2, 'ȣȯ�Ұ���');

INSERT INTO common VALUES (1100, 999, '����/���� ����');
INSERT INTO common VALUES (1100, 0, '����');
INSERT INTO common VALUES (1100, 1, '����');

COMMIT;

/************************************************** 
 *  �μ� : DEPT
 **************************************************/

--Ư������ & �ν� ���� �� ���(������ ON)
SET DEFINE OFF;

-- �ֻ��� �μ� (����)
INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1000, '�濵����', 1001, NULL, '���� ���� 10��', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (2000, '�������', 1009, NULL, '�Ǳ� R&D ���� 5��', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (3000, '�������', 1002, NULL, '���� ���� 11��', 0, 1001, SYSDATE);

-- �濵����(1000) ���� ��
INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1001, '�λ���', 1005, 1000, '���� ���� 10��', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1002, '�繫��', 1008, 1000, '���� ���� 10��', 0, 1001, SYSDATE);

-- �������(2000) ���� ��
INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (2001, '�÷���������', 1009, 2000, '�Ǳ� R&D ���� 5��', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (2002, '����ϰ�����', 1007, 2000, '�Ǳ� R&D ���� 6��', 0, 1001, SYSDATE);

-- �������(3000) ���� ��
INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (3001, '����������', 1003, 3000, '���� ���� 11��', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (3002, '�ؿܿ�����', 1006, 3000, '���� ���� 11��', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (3003, '��������', 1002, 3000, '���� ���� 12��', 0, 1001, SYSDATE);

COMMIT;

SET DEFINE ON;

/************************************************** 
 *  ��� : EMP
 **************************************************/
-- 1. ��ö�� -> �÷���������(2001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1001, '��ö��', '010-1111-2222', 'cskim@company.com', 90000000, 2001, 'cskim', 'hashed_password_placeholder', 'ROLE_ADMIN', 0, 1001, SYSDATE);

-- 2. �̿��� -> ��������(3003)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1002, '�̿���', '010-2222-3333', 'yhlee@company.com', 75000000, 3003, 'yhlee', 'hashed_password_placeholder', 'ROLE_MANAGER', 0, 1001, SYSDATE);

-- 3. ������ -> ����������(3001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1003, '������', '010-3333-4444', 'jspark@company.com', 55000000, 3001, 'jspark', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 4. �ֹ��� -> �÷���������(2001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1004, '�ֹ���', '010-4444-5555', 'mjchoi@company.com', 60000000, 2001, 'mjchoi', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 5. ������ -> �λ���(1001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1005, '������', '010-5555-6666', 'sbjeong@company.com', 48000000, 1001, 'sbjeong', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 6. ������ -> �ؿܿ�����(3002)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1006, '������', '010-6666-7777', 'ejkang@company.com', 52000000, 3002, 'ejkang', 'hashed_password_placeholder', 'ROLE_USER', 0, 1002, SYSDATE);

-- 7. ������ -> ����ϰ�����(2002)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1007, '������', '010-7777-8888', 'hwyun@company.com', 61000000, 2002, 'hwyun', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 8. �Ӽ��� -> �繫��(1002)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1008, '�Ӽ���', '010-8888-9999', 'syim@company.com', 50000000, 1002, 'syim', 'hashed_password_placeholder', 'ROLE_USER', 0, 1002, SYSDATE);

-- 9. ������ -> �÷���������(2001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1009, '������', '010-9999-0000', 'jhhan@company.com', 82000000, 2001, 'jhhan', 'hashed_password_placeholder', 'ROLE_MANAGER', 0, 1001, SYSDATE);

-- 10. �ۿ��� -> �λ���(1001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1010, '�ۿ���', '010-0000-1111', 'yesong@company.com', 47000000, 1001, 'yesong', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- ���� ������ ���(100:ADMIN) �ʱ� ���� ���
INSERT INTO EMP (
    EMP_NO, EMP_NAME, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, IN_DATE
) VALUES (
    100, 'ADMIN', 'ADMIN', 'not_applicable', 'ROLE_ADMIN', 0, SYSDATE
);       

COMMIT;

/************************************************** 
 *  �Խ��� : BOARD
 **************************************************/

-- 1. ERP �ý��� ���� ����
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[�ý���] ERP ���� ���� ���� �ȳ� (8/8 �� 22:00~)', '�ȳ��ϼ���. IT�������Դϴ�. 8�� 8�� �ݿ��� 22:00 ���� 2�ð� ���� �ý��� ������ Ȯ���� ���� ���� ������ ����˴ϴ�. �ش� �ð����� �ý��� ������ �Ұ��Ͽ��� ������ �����Ͻñ� �ٶ��ϴ�.', 152, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE);

-- 2. �ű� ��� ����
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[������Ʈ] �ű� "�ǽð� ��� ����" ��� ���� �ȳ�', '����� ���Ǽ� ���븦 ���� �ǽð� ��� ���� ����� ���Ӱ� ���µǾ����ϴ�. ���� �� â�� ��� ��Ȳ�� �ǽð����� Ȯ���� �� �ֽ��ϴ�. ���� Ȱ�� �ٶ��ϴ�.', 210, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 1);

-- 3. ������ �Է� ��Ģ
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[�߿�] �� ���� �Է� �� �ּ� ǥ��ȭ ��Ģ �ؼ� ��û', '������ ���ռ��� ����, �� ���� ��� �� �ݵ�� ���ο� �ּ� �˻� API�� ���� ǥ��ȭ�� �ּҸ� �Է����ֽñ� �ٶ��ϴ�. ���� ������ �߻� �� ���� ���� ���迡�� ������ �� �ֽ��ϴ�.', 350, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 2);

-- 4. ���� ��ǥ ����
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[����] 2025�� 3�б� ���� ��ǥ �� �μ�Ƽ�� ��å ����', '2025�� 3�б� ���� ���� ��ǥ�� �̿� ���� �μ�Ƽ�� ��å�� �����մϴ�. �ڼ��� ������ �������� > ��ǥ���� �޴����� Ȯ�� �����մϴ�.', 180, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 3);

-- 5. ���� ��ȹ ������Ʈ
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[����] ���� ���� ������ ���� ERP ���� ��ȹ ��� ������Ʈ', 'A���� ������ �Ϸ�ʿ� ����, ERP ���� ��ȹ ��⿡ ���� ������ ������Ʈ�Ǿ����ϴ�. 8�� 11�Ϻ��� ���ο� �������� ���� ��ȹ�� �������ֽñ� �ٶ��ϴ�.', 120, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 4);

-- 6. ��� �ǻ� �ȳ�
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[����] �Ϲݱ� ���� ��� �ǻ� �ȳ� (8/29~30)', '2025�� �Ϲݱ� ���� ��� �ǻ簡 8�� 29��, 30�� ���ϰ� ����˴ϴ�. �ǻ� �Ⱓ ���ȿ��� ��� �̵��� �����ǿ���, �� �������� ���� ������ �������ֽñ� �ٶ��ϴ�.', 255, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 5);

-- 7. ���� ��ȭ �ȳ�
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[����] ERP �ý��� ��й�ȣ ���� ���� �ȳ�', '������ȣ ��å�� ����, ��� ������������ 8�� ������ ERP �ý��� ���� ��й�ȣ�� �������ֽñ� �ٶ��ϴ�. (����/����/Ư������ ���� 9�� �̻�)', 412, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 6);

-- 8. ���� ���� ����
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[����] ������ ��� �� �Ϻ� �׸� ���� ���� ���� �Ϸ�', '�Ϻ� ����ڿ��Լ� �߻��ϴ� ������ ��� ������ �����Ǿ����ϴ�. ���� ���������� ��� �׸��� ���ԵǾ� ��µ˴ϴ�. �̿뿡 ������ ��� �˼��մϴ�.', 99, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 7);

-- 9. ����� ����
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[����] ���Ի���� ���� ERP �ý��� ����� ���� (8/12 ȭ)', '8�� �ű� �Ի��ڵ��� ������� ERP �ý��� �⺻ ���� ������ �ǽ��մϴ�. �Ͻ�: 8�� 12��(ȭ) 14:00~16:00, ���: 3�� ������', 75, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 8);

-- 10. ���� �Ⱓ �
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[�ȳ�] �߼� ���� �Ⱓ ERP �ý��� � �� ��� ���� �ȳ�', '�߼� ���� �Ⱓ(9/5~9/8) ���� �ý����� ���� ��˴ϴ�. ��� ��� �߻� �� IT������ ��� ���������� �����ֽñ� �ٶ��ϴ�.', 198, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 9);

COMMIT;

/************************************************** 
 *  ��ǰ : PARTS
 **************************************************/
SET DEFINE OFF;

Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'������5-5���� 7500F','CPU �ھ� �� : 6
������ �� : 12
�ִ� �ν�Ʈ �� : 5.0GHz
�⺻��:3.7 GHz
�⺻TDP:65W
CMOS:TSMC 5nm FInFET
����:AM5
�ִ��۵��µ�:95��','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,8,'STANDARD COOLER','�⺻���� CPU��','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'RIME A620M-K ','Ĩ�� : AMD A620
Ĩ�������� : AMD
�뵵 : ����ũž��(������)�޸�
���� : DDR5-6400MHz
�޸� ���� : 2���ִ� 
�޸� : 96GBVGA 
���� : D-SUB, HDMI
Ȯ�彽�� : PCI Express 4.0x16
����CPU : AMD
������ġ���� : SATA3(4��), M.2 SSDUSB
���� : USB3.2 Gen1(4��), USB2.0(2��)
���� ä�� : 7.1ä��','ASUS',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'Crucial DDR5-5600 CL46','�뵵 : ����ũž��(DIMM)�޸𸮹�� : DDR5���ۼӵ� : 5,600MHz(PC5-44,800)�濭�� : ������ : 1.1V��Ÿ�̹�(CL) : 46��Ÿ�̹�(tRCD) : 45��Ÿ�̹�(tRP) : 45','����ũ��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX 5060 Ti D7 8GB TWIN X2','�޸� ���� : GDDR7�ν�ƮŬ�� : 2,602MHz���̽�Ŭ�� : 2,407MHz��� ���μ��� : 4608���������̽� : PCI-Express5.0�޸� : 8GB�޸� �뿪�� : 128bit','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Crucial P3 Plus M.2 NVMe','�԰� : M.2(2280)�б� : 4700Mb/s���� : 1900Mb/s�ΰ���� : S.M.A.R.T., DEVSLP, TRIM����, GC, ECC�����������̽� : PCI-Express4.0, x4���� : 8cm','����ũ��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'DS500 RGB','���κ��� �԰� : ATX, Micro-ATX, Mini-ITX�Ŀ��԰� : ATX�Ŀ����� : �ĸ��ϴ������Ŀ� ���� : �Ŀ� ����2.5���� : 1��3.5���� : 2��','NOBRAND',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'MAXWELL PRIMO 700W 80PLUS���Ĵٵ� �÷�
','���� : ATX�Ŀ�������� : ����������� : 700W��ȿ���Ŀ� : ���Ĵٵ����Ŀ���� : 20+4��PCI-EĿ���� : PCI-E(6+2��) x 2��SATAĿ���� : 4��','��������Ʈ',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'�ھ�i7-14���� 14700F (���ͷ���ũ ��������)','�����ھ� : ���ͷ���ũ-R�ھ����� : 20�ھ�⺻Ŭ�� : 2.1GHz������ : 28������L3 ĳ�� : 33MB���� : �����۽����� �������� : �������ͺ�Ŭ���ӵ� : 5.4GHz','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,8,'JIUSHARK JF100RS Crystal','CPU���� : AMD ����AM4, AMD ����AM5, ���� LGA1151, ���� LGA1156, ���� LGA1200, ���� LGA1700���� �β� : 25T�ִ�TDP : 220W��ũ�� : 10cm�ɼ� : 4��','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'B760M DS3H','���� : 1170���ϱ԰� : Micro-ATX�ִ� �޸� : 128GB�޸� ���� : DDR4-5333MHz�޸� ���� : 4��VGA ���� : D-SUB, HDMI, DisplayPortȮ�彽�� : PCI-Express4.0','GIGABYTE',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'Crucial DDR5-5600 CL46 32G','�뵵 : ����ũž��(DIMM)�޸𸮹�� : DDR5���ۼӵ� : 5,600MHz(PC5-44,800)�濭�� : ������ : 1.1V��Ÿ�̹�(CL) : 46��Ÿ�̹�(tRCD) : 45��Ÿ�̹�(tRP) : 45','����ũ��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX 5070 ������ 2X OC D7 12GB
','�޸� ���� : GDDR7�ν�ƮŬ�� : 2,542MHz��� ���μ��� : 6144���������̽� : PCI-Express5.0(x16)�޸� : 12GB�޸� �뿪�� : 192bit','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Crucial P3 Plus M.2 NVMe','�԰� : M.2(2280)�б� : 4700Mb/s���� : 1900Mb/s�ΰ���� : S.M.A.R.T., DEVSLP, TRIM����, GC, ECC�����������̽� : PCI-Express4.0, x4���� : 8cm��뺸�� : 150���ð�','����ũ��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'DPX90 ARGB ��ȭ���� (��)','ǰ�� : �̵�Ÿ�����̽����κ��� �԰� : ATX, Micro-ATX, Mini-ITX�Ŀ��԰� : ATX�ΰ���� : ������������ : 3���޸��� : 12cm x 1�������� : 12cm x 2��','NOBRAND',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'MegaMax II 800W 80PLUS����� ATX3.1
','���� : ATX�Ŀ�������� : ����������� : 800W��ȿ���Ŀ� : ��������Ŀ���� : 20+4��PCI-EĿ���� : PCI-E(12+4��) x 1��SATAĿ���� : 8��','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'������3-2���� 3200G (��ī��)','AMD�ھ� : ��ī��(2����)�ھ����� : 4�ھ���� : AMD-����AM4�������� : 12nm������ : 4������L2 ĳ�� : 2MBL3 ĳ�� : 4MB�ھ�(�׷���ī��) : 4�ھ�','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'A520M-A PRO','���� : AMD-����TR4�԰� : Micro-ATXĨ�� : ALC892Ĩ�������� : AMD','MSI',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'Crucial DDR4-3200 CL22 (8GB)','�޸𸮹�� : DDR4���� : 1.2V�޸� �԰� : DIMM 288��','����ũ��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'���κ��� ���� �⺻ VGA ���','�⺻���� ����GPU','NOBRAND',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Crucial P3 Plus M.2 NVMe (500GB)','�԰� : M.2(2280)�б� : 4700Mb/s���� : 1900Mb/s�ΰ���� : S.M.A.R.T., DEVSLP, TRIM����, GC, ECC�����������̽� : PCI-Express4.0, x4���� : 8cm','����ũ��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'LIMPID Micro-1','�� / �̴�Ÿ�� / ���� �� 165mm / ���� �� 2�� ����','���̹�',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'MAXWELL PRIMO 500W 80PLUS���Ĵٵ� �÷�
','���� : ATX�Ŀ�������� : ����������� : 500W��ȿ���Ŀ� : ���Ĵٵ����Ŀ���� : 24��PCI-EĿ���� : PCI-E(6+2��) x 2��SATAĿ���� : 4��','��������Ʈ',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'������7-4���� 5700G','AMD�ھ� : ����(4����)�ھ����� : 8�ھ���� : AMD-����AM4�������� : 7nm�⺻Ŭ�� : 3.8GHz������ : 16������L2 ĳ�� : 4MBL3 ĳ�� : 16MB','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'PRIME A520M-K ','���� : AMD-����AM4�԰� : mATX�޸� ���� : DDR4, DDR4-4600MHz�޸� ���� : 2���ִ� �޸� : 64GBVGA ���� : D-SUB, HDMIȮ�彽�� : PCI Express 3.0 x16','ASUS',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'Crucial DDR4-3200 CL22 (8GB) ','�뵵 : ����ũž��(DIMM)�޸𸮹�� : DDR4���ۼӵ� : 3,200MHz(PC4-25,600)���� : 1.2V','����ũ��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'G20 ���� ��ȭ���� (��)','�� / �̴�Ÿ�� / ���� �� 165mm / ���� �� 2�� ����','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'SAVEMOST 500W ��','���� : ATX�Ŀ�������� : ����������� : 500W����Ŀ���� : 24��PCI-EĿ���� : PCI-E(6+2��) x 2��SATAĿ���� : 4��','��ũ�÷���',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'�ھ�i9-14���� 14900K (���ͷ���ũ ��������) ','�����ھ� : ���ͷ���ũ�ھ����� : 24�ھ���� : 1700������������ : 10nm�⺻Ŭ�� : 3.2GHz������ : 32������L3 ĳ�� : 33MB�ھ�(�׷���ī��) : 8�ھ�','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,8,'A360 ARGB','��� : FDB���CPU���� : AMD ����AM4, AMD ����AM5, 115x(1150,1151,1155,1156),','��Ű��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'Z790 PG Lightning D5 ������','Ĩ�� : ���� Z790���� : 1700���ϱ԰� : ATX�ִ� �޸� : 128GB�޸� ���� : DDR5�޸� ���� : 4��VGA ���� : HDMI, DisplayPortȮ�彽�� : PCI-Express5.0','ASRock',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX A6000 D6 48GB','�޸� ���� : GDDR6��� ���μ��� : 10752���������̽� : PCI-Express4.0(x16)�޸� : 48GB�޸� �뿪�� : 384bitĨ�� : �����RTX A6000���� : DisplayPort(4��)','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Platinum P41 M.2 NVMe (2TB)','�԰� : M.2(2280)NAND : TLC�б� : 7,000Mb/s���� : 4,700Mb/s�ΰ���� : S.M.A.R.T., TRIM����, GC, AES256bit, �����������̽� : PCI-Express4.0, x4���� : 8cmRAM : LPDDR4','SK���̴н�',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'P20C ELITE 6FAN METAL MESH ��ȭ����','�� / �̵�Ÿ�� / ���� �� 170mm / ���� �� 2,3�� ����','Antec',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'UPMOST 1050W 80PLUS��� Ǯ��ⷯ ATX3.0 ��
','���� : ATX�Ŀ�������� : ����������� : 1,050W��ȿ���Ŀ� : ������Ŀ���� : 20+4��PCI-EĿ���� : PCI-E(6+2��) x 3��SATAĿ���� : 8���ΰ���� : +12V�̱۷���','��ũ�÷���',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,8,'TG-360 ARGB (��)','CPU���� : AMD ����AM4, AMD ����AM5, ���� LGA1151, ���� LGA1156, ���� LGA1200, ���� LGA1700, ���� LGA2011, ���� LGA2011-V3, ���� LGA2066���� �β� : 25T','JONSBO',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'MAG B760M �ڰ��� II','Ĩ�� : B760���� : 1700���ϱ԰� : Micro-ATX�ִ� �޸� : 256GB�޸� ���� : DDR5,','MSI',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'
RTX 5070 SOLID OC D7 12GB
','�޸� ���� : GDDR7�ν�ƮŬ�� : 2542MHz��� ���μ��� : 6144���������̽� : PCI-Express5.0(x16)�ν�Ʈ : GPU�ν�Ʈ�޸� : 12GB','ZOTAC',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Crucial P3 Plus M.2 NVMe (1TB)
','�԰� : M.2(2280)�б� : 4700Mb/s���� : 1900Mb/s�ΰ���� : S.M.A.R.T., DEVSLP, TRIM����, GC, ECC�����������̽� : PCI-Express4.0, x4���� : 8cm','����ũ��',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'UH40 ų������ ARGB','ǰ�� : �̵�Ÿ�����̽����κ��� �԰� : ATX, Micro-ATX, Mini-ITX�Ŀ��԰� : ATX�Ŀ����� : �ĸ��ϴ������Ŀ� ���� : �Ŀ� ����2.5���� : 3��3.5���� : 2��','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'Classic II Ǯü���� 800W 80PLUS����� ATX3.1
','���� : ATX�Ŀ�������� : ����������� : 800W��ȿ���Ŀ� : ��������Ŀ���� : 20+4��PCI-EĿ���� : PCI-E(6+2��) x 2��, PCI-E(12+4��) x 1��SATAĿ���� : 8��','����ũ�δн�',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'������5-4���� 5625U(2.3GHz)','CPU ������	AMD	CPU ���з�	������5-4����
CPU �ڵ��	�ٸ�����	CPU �ѹ�	5625U (2.3GHz)
CPU �ھ�	���(6)�ھ�	CPU ������	12','AMD',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'DDR4 8G','�뷮 : 16GB','�Ｚ',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'Radeon Graphics','GPU ����	����׷���	GPU ������	AMD
GPU Ĩ��	Radeon Graphics	','AMD',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'M.2(NVMe)','������ġ ����	M.2(NVMe)	�뷮	256GB
���� ����	1��	','AMD',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'�ھ�i7-13���� i7-13620H (2.4GHz)','CPU ������','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX4060','GPU ����	����׷���	GPU ������	������
GPU Ĩ��	RTX4060	GPU TOPS	233 AI TOPS
GPU �޸�	VRAM:8GB	TGP	105W
���� ���� ���	MUX ����ġ		','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'DDR5 8G','�� Ÿ��	DDR5	��	16GB
�� ����	�� 2��	�� ����	���(8G+8G)
�� �ִ�뷮	64GB	�� ��ü	����','�Ｚ',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'W-2223','CPU Ư¡
CPU ������	����	CPU �ø���	����
CPU ����	����	CPU �ڵ��	ĳ�����̵巹��ũ
�ھ� ����	����(4)�ھ�	���� CPU ����	CPU :1��
�ִ� ���� ���� CPU	1��		
CPU ���
ECC	��	�ͺ��ν�Ʈ	��
�����۽�����	��','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX 4070 TI','�޸� ���� : GDDR6X�ν�ƮŬ�� : 2670MHz��� ���μ��� : 8448���������̽� : PCI-Express4.0�ν�Ʈ : GPU�ν�Ʈ�޸� : 16GB�޸� �뿪�� : 256bit','������',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'C422','��ũ�����̼� ���κ���
�ھ�� : 1��
�޸� ���� : 8��','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'C621','��ũ�����̼�
CPU ���� : 2��
�޸� ���� : 12��','����',null,0,1001,to_date('25/07/24','RR/MM/DD'));

SET DEFINE ON;
COMMIT;


/************************************************** 
 *  ��ǰ : PRODUCT
 **************************************************/
SET DEFINE OFF;

Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'AMD R5-7500F','7500F/RTX 5060 Ti/(AMD) B650/OS������/700W/AMD/������ 7000�ø���/������5/���Ŀ�/DDR5/16GB/M.2/500GB/NVIDIA/1Gbps ����/HDMI/DP��Ʈ/�Ŀ����ö���/�̵�Ÿ��/������/LED��/�뵵: ���ӿ�',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'AMD R3-3200G/����VGA/16G
','CPU
AMD ������3-2���� 3200G (��ī��) (��Ƽ��(��ǰ))
CPU��
�⺻��
���κ���
MSI A520M-A PRO
�޸�
����ũ�� Crucial DDR4-3200 CL22 �����Ƽ���� (16GB) 8GB x 2
�׷���ī��
������ VGA
SSD
����ũ�� Crucial P3 Plus M.2 NVMe �����Ƽ���� (500GB)
���̽�
���̹� LIMPID Micro-1 (��)
�Ŀ�
�ƽ�����Ʈ MAXWELL PRIMO 500W 80PLUS STANDARD �÷�
�ü��
������
�����
������',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'����i7-14700F/RTX5070/32G','AMD ������3-2���� 3200G (��ī��) (��Ƽ��(��ǰ))',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'AMD R7-5700G/����VGA/16G','CPU
AMD ������7-4���� 5700G (����) (��Ƽ��(��ǰ))
CPU��
�⺻��
���κ���
MSI A520M-A PRO
�޸�
����ũ�� Crucial DDR4-3200 CL22 �����Ƽ���� (16GB) 8GB x 2
�׷���ī��
������ VGA
SSD
����ũ�� Crucial P3 Plus M.2 NVMe �����Ƽ���� (500GB)
���̽�
���� G15 ������ ��ũ��
�Ŀ�
�ƽ�����Ʈ MAXWELL PRIMO 500W 80PLUS STANDARD �÷�
�ü��
Microsoft Windows 11 Home (OEM ���̼���)
�����
AONE AD240 FHD ������ũ HDR ������',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'���� i9-14900K/RTX A6000/64G','CPU
���� �ھ�i9-14���� 14900K (���ͷ���ũ ��������) (��ǰ)
CPU��
��Ű�� A360 ARGB (BLACK)
���κ���
ASRock Z790 PG Lightning D5 ������
�޸�
����ũ�� Crucial DDR5-5600 CL46 �����Ƽ���� (64GB) 32G x 2
�׷���ī��
NVIDIA RTX A6000 D6 48GB
SSD
SK���̴н� Platinum P41 M.2 NVMe (2TB)
���̽�
Antec P20C ELITE 6FAN METAL MESH ��ȭ���� (��)
�Ŀ�
darkFlash UPMOST 1050W 80PLUS GOLD FULL MODULAR ATX3.0 (PCIE5) ��
�ü��
������
�����
������',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'���� i9-14900K/RTX5070/32G','CPU
���� �ھ�i9-14���� 14900K (���ͷ���ũ ��������) (��ǰ)
CPU��
���� P360 POSEIDON ARGB (��)
���κ���
MSI PRO Z790-A �ƽ� WIFI
�޸�
����ũ�� Crucial DDR5-5600 CL46 �����Ƽ���� (32GB) 16GB x 2
�׷���ī��
MSI ������ RTX 5070 Ti ������ 3X OC D7 16GB
SSD
����ũ�� Crucial P3 Plus M.2 NVMe �����Ƽ���� (1TB)
���̽�
���� UD50 ������ ARGB BTF (��)
�Ŀ�
�߸� GigaMax III 850W 80PLUS����� ��ⷯ ATX3.1
�ü��
������
�����
������',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,1,'���̵���е� Slim1-15ALC R5B WIN11 16GB�� (SSD 256GB)','[CPU]
CPU ������	AMD	CPU ���з�	������5-4����
CPU �ڵ��	�ٸ�����	CPU �ѹ�	5625U (2.3GHz)
CPU �ھ�	���(6)�ھ�	CPU ������	12
[�׷���]
GPU ����	����׷���	GPU ������	AMD
GPU Ĩ��	Radeon Graphics		
[����]
�� Ÿ��	DDR4	��	16GB
�� ����	�� 2��	�� ����	���(8G+8G)
�� �뿪��	3200MHz	�� ��ü	����(1����)
[������ġ]
������ġ ����	M.2(NVMe)	�뷮	256GB
���� ����	1��	',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,1,'GF�ø��� Sword GF76 B13VFK (SSD 512GB)','[CPU]
CPU ������	����	CPU ���з�	�ھ�i7-13����
CPU �ڵ��	���ͷ���ũ	CPU �ѹ�	i7-13620H (2.4GHz)
CPU �ھ�	10�ھ�(6P+4E)	CPU ������	16
[�׷���]
GPU ����	����׷���	GPU ������	������
GPU Ĩ��	RTX4060	GPU TOPS	233 AI TOPS
GPU �޸�	VRAM:8GB	TGP	105W
���� ���� ���	MUX ����ġ		
[����]
�� Ÿ��	DDR5	��	16GB
�� ����	�� 2��	�� ����	���(8G+8G)
�� �ִ�뷮	64GB	�� ��ü	����
[������ġ]
������ġ ����	M.2(NVMe)	�뷮	512GB
���� ����	2��		
',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,2,'5820T W-2223 RTX4070Ti Win11Pro (8GB, M.2 512GB)','����ȸ��	DELL ��������	��ϳ��	2024�� 04��
CPU �ѹ�	W-2223	�׷��� ī��	������ RTX 4070 Ti
���κ��� Ĩ��	(����) C422	�ü��	������11 ����
�Ŀ� ���	950W	��ǰ�з�	��ũ�����̼�
CPU Ư¡
CPU ������	����	CPU �ø���	����
CPU ����	����	CPU �ڵ��	ĳ�����̵巹��ũ
�ھ� ����	����(4)�ھ�	���� CPU ����	CPU :1��
�ִ� ���� ���� CPU	1��		
CPU ���
ECC	��	�ͺ��ν�Ʈ	��
�����۽�����	��		
�޸�
�޸� Ÿ��	DDR4	�޸� �뷮	8GB
�޸� ����	8��		
������ġ
SSD ����	M.2	SSD �뷮	512GB
',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,2,'E900 G4 (���)','����ȸ��	ASUS (������ ������Ʈ �ٷΰ���)	��ϳ��	2020�� 03��
���κ��� Ĩ��	(����) C621	�ü��	OS������
�Ŀ� ���	2000W	��ǰ�з�	��ũ�����̼�
CPU Ư¡
CPU ������	����	CPU ����	CPU ������
���� CPU ����	CPU :������	�ִ� ���� ���� CPU	2��
�޸�
�޸� Ÿ��	DDR4	�޸� �뷮	�޸� ������
�޸� ����	12��	�޸� �ִ�뷮	1536GB',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));

SET DEFINE ON;
COMMIT;

/************************************************** 
 *  ��ǰ_BOM : PRODUCT_BOM
 **************************************************/
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (1,1,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (1,2,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (1,3,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (1,4,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (1,5,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (1,6,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (1,7,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (1,8,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (3,9,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (3,10,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (3,11,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (3,4,2);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (3,13,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (3,14,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (3,15,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (3,16,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (2,17,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (2,18,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (2,19,2);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (2,20,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (2,21,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (2,22,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (2,23,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (2,8,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (4,24,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (4,25,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (4,26,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (4,27,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (4,28,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (4,8,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (4,20,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (4,19,2);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (5,29,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (5,30,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (5,31,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (5,32,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (5,33,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (5,34,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (5,35,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (5,4,2);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (6,36,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (6,37,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (6,38,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (6,39,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (6,40,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (6,41,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (6,4,2);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (6,29,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (7,42,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (7,43,2);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (7,44,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (7,45,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (8,46,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (8,47,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (8,48,2);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (8,45,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (9,49,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (9,50,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (9,43,8);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (9,51,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (10,52,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (10,43,12);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (10,50,1);
Insert into PRODUCT_BOM (PRODUCT_NO,PARTS_NO,CNT) values (10,45,1);

COMMIT;

/************************************************** 
 *  ����� : MONTH_INVENTORY
 **************************************************/
-- 2406 �⸻���
INSERT INTO month_inventory VALUES ('2406', 1, 0, 1, 100, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 0, 2, 150, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 0, 3, 150, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 0, 4, 200, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 0, 5, 100, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 1, 1, 150, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 1, 2, 100, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 1, 3, 200, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 1, 4, 300, sysdate);
INSERT INTO month_inventory VALUES ('2406', 1, 1, 5, 250, sysdate);
-- 2407 �������
INSERT INTO month_inventory VALUES ('2407', 0, 0, 1, 100, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 0, 2, 150, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 0, 3, 150, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 0, 4, 200, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 0, 5, 100, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 1, 1, 150, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 1, 2, 100, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 1, 3, 200, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 1, 4, 300, sysdate);
INSERT INTO month_inventory VALUES ('2407', 0, 1, 5, 250, sysdate);

/************************************************** 
 *  ���Ҹ��� : INVENTORY_CLOSE
 **************************************************/
INSERT INTO inventory_close VALUES ('2406', 2, TO_DATE('20250630 18:00:00', 'YYYYMMDD HH24:MI:SS'), TO_DATE('20250630 18:30:00', 'YYYYMMDD HH24:MI:SS'), 1); -- �����Ϸ�
INSERT INTO inventory_close VALUES ('2407', 1, sysdate, sysdate, 1);

/************************************************** 
 *  ��ǰ���ݺ����̷� : PRODUCT_COSTHIS
 **************************************************/
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 1, TO_DATE('20250601', 'YYYYMMDD'), TO_DATE('20250609', 'YYYYMMDD'), 1200000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 1, TO_DATE('20250609', 'YYYYMMDD'), null, 1000000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 2, TO_DATE('20250601', 'YYYYMMDD'), TO_DATE('20250614', 'YYYYMMDD'), 1490000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 2, TO_DATE('20250614', 'YYYYMMDD'), TO_DATE('20250704', 'YYYYMMDD'), 1290000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 2, TO_DATE('20250704', 'YYYYMMDD'), null, 1200000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 3, TO_DATE('20250601', 'YYYYMMDD'), TO_DATE('20250624', 'YYYYMMDD'), 2000000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 3, TO_DATE('20250624', 'YYYYMMDD'), TO_DATE('20250711', 'YYYYMMDD'), 2500000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 3, TO_DATE('20250711', 'YYYYMMDD'), null, 2300000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 4, TO_DATE('20250601', 'YYYYMMDD'), null, 2000000);
INSERT INTO product_costhis VALUES (PRODUCT_COSTHIS_SEQ.nextval, 5, TO_DATE('20250601', 'YYYYMMDD'), null, 890000);

/************************************************** 
 *  ��ǰ���ݺ����̷� : PARTS_COSTHIS
 **************************************************/
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 1, TO_DATE('20250601', 'YYYYMMDD'), TO_DATE('20250717', 'YYYYMMDD'), 250000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 1, TO_DATE('20250717', 'YYYYMMDD'), null, 300000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 2, TO_DATE('20250601', 'YYYYMMDD'), TO_DATE('20250630', 'YYYYMMDD'), 120000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 2, TO_DATE('20250630', 'YYYYMMDD'), TO_DATE('20250720', 'YYYYMMDD'), 180000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 2, TO_DATE('20250720', 'YYYYMMDD'), null, 150000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 3, TO_DATE('20250601', 'YYYYMMDD'), TO_DATE('20250604', 'YYYYMMDD'), 90000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 3, TO_DATE('20250604', 'YYYYMMDD'), TO_DATE('20250701', 'YYYYMMDD'), 80000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 3, TO_DATE('20250701', 'YYYYMMDD'), null, 90000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 4, TO_DATE('20250601', 'YYYYMMDD'), null, 60000);
INSERT INTO parts_costhis VALUES (PARTS_COSTHIS_SEQ.nextval, 5, TO_DATE('20250601', 'YYYYMMDD'), null, 800000);

/************************************************** 
 *  ���Խ��� : PURCHASE_PERFORM
 **************************************************/
INSERT INTO purchase_perform VALUES ('2506', 1, 10, 3000000);
INSERT INTO purchase_perform VALUES ('2506', 2, 5, 750000);
INSERT INTO purchase_perform VALUES ('2506', 3, 8, 720000);
INSERT INTO purchase_perform VALUES ('2506', 4, 75, 4500000);
INSERT INTO purchase_perform VALUES ('2506', 5, 20, 16000000);
INSERT INTO purchase_perform VALUES ('2507', 1, 0, 0);
INSERT INTO purchase_perform VALUES ('2507', 2, 2, 300000);
INSERT INTO purchase_perform VALUES ('2507', 3, 8, 720000);
INSERT INTO purchase_perform VALUES ('2507', 4, 20, 1200000);
INSERT INTO purchase_perform VALUES ('2507', 5, 11, 8800000);

/************************************************** 
 *  ������� : SALES_PERFORM
 **************************************************/
INSERT INTO sales_perform VALUES ('2506', 1, 5, 5000000);
INSERT INTO sales_perform VALUES ('2506', 2, 12, 15600000);
INSERT INTO sales_perform VALUES ('2506', 3, 1, 2300000);
INSERT INTO sales_perform VALUES ('2506', 4, 3, 6000000);
INSERT INTO sales_perform VALUES ('2506', 5, 10, 8900000);
INSERT INTO sales_perform VALUES ('2507', 1, 0, 0);
INSERT INTO sales_perform VALUES ('2507', 2, 6, 7800000);
INSERT INTO sales_perform VALUES ('2507', 3, 1, 2300000);
INSERT INTO sales_perform VALUES ('2507', 4, 5, 10000000);
INSERT INTO sales_perform VALUES ('2507', 5, 7, 6230000);

COMMIT;

/************************************************** 
 *  �ŷ�ó : CLIENT
 **************************************************/
INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1001, 1003, '��ǰ����', 0,
    'sales@bupumnara.com', '�����', '���� ������', '010-9923-1234',
     0, NULL, TO_DATE('2025-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS ,MODIFY_DATE, IN_DATE
) VALUES (
    1002, 1003, '�������', 0,
    'sales@moduparts.co.kr', '�ڼ���', '���� ��걸', '010-9349-1223',
    0, NULL, TO_DATE('2025-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1003, 1003, '�ٷ�����', 0,
    'sales@baroparts.kr', '�輺��', '���� ��걸', '010-2494-9923',
    0, NULL, TO_DATE('2025-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1004, 1003, '�Ѻ���ǰ', 0,
    'sales@hanbitparts.co.kr', '�̹���', '���� ��걸', '010-3360-2323',
    0, NULL, TO_DATE('2025-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1005, 1003, 'Ƽ����', 0,
    'sales@tnp.parts', '�ּ���', '���� ������', '010-3045-9239',
    0, NULL, TO_DATE('2025-07-04', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1006, 1003, '������ũ', 0,
    'sales@partslink.co.kr', '�輺��', '���� ���α�', '010-1223-9323',
    0, NULL, TO_DATE('2024-07-04', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1007, 1003, '��κ�ǰ', 0,
    'sales@modu.kr', '������', '��õ ��籸', '010-9283-2939',
    0, NULL, TO_DATE('2022-03-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1008, 1003, '����������', 0,
    'sales@masterparts.kr', '�輺��', '���� ������', '010-4304-9313',
    0, NULL, TO_DATE('2021-05-11', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1009, 1003, '�Ŀ�������Ʈ', 0,
    'sales@power.kr', '���ֿ�', '������ ��ȱ�', '010-7583-9212',
    0, NULL, TO_DATE('2022-03-13', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1010, 1003, '�������', 0,
    'sales@yogiparts.kr', '����ȣ', '���� ��걸', '010-9232-1923',
    0, NULL, TO_DATE('2021-11-28', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2001, 1003, '��ũ��ǰ', 1,
    'purchase@techparts.com', '���¿�', '���� ��õ��', '010-2032-1203',
    0, NULL, TO_DATE('2021-07-16', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2002, 1003, '��������', 1,
    'purchase@ezparts.kr', '������', '���� ���α�', '010-9596-9232',
    0, NULL, TO_DATE('2024-07-10', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2003, 1003, '����Ʈ���', 1,
    'purchase@smartmod.co.kr', '������', '���� ��õ��', '010-2392-2932',
    0, NULL, TO_DATE('2024-07-14', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2004, 1003, 'žĿ��Ʈ', 1,
    'purchase@topconnect.kr', '������', '��� ����', '010-3423-1223',
    0, NULL, TO_DATE('2022-07-09', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2005, 1003, '�������', 1,
    'purchase@autoline.kr', '������', '��õ ������', '010-9242-1223',
    0, NULL, TO_DATE('2024-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2006, 1003, '�׿�����', 1,
    'purchase@neoparts.kr', '���¸�', '���� ���۱�', '010-3388-3234',
    0, NULL, TO_DATE('2024-03-02', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2007, 1003, 'ž�̳���', 1,
    'purchase@topinotech.com', '��ȣ��', '���� ��õ��', '010-9233-9232',
    0, NULL, TO_DATE('2024-02-14', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2008, 1003, '��������', 1,
    'purchase@gmparts.kr', '����ȭ', '���� ������', '010-9323-1223',
    0, NULL, TO_DATE('2024-01-14', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2009, 1003, '�ٿ�����', 1,
    'purchase@daon.co.kr', '������', '��� ������', '010-5676-7666',
    0, NULL, TO_DATE('2024-07-15', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2010, 1003, '�̳��Ŀ�', 1,
    'purchase@innopower.kr', '������', '��� �Ⱦ��', '010-2293-1223',
    0, NULL, TO_DATE('2022-07-19', 'YYYY-MM-DD')
);

COMMIT;

/************************************************** 
 *  �ŷ�ó�̷� : CLIENT_HIS
 **************************************************/
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2002, '20240710', '99991231', 1003,
     '��������',   1, '������', 'purchase@ezparts.kr', '010-9596-9232', '���� ���α�', TO_DATE('2024/07/10','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1001, '20250724', '99991231', 1003,
     '��ǰ����',   0, '�����', 'sales@bupumnara.com', '010-9923-1234', '���� ������', TO_DATE('2025/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1002, '20250724', '99991231', 1003,
     '�������',   0, '�ڼ���', 'sales@moduparts.co.kr', '010-9349-1223', '���� ��걸', TO_DATE('2025/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1003, '20250724', '99991231', 1003,
     '�ٷ�����',   0, '�輺��', 'sales@baroparts.kr', '010-2494-9923', '���� ��걸', TO_DATE('2025/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1004, '20250724', '99991231', 1003,
     '�Ѻ���ǰ',   0, '�̹���',  'sales@hanbitparts.co.kr', '010-3360-2323','���� ��걸', TO_DATE('2025/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1005, '20240704', '99991231', 1003,
     'Ƽ����', 0, '�ּ���', 'sales@tnp.parts', '010-3045-9239', '���� ������', TO_DATE('2024/07/04','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1006, '20240704', '99991231', 1003,
     '������ũ',   0, '�輺��', 'sales@partslink.co.kr', '010-1223-9323', '���� ���α�', TO_DATE('2024/07/04','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1007, '20220324', '99991231', 1003,
     '��κ�ǰ',   0, '������', 'sales@modu.kr', '010-9283-2939', '��õ ��籸', TO_DATE('2022/03/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1008, '20210511', '99991231', 1003,
     '����������', 0, '�輺��', 'purchase@masterparts.kr', '010-4304-9313', '���� ������', TO_DATE('2021/05/11','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1009, '20220313', '99991231', 1003,
     '�Ŀ�������Ʈ',0, '���ֿ�', 'sales@power.kr', '010-7583-9212', '������ ��ȱ�', TO_DATE('2022/03/13','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1010, '20211128','99991231', 1003,
     '�������', 0, '����ȣ', 'sales@yogiparts.kr', '010-9232-1923',  '���� ��걸', TO_DATE('2021/11/28','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2001, '20210716', '99991231', 1003,
     '��ũ��ǰ',   1, '���¿�', 'purchase@techparts.com', '010-2032-1203', '���� ��õ��', TO_DATE('2021/07/16','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2003, '20240701', '99991231', 1003,
     '����Ʈ���', 1, '������', 'purchase@smartmod.co.kr', '010-2392-2932','���� ��õ��', TO_DATE('2024/07/14','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2004, '20240709', '99991231', 1003,
     'žĿ��Ʈ',   1, '������',  'purchase@topconnect.kr', '010-3423-1223','��� ����', TO_DATE('2024/07/09','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2005, '20240724', '99991231', 1003,
     '�������',   1, '������', 'purchase@autoline.kr','010-9242-1223','��õ ������', TO_DATE('2024/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2006, '20240302', '99991231', 1003,
     '�׿�����',   1, '���¸�', 'purchase@neoparts.kr','010-3388-3234', '���� ���۱�', TO_DATE('2024/03/02','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2007, '20240214', '99991231', 1003,
     'ž�̳���',   1, '��ȣ��', 'purchase@topinotech.com', '010-9233-9232', '���� ��õ��', TO_DATE('2024/02/14','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2008, '20240114', '99991231', 1003,
     '��������', 1, '����ȭ', 'purchase@gmparts.kr', '010-9323-1223','���� ����', TO_DATE('2024/01/14','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2009, '20240715','99991231', 1003,
     '�ٿ�����', 1, '������', 'purchase@daon.co.kr', '010-5676-7666','��� ������', TO_DATE('2024/07/15','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2010, '20220719','99991231', 1003,
     '�̳��Ŀ�',   1, '������',  'purchase@innopower.kr', '010-2293-1223','��� �Ⱦ��', TO_DATE('2022/07/19','YYYY/MM/DD'))
     ;

COMMIT;


/************************************************** 
 *  �ŷ�ó������ : CLIENT_PERFORM
 **************************************************/
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2507', 1001, 3,   300000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2507', 1002, 5,   750000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2506', 1003, 2,   200000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2506', 1005, 4,   400000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2505', 1007, 1,   120000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2504', 1008, 7,   840000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2502', 1010, 8,  1600000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2501', 2001, 2,   220000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2507', 2003, 9,  1800000);
    INSERT INTO CLIENT_PERFORM (YEARMONTH, CLIENT_NO, CNT, TOTAL_AMT)
    VALUES ('2503', 2004, 6,   900000);
COMMIT;

/************************************************** 
 *  ���� : PURCHASE_ORDER
 **************************************************/
INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4101, 1001, 1003, TO_DATE('2025-07-20', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4102, 1002, 1003, TO_DATE('2025-07-18', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-08-04', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4103, 1003, 1003, TO_DATE('2025-07-17', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4104, 1004, 1003, TO_DATE('2025-07-16', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4105, 1005, 1003, TO_DATE('2025-07-15', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-08-02', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4106, 1006, 1003, TO_DATE('2025-07-13', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-08-03', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4107, 1007, 1003, TO_DATE('2025-07-12', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4108, 1008, 1003, TO_DATE('2025-07-11', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-07-31', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4109, 1009, 1003, TO_DATE('2025-07-09', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-07-31', 'YYYY-MM-DD'));

INSERT INTO PURCHASE_ORDER (PURCHASE_NO, CLIENT_NO, EMP_NO, PURCHASE_DATE, IN_STATUS, DEL_STATUS, IN_DATE)
VALUES (4110, 1010, 1003, TO_DATE('2025-07-08', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-07-31', 'YYYY-MM-DD'));

COMMIT;

/************************************************** 
 *  ���ֺ�ǰ : PURCHASE_ITEM
 **************************************************/
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4101, 1, 10, 10, 1500);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4101, 2, 5, 5, 3000);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4102, 3, 20, 20, 500);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4103, 4, 15, 15, 1500);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4104, 5, 8, 8, 2500);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4105, 6, 12, 12, 1800);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4106, 7, 6, 6, 2200);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4107, 8, 25, 25, 500);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4108, 9, 10, 10, 3000);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4109, 10, 4, 4, 4500);
INSERT INTO PURCHASE_ITEM (PURCHASE_NO, PARTS_NO, PURCHASE_ITEM_CNT, PURCHASE_ITEM_INCNT, PURCHASE_ITEM_COST) VALUES (4110, 11, 7, 7, 3500);

COMMIT;

/************************************************** 
 *  ���� : SALES_ORDER
 **************************************************/
INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3001, 2001, 1003, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-08-01', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3002, 2002, 1003, TO_DATE('2024-07-03', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-08-03', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3003, 2003, 1003, TO_DATE('2024-07-05', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-07-05', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3004, 2004, 1003, TO_DATE('2024-07-07', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-07-07', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3005, 2005, 1003, TO_DATE('2024-07-09', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-07-09', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3006, 2006, 1003, TO_DATE('2024-07-10', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-07-10', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3007, 2007, 1003, TO_DATE('2024-07-11', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-07-11', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3008, 2008, 1003, TO_DATE('2024-07-12', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-07-12', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3009, 2009, 1003, TO_DATE('2024-07-13', 'YYYY-MM-DD'), 1, 0, TO_DATE('2025-07-13', 'YYYY-MM-DD'));

INSERT INTO SALES_ORDER (SALES_NO, CLIENT_NO, EMP_NO, SALES_DATE, OUT_STATUS, DEL_STATUS, IN_DATE) VALUES
(3010, 2010, 1003, TO_DATE('2024-07-14', 'YYYY-MM-DD'), 0, 0, TO_DATE('2025-07-14', 'YYYY-MM-DD'));

COMMIT;

/************************************************** 
 *  ������ǰ : SALES_ITEM
 **************************************************/
INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3001, 1, 10, 5, 1200);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3002, 2, 8, 8, 980);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3003, 3, 15, 0, 1500);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3004, 4, 20, 20, 1150);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3005, 5, 12, 6, 1050);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3006, 6, 30, 30, 990);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3007, 7, 25, 25, 1110);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3008, 8, 18, 10, 980);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3009, 9, 9, 9, 1490);

INSERT INTO SALES_ITEM (SALES_NO, PRODUCT_NO, SALES_ITEM_CNT, SALES_ITEM_OUTCNT, SALES_ITEM_COST)
VALUES (3010, 10, 14, 0, 1190);


COMMIT;

