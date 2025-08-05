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
 *  공통 : COMMON
 **************************************************/
INSERT INTO common VALUES (100, 999, '삭제구분');
INSERT INTO common VALUES (100, 0, '활성');
INSERT INTO common VALUES (100, 1, '삭제');

INSERT INTO common VALUES (200, 999, '권한');
INSERT INTO common VALUES (200, 0, 'ROLE_ADMIN');
INSERT INTO common VALUES (200, 1, 'ROLE_MANAGER');
INSERT INTO common VALUES (200, 2, 'ROLE_USER');

INSERT INTO common VALUES (300, 999, '거래처유형');
INSERT INTO common VALUES (300, 0, '구매처');
INSERT INTO common VALUES (300, 1, '판매처');

INSERT INTO common VALUES (400, 999, '발주상태');
INSERT INTO common VALUES (400, 0, '요청');
INSERT INTO common VALUES (400, 1, '승인');
INSERT INTO common VALUES (400, 2, '완료');
INSERT INTO common VALUES (400, 3, '마감');

INSERT INTO common VALUES (500, 999, '수주상태');
INSERT INTO common VALUES (500, 0, '요청');
INSERT INTO common VALUES (500, 1, '승인');
INSERT INTO common VALUES (500, 2, '완료');
INSERT INTO common VALUES (500, 3, '마감');

INSERT INTO common VALUES (600, 999, '부품/제품 구분');
INSERT INTO common VALUES (600, 0, '부품');
INSERT INTO common VALUES (600, 1, '제품');

INSERT INTO common VALUES (700, 999, '마감 구분');
INSERT INTO common VALUES (700, 0, '마감시작');
INSERT INTO common VALUES (700, 1, '마감완료');
INSERT INTO common VALUES (700, 2, '월마감완료');

INSERT INTO common VALUES (800, 999, '제품 분류');
INSERT INTO common VALUES (800, 0, '데스크탑');
INSERT INTO common VALUES (800, 1, '노트북');
INSERT INTO common VALUES (800, 2, '워크스테이션');

INSERT INTO common VALUES (900, 999, '부품 분류');
INSERT INTO common VALUES (900, 0, '메인보드');
INSERT INTO common VALUES (900, 1, 'CPU');
INSERT INTO common VALUES (900, 2, 'GPU');
INSERT INTO common VALUES (900, 3, '메모리;');
INSERT INTO common VALUES (900, 4, 'POWER');
INSERT INTO common VALUES (900, 5, 'HDD');
INSERT INTO common VALUES (900, 6, 'SSD');
INSERT INTO common VALUES (900, 7, 'CASE');
INSERT INTO common VALUES (900, 8, 'COOLER');

INSERT INTO common VALUES (1000, 999, '호환성 여부');
INSERT INTO common VALUES (1000, 0, '미확인');
INSERT INTO common VALUES (1000, 1, '호환가능');
INSERT INTO common VALUES (1000, 2, '호환불가능');

INSERT INTO common VALUES (1100, 999, '수주/발주 구분');
INSERT INTO common VALUES (1100, 0, '수주');
INSERT INTO common VALUES (1100, 1, '발주');

COMMIT;

/************************************************** 
 *  부서 : DEPT
 **************************************************/

--특수문자 & 인식 해제 후 사용(끝나면 ON)
SET DEFINE OFF;

-- 최상위 부서 (본부)
INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1000, '경영본부', 1001, NULL, '서울 본사 10층', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (2000, '기술본부', 1009, NULL, '판교 R&D 센터 5층', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (3000, '사업본부', 1002, NULL, '서울 본사 11층', 0, 1001, SYSDATE);

-- 경영본부(1000) 산하 팀
INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1001, '인사팀', 1005, 1000, '서울 본사 10층', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1002, '재무팀', 1008, 1000, '서울 본사 10층', 0, 1001, SYSDATE);

-- 기술본부(2000) 산하 팀
INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (2001, '플랫폼개발팀', 1009, 2000, '판교 R&D 센터 5층', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (2002, '모바일개발팀', 1007, 2000, '판교 R&D 센터 6층', 0, 1001, SYSDATE);

-- 사업본부(3000) 산하 팀
INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (3001, '국내영업팀', 1003, 3000, '서울 본사 11층', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (3002, '해외영업팀', 1006, 3000, '서울 본사 11층', 0, 1001, SYSDATE);

INSERT INTO dept (DEPT_CODE, DEPT_NAME, DEPT_CAPTAIN, PARENT_DEPT_CODE, DEPT_LOC, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (3003, '마케팅팀', 1002, 3000, '서울 본사 12층', 0, 1001, SYSDATE);

COMMIT;

SET DEFINE ON;

/************************************************** 
 *  사원 : EMP
 **************************************************/
-- 1. 김철수 -> 플랫폼개발팀(2001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1001, '김철수', '010-1111-2222', 'cskim@company.com', 90000000, 2001, 'cskim', 'hashed_password_placeholder', 'ROLE_ADMIN', 0, 1001, SYSDATE);

-- 2. 이영희 -> 마케팅팀(3003)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1002, '이영희', '010-2222-3333', 'yhlee@company.com', 75000000, 3003, 'yhlee', 'hashed_password_placeholder', 'ROLE_MANAGER', 0, 1001, SYSDATE);

-- 3. 박지성 -> 국내영업팀(3001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1003, '박지성', '010-3333-4444', 'jspark@company.com', 55000000, 3001, 'jspark', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 4. 최민준 -> 플랫폼개발팀(2001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1004, '최민준', '010-4444-5555', 'mjchoi@company.com', 60000000, 2001, 'mjchoi', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 5. 정수빈 -> 인사팀(1001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1005, '정수빈', '010-5555-6666', 'sbjeong@company.com', 48000000, 1001, 'sbjeong', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 6. 강은지 -> 해외영업팀(3002)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1006, '강은지', '010-6666-7777', 'ejkang@company.com', 52000000, 3002, 'ejkang', 'hashed_password_placeholder', 'ROLE_USER', 0, 1002, SYSDATE);

-- 7. 윤현우 -> 모바일개발팀(2002)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1007, '윤현우', '010-7777-8888', 'hwyun@company.com', 61000000, 2002, 'hwyun', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 8. 임서연 -> 재무팀(1002)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1008, '임서연', '010-8888-9999', 'syim@company.com', 50000000, 1002, 'syim', 'hashed_password_placeholder', 'ROLE_USER', 0, 1002, SYSDATE);

-- 9. 한지훈 -> 플랫폼개발팀(2001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1009, '한지훈', '010-9999-0000', 'jhhan@company.com', 82000000, 2001, 'jhhan', 'hashed_password_placeholder', 'ROLE_MANAGER', 0, 1001, SYSDATE);

-- 10. 송예은 -> 인사팀(1001)
INSERT INTO emp (EMP_NO, EMP_NAME, EMP_TEL, EMAIL, SAL, DEPT_CODE, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, REGISTRAR, IN_DATE)
VALUES (1010, '송예은', '010-0000-1111', 'yesong@company.com', 47000000, 1001, 'yesong', 'hashed_password_placeholder', 'ROLE_USER', 0, 1001, SYSDATE);

-- 가상 관리자 사원(100:ADMIN) 초기 정보 등록
INSERT INTO EMP (
    EMP_NO, EMP_NAME, USERNAME, PASSWORD, ROLES_STATUS, DEL_STATUS, IN_DATE
) VALUES (
    100, 'ADMIN', 'ADMIN', 'not_applicable', 'ROLE_ADMIN', 0, SYSDATE
);       

COMMIT;

/************************************************** 
 *  게시판 : BOARD
 **************************************************/

-- 1. ERP 시스템 정기 점검
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[시스템] ERP 서버 정기 점검 안내 (8/8 금 22:00~)', '안녕하세요. IT관리팀입니다. 8월 8일 금요일 22:00 부터 2시간 동안 시스템 안정성 확보를 위한 정기 점검이 진행됩니다. 해당 시간에는 시스템 접속이 불가하오니 업무에 참고하시기 바랍니다.', 152, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE);

-- 2. 신규 기능 오픈
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[업데이트] 신규 "실시간 재고 추적" 모듈 오픈 안내', '사용자 편의성 증대를 위해 실시간 재고 추적 모듈이 새롭게 오픈되었습니다. 이제 각 창고별 재고 현황을 실시간으로 확인할 수 있습니다. 많은 활용 바랍니다.', 210, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 1);

-- 3. 데이터 입력 규칙
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[중요] 고객 정보 입력 시 주소 표준화 규칙 준수 요청', '데이터 정합성을 위해, 고객 정보 등록 시 반드시 새로운 주소 검색 API를 통해 표준화된 주소를 입력해주시기 바랍니다. 오류 데이터 발생 시 영업 실적 집계에서 누락될 수 있습니다.', 350, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 2);

-- 4. 영업 목표 공지
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[영업] 2025년 3분기 영업 목표 및 인센티브 정책 공지', '2025년 3분기 전사 영업 목표와 이에 따른 인센티브 정책을 공지합니다. 자세한 내용은 영업관리 > 목표관리 메뉴에서 확인 가능합니다.', 180, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 3);

-- 5. 생산 계획 업데이트
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[생산] 생산 라인 증설에 따른 ERP 생산 계획 모듈 업데이트', 'A라인 증설이 완료됨에 따라, ERP 생산 계획 모듈에 관련 로직이 업데이트되었습니다. 8월 11일부터 새로운 기준으로 생산 계획을 수립해주시기 바랍니다.', 120, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 4);

-- 6. 재고 실사 안내
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[물류] 하반기 정기 재고 실사 안내 (8/29~30)', '2025년 하반기 정기 재고 실사가 8월 29일, 30일 양일간 진행됩니다. 실사 기간 동안에는 재고 이동이 통제되오니, 각 팀에서는 업무 일정을 조율해주시기 바랍니다.', 255, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 5);

-- 7. 보안 강화 안내
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[보안] ERP 시스템 비밀번호 정기 변경 안내', '정보보호 정책에 따라, 모든 임직원께서는 8월 말까지 ERP 시스템 접속 비밀번호를 변경해주시기 바랍니다. (영문/숫자/특수문자 포함 9자 이상)', 412, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 6);

-- 8. 오류 수정 공지
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[수정] 견적서 출력 시 일부 항목 누락 오류 수정 완료', '일부 사용자에게서 발생하던 견적서 출력 오류가 수정되었습니다. 현재 정상적으로 모든 항목이 포함되어 출력됩니다. 이용에 불편을 드려 죄송합니다.', 99, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 7);

-- 9. 사용자 교육
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[교육] 신입사원을 위한 ERP 시스템 사용자 교육 (8/12 화)', '8월 신규 입사자들을 대상으로 ERP 시스템 기본 사용법 교육을 실시합니다. 일시: 8월 12일(화) 14:00~16:00, 장소: 3층 교육장', 75, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 8);

-- 10. 연휴 기간 운영
INSERT INTO BOARD (BOARD_NO, EMP_NO, TITLE, CONTENT, READ_COUNT, REF, RE_LVL, RE_STEP, IN_DATE)
VALUES (BOARD_NO_SEQ.NEXTVAL, 100, '[안내] 추석 연휴 기간 ERP 시스템 운영 및 긴급 지원 안내', '추석 연휴 기간(9/5~9/8) 동안 시스템은 정상 운영됩니다. 긴급 장애 발생 시 IT관리팀 비상 연락망으로 연락주시기 바랍니다.', 198, BOARD_NO_SEQ.CURRVAL, 0, 0, SYSDATE - 9);

COMMIT;

/************************************************** 
 *  부품 : PARTS
 **************************************************/
SET DEFINE OFF;

Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'라이젠5-5세대 7500F','CPU 코어 수 : 6
스레드 수 : 12
최대 부스트 쿨럭 : 5.0GHz
기본쿨럭:3.7 GHz
기본TDP:65W
CMOS:TSMC 5nm FInFET
소켓:AM5
최대작동온도:95℃','라이젠',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,8,'STANDARD COOLER','기본장착 CPU쿨러','인텔',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'RIME A620M-K ','칩셋 : AMD A620
칩셋제조사 : AMD
용도 : 데스크탑용(슬림용)메모리
종류 : DDR5-6400MHz
메모리 슬롯 : 2개최대 
메모리 : 96GBVGA 
단자 : D-SUB, HDMI
확장슬롯 : PCI Express 4.0x16
지원CPU : AMD
저장장치단자 : SATA3(4개), M.2 SSDUSB
단자 : USB3.2 Gen1(4개), USB2.0(2개)
사운드 채널 : 7.1채널','ASUS',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'Crucial DDR5-5600 CL46','용도 : 데스크탑용(DIMM)메모리방식 : DDR5동작속도 : 5,600MHz(PC5-44,800)방열판 : 블랙전압 : 1.1V램타이밍(CL) : 46램타이밍(tRCD) : 45램타이밍(tRP) : 45','마이크론',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX 5060 Ti D7 8GB TWIN X2','메모리 종류 : GDDR7부스트클럭 : 2,602MHz베이스클럭 : 2,407MHz쿠다 프로세서 : 4608개인터페이스 : PCI-Express5.0메모리 : 8GB메모리 대역폭 : 128bit','지포스',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Crucial P3 Plus M.2 NVMe','규격 : M.2(2280)읽기 : 4700Mb/s쓰기 : 1900Mb/s부가기능 : S.M.A.R.T., DEVSLP, TRIM지원, GC, ECC지원인터페이스 : PCI-Express4.0, x4길이 : 8cm','마이크론',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'DS500 RGB','메인보드 규격 : ATX, Micro-ATX, Mini-ITX파워규격 : ATX파워장착 : 후면하단장착파워 유무 : 파워 별도2.5베이 : 1개3.5베이 : 2개','NOBRAND',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'MAXWELL PRIMO 700W 80PLUS스탠다드 플랫
','형식 : ATX파워출력형태 : 정격출력전력 : 700W고효율파워 : 스탠다드메인커넥터 : 20+4핀PCI-E커넥터 : PCI-E(6+2핀) x 2개SATA커넥터 : 4개','막스엘리트',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'코어i7-14세대 14700F (랩터레이크 리프레시)','인텔코어 : 랩터레이크-R코어종류 : 20코어기본클럭 : 2.1GHz스레드 : 28스레드L3 캐시 : 33MB지원 : 하이퍼스레딩 지원구성 : 쿨러포함터보클럭속도 : 5.4GHz','인텔',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,8,'JIUSHARK JF100RS Crystal','CPU소켓 : AMD 소켓AM4, AMD 소켓AM5, 인텔 LGA1151, 인텔 LGA1156, 인텔 LGA1200, 인텔 LGA1700쿨링팬 두께 : 25T최대TDP : 220W팬크기 : 10cm핀수 : 4핀','인텔',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'B760M DS3H','소켓 : 1170소켓규격 : Micro-ATX최대 메모리 : 128GB메모리 종류 : DDR4-5333MHz메모리 슬롯 : 4개VGA 단자 : D-SUB, HDMI, DisplayPort확장슬롯 : PCI-Express4.0','GIGABYTE',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'Crucial DDR5-5600 CL46 32G','용도 : 데스크탑용(DIMM)메모리방식 : DDR5동작속도 : 5,600MHz(PC5-44,800)방열판 : 블랙전압 : 1.1V램타이밍(CL) : 46램타이밍(tRCD) : 45램타이밍(tRP) : 45','마이크론',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX 5070 벤투스 2X OC D7 12GB
','메모리 종류 : GDDR7부스트클럭 : 2,542MHz쿠다 프로세서 : 6144개인터페이스 : PCI-Express5.0(x16)메모리 : 12GB메모리 대역폭 : 192bit','지포스',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Crucial P3 Plus M.2 NVMe','규격 : M.2(2280)읽기 : 4700Mb/s쓰기 : 1900Mb/s부가기능 : S.M.A.R.T., DEVSLP, TRIM지원, GC, ECC지원인터페이스 : PCI-Express4.0, x4길이 : 8cm사용보증 : 150만시간','마이크론',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'DPX90 ARGB 강화유리 (블랙)','품목 : 미들타워케이스메인보드 규격 : ATX, Micro-ATX, Mini-ITX파워규격 : ATX부가기능 : 먼지필터쿨링팬 : 3개뒷면쿨러 : 12cm x 1개옆면쿨러 : 12cm x 2개','NOBRAND',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'MegaMax II 800W 80PLUS브론즈 ATX3.1
','형식 : ATX파워출력형태 : 정격출력전력 : 800W고효율파워 : 브론즈메인커넥터 : 20+4핀PCI-E커넥터 : PCI-E(12+4핀) x 1개SATA커넥터 : 8개','라이젠',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'라이젠3-2세대 3200G (피카소)','AMD코어 : 피카소(2세대)코어종류 : 4코어소켓 : AMD-소켓AM4제조공정 : 12nm스레드 : 4스레드L2 캐시 : 2MBL3 캐시 : 4MB코어(그래픽카드) : 4코어','라이젠',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'A520M-A PRO','소켓 : AMD-소켓TR4규격 : Micro-ATX칩셋 : ALC892칩셋제조사 : AMD','MSI',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'Crucial DDR4-3200 CL22 (8GB)','메모리방식 : DDR4전압 : 1.2V메모리 규격 : DIMM 288핀','마이크론',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'메인보드 내장 기본 VGA 사용','기본장착 내장GPU','NOBRAND',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Crucial P3 Plus M.2 NVMe (500GB)','규격 : M.2(2280)읽기 : 4700Mb/s쓰기 : 1900Mb/s부가기능 : S.M.A.R.T., DEVSLP, TRIM지원, GC, ECC지원인터페이스 : PCI-Express4.0, x4길이 : 8cm','마이크론',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'LIMPID Micro-1','블랙 / 미니타워 / 공랭 쿨러 165mm / 수냉 쿨러 2열 가능','싸이번',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'MAXWELL PRIMO 500W 80PLUS스탠다드 플랫
','형식 : ATX파워출력형태 : 정격출력전력 : 500W고효율파워 : 스탠다드메인커넥터 : 24핀PCI-E커넥터 : PCI-E(6+2핀) x 2개SATA커넥터 : 4개','막스엘리트',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'라이젠7-4세대 5700G','AMD코어 : 세잔(4세대)코어종류 : 8코어소켓 : AMD-소켓AM4제조공정 : 7nm기본클럭 : 3.8GHz스레드 : 16스레드L2 캐시 : 4MBL3 캐시 : 16MB','라이젠',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'PRIME A520M-K ','소켓 : AMD-소켓AM4규격 : mATX메모리 종류 : DDR4, DDR4-4600MHz메모리 슬롯 : 2개최대 메모리 : 64GBVGA 단자 : D-SUB, HDMI확장슬롯 : PCI Express 3.0 x16','ASUS',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'Crucial DDR4-3200 CL22 (8GB) ','용도 : 데스크탑용(DIMM)메모리방식 : DDR4동작속도 : 3,200MHz(PC4-25,600)전압 : 1.2V','마이크론',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'G20 에픽 강화유리 (블랙)','블랙 / 미니타워 / 공랭 쿨러 165mm / 수냉 쿨러 2열 가능','앱코',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'SAVEMOST 500W 블랙','형식 : ATX파워출력형태 : 정격출력전력 : 500W메인커넥터 : 24핀PCI-E커넥터 : PCI-E(6+2핀) x 2개SATA커넥터 : 4개','다크플래시',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'코어i9-14세대 14900K (랩터레이크 리프레시) ','인텔코어 : 랩터레이크코어종류 : 24코어소켓 : 1700소켓제조공정 : 10nm기본클럭 : 3.2GHz스레드 : 32스레드L3 캐시 : 33MB코어(그래픽카드) : 8코어','인텔',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,8,'A360 ARGB','베어링 : FDB베어링CPU소켓 : AMD 소켓AM4, AMD 소켓AM5, 115x(1150,1151,1155,1156),','발키리',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'Z790 PG Lightning D5 에즈윈','칩셋 : 인텔 Z790소켓 : 1700소켓규격 : ATX최대 메모리 : 128GB메모리 종류 : DDR5메모리 슬롯 : 4개VGA 단자 : HDMI, DisplayPort확장슬롯 : PCI-Express5.0','ASRock',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX A6000 D6 48GB','메모리 종류 : GDDR6쿠다 프로세서 : 10752개인터페이스 : PCI-Express4.0(x16)메모리 : 48GB메모리 대역폭 : 384bit칩셋 : 쿼드로RTX A6000단자 : DisplayPort(4개)','엔디비아',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Platinum P41 M.2 NVMe (2TB)','규격 : M.2(2280)NAND : TLC읽기 : 7,000Mb/s쓰기 : 4,700Mb/s부가기능 : S.M.A.R.T., TRIM지원, GC, AES256bit, 절전인터페이스 : PCI-Express4.0, x4길이 : 8cmRAM : LPDDR4','SK하이닉스',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'P20C ELITE 6FAN METAL MESH 강화유리','블랙 / 미들타워 / 공랭 쿨러 170mm / 수냉 쿨러 2,3열 가능','Antec',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'UPMOST 1050W 80PLUS골드 풀모듈러 ATX3.0 블랙
','형식 : ATX파워출력형태 : 정격출력전력 : 1,050W고효율파워 : 골드메인커넥터 : 20+4핀PCI-E커넥터 : PCI-E(6+2핀) x 3개SATA커넥터 : 8개부가기능 : +12V싱글레일','다크플래시',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,8,'TG-360 ARGB (블랙)','CPU소켓 : AMD 소켓AM4, AMD 소켓AM5, 인텔 LGA1151, 인텔 LGA1156, 인텔 LGA1200, 인텔 LGA1700, 인텔 LGA2011, 인텔 LGA2011-V3, 인텔 LGA2066쿨링팬 두께 : 25T','JONSBO',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'MAG B760M 박격포 II','칩셋 : B760소켓 : 1700소켓규격 : Micro-ATX최대 메모리 : 256GB메모리 종류 : DDR5,','MSI',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'
RTX 5070 SOLID OC D7 12GB
','메모리 종류 : GDDR7부스트클럭 : 2542MHz쿠다 프로세서 : 6144개인터페이스 : PCI-Express5.0(x16)부스트 : GPU부스트메모리 : 12GB','ZOTAC',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'Crucial P3 Plus M.2 NVMe (1TB)
','규격 : M.2(2280)읽기 : 4700Mb/s쓰기 : 1900Mb/s부가기능 : S.M.A.R.T., DEVSLP, TRIM지원, GC, ECC지원인터페이스 : PCI-Express4.0, x4길이 : 8cm','마이크론',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,7,'UH40 킬러웨일 ARGB','품목 : 미들타워케이스메인보드 규격 : ATX, Micro-ATX, Mini-ITX파워규격 : ATX파워장착 : 후면하단장착파워 유무 : 파워 별도2.5베이 : 3개3.5베이 : 2개','앱코',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,4,'Classic II 풀체인지 800W 80PLUS브론즈 ATX3.1
','형식 : ATX파워출력형태 : 정격출력전력 : 800W고효율파워 : 브론즈메인커넥터 : 20+4핀PCI-E커넥터 : PCI-E(6+2핀) x 2개, PCI-E(12+4핀) x 1개SATA커넥터 : 8개','마이크로닉스',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'라이젠5-4세대 5625U(2.3GHz)','CPU 제조사	AMD	CPU 세분류	라이젠5-4세대
CPU 코드명	바르셀로	CPU 넘버	5625U (2.3GHz)
CPU 코어	헥사(6)코어	CPU 스레드	12','AMD',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'DDR4 8G','용량 : 16GB','삼성',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'Radeon Graphics','GPU 종류	내장그래픽	GPU 제조사	AMD
GPU 칩셋	Radeon Graphics	','AMD',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,6,'M.2(NVMe)','저장장치 종류	M.2(NVMe)	용량	256GB
저장 슬롯	1개	','AMD',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'코어i7-13세대 i7-13620H (2.4GHz)','CPU 제조사','인텔',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX4060','GPU 종류	외장그래픽	GPU 제조사	엔비디아
GPU 칩셋	RTX4060	GPU TOPS	233 AI TOPS
GPU 메모리	VRAM:8GB	TGP	105W
게임 관련 기능	MUX 스위치		','엔비디아',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,3,'DDR5 8G','램 타입	DDR5	램	16GB
램 슬롯	총 2개	램 구성	듀얼(8G+8G)
램 최대용량	64GB	램 교체	가능','삼성',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,1,'W-2223','CPU 특징
CPU 제조사	인텔	CPU 시리즈	제온
CPU 종류	제온	CPU 코드명	캐스케이드레이크
코어 개수	쿼드(4)코어	장착 CPU 개수	CPU :1개
최대 장착 가능 CPU	1개		
CPU 기능
ECC	○	터보부스트	○
하이퍼스레딩	○','인텔',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,2,'RTX 4070 TI','메모리 종류 : GDDR6X부스트클럭 : 2670MHz쿠다 프로세서 : 8448개인터페이스 : PCI-Express4.0부스트 : GPU부스트메모리 : 16GB메모리 대역폭 : 256bit','지포스',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'C422','워크스테이션 메인보드
코어개수 : 1개
메모리 슬롯 : 8개','인텔',null,0,1001,to_date('25/07/24','RR/MM/DD'));
Insert into PARTS (PARTS_NO,PARTS_STATUS,PARTS_NAME,PARTS_CONTEXT,MANUFACTURE,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PARTS_SEQ.NEXTVAL,0,'C621','워크스테이션
CPU 슬롯 : 2개
메모리 슬롯 : 12개','인텔',null,0,1001,to_date('25/07/24','RR/MM/DD'));

SET DEFINE ON;
COMMIT;


/************************************************** 
 *  제품 : PRODUCT
 **************************************************/
SET DEFINE OFF;

Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'AMD R5-7500F','7500F/RTX 5060 Ti/(AMD) B650/OS미포함/700W/AMD/라이젠 7000시리즈/라이젠5/라파엘/DDR5/16GB/M.2/500GB/NVIDIA/1Gbps 유선/HDMI/DP포트/파워서플라이/미들타워/어항형/LED쿨러/용도: 게임용',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'AMD R3-3200G/내장VGA/16G
','CPU
AMD 라이젠3-2세대 3200G (피카소) (멀티팩(정품))
CPU쿨러
기본쿨러
메인보드
MSI A520M-A PRO
메모리
마이크론 Crucial DDR4-3200 CL22 대원씨티에스 (16GB) 8GB x 2
그래픽카드
내장형 VGA
SSD
마이크론 Crucial P3 Plus M.2 NVMe 대원씨티에스 (500GB)
케이스
싸이번 LIMPID Micro-1 (블랙)
파워
맥스엘리트 MAXWELL PRIMO 500W 80PLUS STANDARD 플랫
운영체제
미포함
모니터
미포함',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'인텔i7-14700F/RTX5070/32G','AMD 라이젠3-2세대 3200G (피카소) (멀티팩(정품))',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'AMD R7-5700G/내장VGA/16G','CPU
AMD 라이젠7-4세대 5700G (세잔) (멀티팩(정품))
CPU쿨러
기본쿨러
메인보드
MSI A520M-A PRO
메모리
마이크론 Crucial DDR4-3200 CL22 대원씨티에스 (16GB) 8GB x 2
그래픽카드
내장형 VGA
SSD
마이크론 Crucial P3 Plus M.2 NVMe 대원씨티에스 (500GB)
케이스
앱코 G15 세이퍼 아크릴
파워
맥스엘리트 MAXWELL PRIMO 500W 80PLUS STANDARD 플랫
운영체제
Microsoft Windows 11 Home (OEM 라이선스)
모니터
AONE AD240 FHD 프리싱크 HDR 무결점',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'인텔 i9-14900K/RTX A6000/64G','CPU
인텔 코어i9-14세대 14900K (랩터레이크 리프레시) (정품)
CPU쿨러
발키리 A360 ARGB (BLACK)
메인보드
ASRock Z790 PG Lightning D5 에즈윈
메모리
마이크론 Crucial DDR5-5600 CL46 대원씨티에스 (64GB) 32G x 2
그래픽카드
NVIDIA RTX A6000 D6 48GB
SSD
SK하이닉스 Platinum P41 M.2 NVMe (2TB)
케이스
Antec P20C ELITE 6FAN METAL MESH 강화유리 (블랙)
파워
darkFlash UPMOST 1050W 80PLUS GOLD FULL MODULAR ATX3.0 (PCIE5) 블랙
운영체제
미포함
모니터
미포함',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,0,'인텔 i9-14900K/RTX5070/32G','CPU
인텔 코어i9-14세대 14900K (랩터레이크 리프레시) (정품)
CPU쿨러
앱코 P360 POSEIDON ARGB (블랙)
메인보드
MSI PRO Z790-A 맥스 WIFI
메모리
마이크론 Crucial DDR5-5600 CL46 대원씨티에스 (32GB) 16GB x 2
그래픽카드
MSI 지포스 RTX 5070 Ti 벤투스 3X OC D7 16GB
SSD
마이크론 Crucial P3 Plus M.2 NVMe 대원씨티에스 (1TB)
케이스
앱코 UD50 블루웨일 ARGB BTF (블랙)
파워
잘만 GigaMax III 850W 80PLUS브론즈 모듈러 ATX3.1
운영체제
미포함
모니터
미포함',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,1,'아이디어패드 Slim1-15ALC R5B WIN11 16GB램 (SSD 256GB)','[CPU]
CPU 제조사	AMD	CPU 세분류	라이젠5-4세대
CPU 코드명	바르셀로	CPU 넘버	5625U (2.3GHz)
CPU 코어	헥사(6)코어	CPU 스레드	12
[그래픽]
GPU 종류	내장그래픽	GPU 제조사	AMD
GPU 칩셋	Radeon Graphics		
[구성]
램 타입	DDR4	램	16GB
램 슬롯	총 2개	램 구성	듀얼(8G+8G)
램 대역폭	3200MHz	램 교체	가능(1슬롯)
[저장장치]
저장장치 종류	M.2(NVMe)	용량	256GB
저장 슬롯	1개	',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,1,'GF시리즈 Sword GF76 B13VFK (SSD 512GB)','[CPU]
CPU 제조사	인텔	CPU 세분류	코어i7-13세대
CPU 코드명	랩터레이크	CPU 넘버	i7-13620H (2.4GHz)
CPU 코어	10코어(6P+4E)	CPU 스레드	16
[그래픽]
GPU 종류	외장그래픽	GPU 제조사	엔비디아
GPU 칩셋	RTX4060	GPU TOPS	233 AI TOPS
GPU 메모리	VRAM:8GB	TGP	105W
게임 관련 기능	MUX 스위치		
[구성]
램 타입	DDR5	램	16GB
램 슬롯	총 2개	램 구성	듀얼(8G+8G)
램 최대용량	64GB	램 교체	가능
[저장장치]
저장장치 종류	M.2(NVMe)	용량	512GB
저장 슬롯	2개		
',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,2,'5820T W-2223 RTX4070Ti Win11Pro (8GB, M.2 512GB)','제조회사	DELL 프리시전	등록년월	2024년 04월
CPU 넘버	W-2223	그래픽 카드	지포스 RTX 4070 Ti
메인보드 칩셋	(인텔) C422	운영체제	윈도우11 프로
파워 출력	950W	제품분류	워크스테이션
CPU 특징
CPU 제조사	인텔	CPU 시리즈	제온
CPU 종류	제온	CPU 코드명	캐스케이드레이크
코어 개수	쿼드(4)코어	장착 CPU 개수	CPU :1개
최대 장착 가능 CPU	1개		
CPU 기능
ECC	○	터보부스트	○
하이퍼스레딩	○		
메모리
메모리 타입	DDR4	메모리 용량	8GB
메모리 슬롯	8개		
저장장치
SSD 형태	M.2	SSD 용량	512GB
',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));
Insert into PRODUCT (PRODUCT_NO,PRODUCT_STATUS,PRODUCT_NAME,PRODUCT_CONTEXT,FILENAME,DEL_STATUS,EMP_NO,IN_DATE) values (PRODUCT_SEQ.NEXTVAL,2,'E900 G4 (베어본)','제조회사	ASUS (제조사 웹사이트 바로가기)	등록년월	2020년 03월
메인보드 칩셋	(인텔) C621	운영체제	OS미포함
파워 출력	2000W	제품분류	워크스테이션
CPU 특징
CPU 제조사	인텔	CPU 종류	CPU 미포함
장착 CPU 개수	CPU :미포함	최대 장착 가능 CPU	2개
메모리
메모리 타입	DDR4	메모리 용량	메모리 미포함
메모리 슬롯	12개	메모리 최대용량	1536GB',null,0,1001,to_timestamp('25/07/24 18:02:59.711000000','RR/MM/DD HH24:MI:SSXFF'));

SET DEFINE ON;
COMMIT;

/************************************************** 
 *  제품_BOM : PRODUCT_BOM
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
 *  월재고 : MONTH_INVENTORY
 **************************************************/
-- 2406 기말재고
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
-- 2407 기초재고
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
 *  수불마감 : INVENTORY_CLOSE
 **************************************************/
INSERT INTO inventory_close VALUES ('2406', 2, TO_DATE('20250630 18:00:00', 'YYYYMMDD HH24:MI:SS'), TO_DATE('20250630 18:30:00', 'YYYYMMDD HH24:MI:SS'), 1); -- 마감완료
INSERT INTO inventory_close VALUES ('2407', 1, sysdate, sysdate, 1);

/************************************************** 
 *  제품가격변동이력 : PRODUCT_COSTHIS
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
 *  부품가격변동이력 : PARTS_COSTHIS
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
 *  매입실적 : PURCHASE_PERFORM
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
 *  매출실적 : SALES_PERFORM
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
 *  거래처 : CLIENT
 **************************************************/
INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1001, 1003, '부품나라', 0,
    'sales@bupumnara.com', '김수빈', '서울 강남구', '010-9923-1234',
     0, NULL, TO_DATE('2025-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS ,MODIFY_DATE, IN_DATE
) VALUES (
    1002, 1003, '모두파츠', 0,
    'sales@moduparts.co.kr', '박수문', '서울 용산구', '010-9349-1223',
    0, NULL, TO_DATE('2025-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1003, 1003, '바로파츠', 0,
    'sales@baroparts.kr', '김성주', '서울 용산구', '010-2494-9923',
    0, NULL, TO_DATE('2025-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1004, 1003, '한빛부품', 0,
    'sales@hanbitparts.co.kr', '이민주', '서울 용산구', '010-3360-2323',
    0, NULL, TO_DATE('2025-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1005, 1003, '티앤피', 0,
    'sales@tnp.parts', '주성진', '서울 마포구', '010-3045-9239',
    0, NULL, TO_DATE('2025-07-04', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1006, 1003, '파츠링크', 0,
    'sales@partslink.co.kr', '김성주', '서울 종로구', '010-1223-9323',
    0, NULL, TO_DATE('2024-07-04', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1007, 1003, '모두부품', 0,
    'sales@modu.kr', '민종국', '인천 계양구', '010-9283-2939',
    0, NULL, TO_DATE('2022-03-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1008, 1003, '마스터파츠', 0,
    'sales@masterparts.kr', '김성주', '서울 성동구', '010-4304-9313',
    0, NULL, TO_DATE('2021-05-11', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1009, 1003, '파워컴포넌트', 0,
    'sales@power.kr', '이주용', '수원시 장안구', '010-7583-9212',
    0, NULL, TO_DATE('2022-03-13', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    1010, 1003, '요기파츠', 0,
    'sales@yogiparts.kr', '박평호', '서울 용산구', '010-9232-1923',
    0, NULL, TO_DATE('2021-11-28', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2001, 1003, '테크부품', 1,
    'purchase@techparts.com', '정승우', '서울 금천구', '010-2032-1203',
    0, NULL, TO_DATE('2021-07-16', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2002, 1003, '이지파츠', 1,
    'purchase@ezparts.kr', '하유정', '서울 구로구', '010-9596-9232',
    0, NULL, TO_DATE('2024-07-10', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2003, 1003, '스마트모듈', 1,
    'purchase@smartmod.co.kr', '윤정수', '서울 양천구', '010-2392-2932',
    0, NULL, TO_DATE('2024-07-14', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2004, 1003, '탑커넥트', 1,
    'purchase@topconnect.kr', '오지훈', '경기 고양시', '010-3423-1223',
    0, NULL, TO_DATE('2022-07-09', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2005, 1003, '오토라인', 1,
    'purchase@autoline.kr', '서지민', '인천 남동구', '010-9242-1223',
    0, NULL, TO_DATE('2024-07-24', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2006, 1003, '네오파츠', 1,
    'purchase@neoparts.kr', '김태린', '서울 동작구', '010-3388-3234',
    0, NULL, TO_DATE('2024-03-02', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2007, 1003, '탑이노텍', 1,
    'purchase@topinotech.com', '윤호민', '서울 금천구', '010-9233-9232',
    0, NULL, TO_DATE('2024-02-14', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2008, 1003, '지엠파츠', 1,
    'purchase@gmparts.kr', '박정화', '대전 유성구', '010-9323-1223',
    0, NULL, TO_DATE('2024-01-14', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2009, 1003, '다온전자', 1,
    'purchase@daon.co.kr', '류세영', '경기 성남시', '010-5676-7666',
    0, NULL, TO_DATE('2024-07-15', 'YYYY-MM-DD')
);

INSERT INTO CLIENT (
    CLIENT_NO, EMP_NO, CLIENT_NAME, CLIENT_GUBUN,
    CLIENT_EMAIL, CLIENT_MAN, CLIENT_ADDRESS, CLIENT_TEL,
    DEL_STATUS, MODIFY_DATE, IN_DATE
) VALUES (
    2010, 1003, '이노파워', 1,
    'purchase@innopower.kr', '정하윤', '경기 안양시', '010-2293-1223',
    0, NULL, TO_DATE('2022-07-19', 'YYYY-MM-DD')
);

COMMIT;

/************************************************** 
 *  거래처이력 : CLIENT_HIS
 **************************************************/
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2002, '20240710', '99991231', 1003,
     '이지파츠',   1, '하유정', 'purchase@ezparts.kr', '010-9596-9232', '서울 구로구', TO_DATE('2024/07/10','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1001, '20250724', '99991231', 1003,
     '부품나라',   0, '김수빈', 'sales@bupumnara.com', '010-9923-1234', '서울 강남구', TO_DATE('2025/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1002, '20250724', '99991231', 1003,
     '모두파츠',   0, '박수문', 'sales@moduparts.co.kr', '010-9349-1223', '서울 용산구', TO_DATE('2025/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1003, '20250724', '99991231', 1003,
     '바로파츠',   0, '김성주', 'sales@baroparts.kr', '010-2494-9923', '서울 용산구', TO_DATE('2025/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1004, '20250724', '99991231', 1003,
     '한빛부품',   0, '이민주',  'sales@hanbitparts.co.kr', '010-3360-2323','서울 용산구', TO_DATE('2025/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1005, '20240704', '99991231', 1003,
     '티앤피', 0, '주성진', 'sales@tnp.parts', '010-3045-9239', '서울 마포구', TO_DATE('2024/07/04','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1006, '20240704', '99991231', 1003,
     '파츠링크',   0, '김성주', 'sales@partslink.co.kr', '010-1223-9323', '서울 종로구', TO_DATE('2024/07/04','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1007, '20220324', '99991231', 1003,
     '모두부품',   0, '민종국', 'sales@modu.kr', '010-9283-2939', '인천 계양구', TO_DATE('2022/03/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1008, '20210511', '99991231', 1003,
     '마스터파츠', 0, '김성주', 'purchase@masterparts.kr', '010-4304-9313', '서울 성동구', TO_DATE('2021/05/11','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1009, '20220313', '99991231', 1003,
     '파워컴포넌트',0, '이주용', 'sales@power.kr', '010-7583-9212', '수원시 장안구', TO_DATE('2022/03/13','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (1010, '20211128','99991231', 1003,
     '요기파츠', 0, '박평호', 'sales@yogiparts.kr', '010-9232-1923',  '서울 용산구', TO_DATE('2021/11/28','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2001, '20210716', '99991231', 1003,
     '테크부품',   1, '정승우', 'purchase@techparts.com', '010-2032-1203', '서울 금천구', TO_DATE('2021/07/16','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2003, '20240701', '99991231', 1003,
     '스마트모듈', 1, '윤정수', 'purchase@smartmod.co.kr', '010-2392-2932','서울 양천구', TO_DATE('2024/07/14','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2004, '20240709', '99991231', 1003,
     '탑커넥트',   1, '오지훈',  'purchase@topconnect.kr', '010-3423-1223','경기 고양시', TO_DATE('2024/07/09','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2005, '20240724', '99991231', 1003,
     '오토라인',   1, '서지민', 'purchase@autoline.kr','010-9242-1223','인천 남동구', TO_DATE('2024/07/24','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2006, '20240302', '99991231', 1003,
     '네오파츠',   1, '김태린', 'purchase@neoparts.kr','010-3388-3234', '서울 동작구', TO_DATE('2024/03/02','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2007, '20240214', '99991231', 1003,
     '탑이노텍',   1, '윤호민', 'purchase@topinotech.com', '010-9233-9232', '서울 금천구', TO_DATE('2024/02/14','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2008, '20240114', '99991231', 1003,
     '지엠파츠', 1, '박정화', 'purchase@gmparts.kr', '010-9323-1223','대전 유성', TO_DATE('2024/01/14','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2009, '20240715','99991231', 1003,
     '다온전자', 1, '류세영', 'purchase@daon.co.kr', '010-5676-7666','경기 성남시', TO_DATE('2024/07/15','YYYY/MM/DD'))
     ;
  INSERT INTO CLIENT_HIS (
    CLIENT_NO, START_DATE, END_DATE, EMP_NO,
    CLIENT_NAME, CLIENT_GUBUN, CLIENT_MAN, CLIENT_EMAIL, CLIENT_TEL,
    CLIENT_ADDRESS, IN_DATE
  )
  VALUES
    (2010, '20220719','99991231', 1003,
     '이노파워',   1, '정하윤',  'purchase@innopower.kr', '010-2293-1223','경기 안양시', TO_DATE('2022/07/19','YYYY/MM/DD'))
     ;

COMMIT;


/************************************************** 
 *  거래처별실적 : CLIENT_PERFORM
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
 *  발주 : PURCHASE_ORDER
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
 *  발주부품 : PURCHASE_ITEM
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
 *  수주 : SALES_ORDER
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
 *  수주제품 : SALES_ITEM
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

