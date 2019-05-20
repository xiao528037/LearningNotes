-- ������ռ�
create tablespace itheima
datafile 'E:\oracle\itheima.dbf'
size 100m
autoextend on 
next 10m; --ÿ�������Ĵ�СΪ10m

-- ɾ����ռ�
drop tablespace itheima;

-- �����û�
create user itheima   -- �û�
identified by itheima -- ����
default tablespace itheima; --ָ����ռ�

-- ���û���Ȩ�������޷���½
-- Oracle���ݿ��г��ý�ɫ
-- connect --���ӽ�ɫ��������ɫ
-- resource --�����߽�ɫ
-- dba --��������Ա��ɫ

-- �� itheima�û�����dba��ɫ
grant dba to itheima;

-- ����һ��person��
create table person(
       pid number(20),
       pname varchar2(10)
);

-- �޸ı�ṹ
--���һ��
alter table person add (genders number(1),sex number(1));
--�޸�������
alter table person modify gender char(1);
-- �޸�������
alter table person rename column gender to sex;
-- ɾ��һ��
alter table person drop column sex;


--��ѯ���м�¼
select * from person;
--���һ����¼
insert into person (pid,pname) values(1,'С��');
--�޸�һ����¼
update person set pname ='С��' where pid = 1;
--ɾ����¼
-- delete(ɾ������ȫ����¼)��drop(ɾ����ṹ)��truncate(��ɾ�����ٴδ�����Ч����ͬ��ɾ������ȫ����¼)
delete table person;
drop table person;
-- ���������������£������ڱ��д�������������£�truncateЧ�ʸߡ�
-- ����������߲�ѯЧ�ʣ����ǻ�Ӱ����ɾ��Ч�ʡ�
truncate table person;

-- ���в������κ�һ�ű����ǿ����߼��ͱ�����
-- ���У�Ĭ�ϴ�1��ʼ�����ε�������Ҫ������������ֵʹ�á�
-- dual:��ֻ꣬��Ϊ�˲�ȫ�﷨��û���κ����塣
create sequence s_person;
select s_person.nextval from dual;

insert into person (pid,pname) values(s_person.nextval,'С��');
commit;

--scott�û�������tiger��
-- ����Scott�û�
alter user scott account unlock;
-- ����scott�û�������
alter user scott identified by tiger;

-- ���к���
-- �ַ�����
select upper('yes') from dual; --Сд���д
select lower('YES') from dual; --��д��Сд

-- ��ֵ����
select round(26.18,1) from dual; --�������룬����Ĳ�����ʾ������С��
select trunc(56.16,1) from dual; --ֱ�ӽ�ȡ�����ڿ�����С���Ƿ������
select mod(10,3) from dual;      --������

-- ���ں���
-- ��ѯ��emp��������Ա����ְ�������ڼ���
select sysdate-e.hiredate from emp e;
-- �������˿�
select sysdate+1 from dual;
-- ��ѯ��emp��������Ա����ְ�������ڼ���
select months_between(sysdate,e.hiredate)/12 from emp e;
-- ��ѯ��emp��������Ա����ְ�������ڼ���
select round((sysdate-e.hiredate)/7) from emp e;

-- ת������
select to_char(sysdate,'fm yyyy-mm-dd hh24:mi:ss') from dual; -- ����ת�ַ���
select to_date('2019-5-20 14:21:30','fm yyyy-mm-dd hh24:mi:ss') from dual; -- �ַ���ת����

-- ͨ�ú���
-- ���emp��������Ա������н
-- ����������nullֵ�����nullֵ�������������������㣬�������null
select e.sal*12+nvl(e.comm,0) from emp e; --nvl���������Ϊnull������0������Ϊ����

-- �������ʽ
--��emp����Ա������Ӣ����
select e.ename,
       case e.ename
         when 'SMITH' then '����'
         when 'ALLEN' then '���С��'
         else '����' -- ��ʡ��
         end
 from emp e;
 
 -- �ж�emp����Ա�����ʣ��������3000��ʾ�����룬
 --�������1500����3000��ʾ�е����룬����1500��������
 select e.sal,
       case 
         when e.sal>3000 then '������'
         when e.sal>1500 then '������'
         else '������' -- ��ʡ��
         end
 from emp e;
 
 -- oracle�г��������ʹ��˫���ţ��������õ����š�
 --oracleר���������ʽ
  select e.sal,
        decode( e.ename,
          'SMITH' , '����',
          'ALLEN' , '���С��',
          '����' -- ��ʡ��
         ) "������" -- ���б���������˫����
 from emp e;
 
 -- ���к������ۺϺ����� �������ڶ��У�����һ��ֵ��
 select count(1) from emp; --��ѯ������
 select sum(sal) from emp; --�����ܺ�
 select max(sal) from emp; --�����
 select min(sal) from emp; --��͹���
 select avg(sal) from emp; --ƽ������
 
 -- �����ѯ
 -- ��ѯ��ÿ�����ŵ�ƽ������
 -- �����ѯ�У�������group by�����ԭʼ�У����ܳ�����select����
 -- ���г�����group by������࣬����select���棬������ϾۺϺ�����
 -- �ۺϺ�����һ�����ԣ����԰Ѷ��м�¼���һ��ֵ��
 select e.deptno,round(avg(e.sal))  from emp e group by e.deptno
 
 -- ��ѯ��ƽ�����ʸ���2000�Ĳ�����Ϣ
 select e.deptno,avg(e.sal) asal
  from emp e 
  group by e.deptno
  having avg(e.sal)>2000; --��������������ʹ�ñ��������ж�
  
 -- ��ѯ��ÿ�����Ÿ���800��Ա����ƽ������
 select e.deptno,avg(e.sal) asal
 from emp e
 where e.sal>800
 group by e.deptno; 
 -- where�ǹ��˷���ǰ�����ݣ�having�ǹ��˷��������ݡ�
 -- ������ʽ��where������group by֮ǰ��having����group by֮��
 
 -- ��ѯ��ÿ�����Ÿ���800��Ա����ƽ������
 -- ���Ź��ʸ���2000
  select e.deptno,avg(e.sal) asal
 from emp e
 where e.sal>800
 group by e.deptno
 having avg(e.sal)>2000;
 
 --����ѯ�е�һЩ����
 -- �Ͽ�����(��ѯ�����������壩
 select * from emp e,dept d;
 -- ��ֵ����
 select * from emp e,dept d where e.deptno=d.deptno;
 -- ������
 select * from emp e inner join dept d on e.deptno=d.deptno;

--��ѯ����Ӵ���ţ��Լ������µ�Ա����Ϣ��[������]
select  * from emp e right join dept d on e.deptno=d.deptno;

-- ��ѯ����Ա����Ϣ���Լ�Ա����������
select * from emp e left join dept d on e.deptno=d.deptno;

-- oracle��ר��������
select * from emp e,dept d where e.deptno(+) = d.deptno;

-- ��ѯ��Ա��������Ա���쵼����
-- �����ӣ���������ʵ����վ�ڲ�ͬ�ĽǶȰ�һ�ű��ɶ��ű�
select e1.ename,e2.ename from emp e1,emp e2 where e1.mgr = e2.empno;

-- �Ӳ�ѯ
-- �Ӳ�ѯ����һ��ֵ
-- ��ѯ�����ʺ�Scottһ����Ա��
select * from emp where sal=
(select sal from emp where ename='SCOTT');

-- �Ӳ�ѯ����һ������
-- ��ѯ�����ʺ�10�Ų�������Ա��һ����Ա����Ϣ
select * from emp where sal in
(select sal from emp where deptno=10);

-- �Ӳ�ѯ����һ����
-- ��ѯ��ÿ��������͹��ʣ�����͹���Ա���������͸�Ա�����ڲ�������

select t.deptno,t.msal,e.ename,d.dname
from (select deptno,min(sal) msal from emp group by deptno) t,emp e,dept d
where t.deptno=e.deptno and t.msal =e.sal and e.deptno =d.deptno;

--oracle�з�ҳ
--- rownum�кţ���������select������ʱ��
--- û��ѯ��һ�м�¼���ͻ��ڸ����ϼ�һ���кš�
--- �кŴ�1��ʼ��һ�ε���������������

-- ���������Ӱ��rownum��˳��
select rownum,e.* from emp e order by e.sal desc;

--����漰�����򣬵��ǻ�Ҫʹ��rownum�Ļ������ǿ����ٴ�Ƕ�ײ�ѯ
select rownum,t.* from (select rownum,e.* from emp e order by e.sal desc)t;

-- emp���ʵ������к�ÿҳ������¼����ѯ�ڶ�ҳ��
-- rownum�кŲ���д�ϴ���һ��������
select * from(
       select rownum rn,t.* from (
              select * from emp e order by e.sal desc
              )t where rownum<11) 
              where rn>5
