

SELECT
    mem_id,    mem_pass,    mem_name,
    mem_regno1,    mem_regno2,    to_char(mem_bir, 'YYYY-MM-DD')  mem_bir,
    mem_zip,    mem_add1,    mem_add2,
    mem_hometel,    mem_comtel,    mem_hp,
    mem_mail,   mem_job,    mem_like,
    mem_memorial,    to_char(mem_memorialday, 'YYYY-MM-DD') mem_memorialday,    mem_mileage,
    mem_delete
FROM    member
where mem_id = 'a001'
;

--comment on column member.mem_id is 'ȸ�����̵�';
comment on column MEMBER.MEM_ID is 'ȸ�����̵�';
comment on column MEMBER.MEM_PASS is '��й�ȣ';
comment on column MEMBER.MEM_NAME is 'ȸ����';
comment on column MEMBER.MEM_REGNO1 is '�ֹι�ȣ1';
comment on column MEMBER.MEM_REGNO2 is '�ֹι�ȣ2';
comment on column MEMBER.MEM_BIR is '����';
comment on column MEMBER.MEM_ZIP is '�����ȣ';
comment on column MEMBER.MEM_ADD1 is '�ּ�1';
comment on column MEMBER.MEM_ADD2 is '�ּ�2';
comment on column MEMBER.MEM_HOMETEL is '������';
comment on column MEMBER.MEM_COMTEL is 'ȸ������';
comment on column MEMBER.MEM_HP is '�޴���';
comment on column MEMBER.MEM_MAIL is '�̸���';
comment on column MEMBER.MEM_JOB is '����';
comment on column MEMBER.MEM_LIKE is '���';
comment on column MEMBER.MEM_MEMORIAL is '�����';
comment on column MEMBER.MEM_MEMORIALDAY is '�������';
comment on column MEMBER.MEM_MILEAGE is '���ϸ���';
comment on column MEMBER.MEM_DELETE is 'Ż�𿩺�';


select SUBSTR(LOWER(COLUMN_NAME),1,1) || SUBSTR(REPLACE(INITCAP(COLUMN_NAME),'_',''), 2) from USER_COL_COMMENTS
where TABLE_NAME = 'MEMBER';


CREATE OR REPLACE FUNCTION SNAKETOCAMEL(
    snake varchar2
) 
return varchar2
is
v_tmp varchar2(50);
begin
    v_tmp := SUBSTR(LOWER(snake),1,1) || SUBSTR(REPLACE(INITCAP(snake),'_',''), 2);
    return v_tmp;
end;

select '<tr><th>' || COMMENTS || '</th>' || '<td>${' || LOWER(TABLE_NAME) || '.' || SNAKETOCAMEL(COLUMN_NAME) || '}</td></tr>'
from USER_COL_COMMENTS
where TABLE_NAME = 'MEMBER';