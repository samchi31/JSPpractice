--1. ���� ���� �ο��� ��ȸ
SELECT 
    CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3')
        THEN '����'
        ELSE '����'
    END AS ����, 
    COUNT(*) AS CNT
FROM MEMBER
GROUP BY  
    CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN ('1','3')
        THEN '����'
        ELSE '����'
    END;
    
--2. ���ݱ��� �ѹ��� ��ǰ�� ������ ���� ���� ȸ���� �������� ��ȸ(���̵�, �̸�, �̸���)
SELECT  MEM_ID, MEM_NAME, MEM_MAIL
FROM    MEMBER
WHERE   MEM_ID NOT IN (SELECT DISTINCT CART_MEMBER FROM CART);

--3. ��ϵ� ��ǰ�� �Ѱǵ� ���� ��ǰ�з� ��ȸ(��ǰ�з��ڵ�, �з���)
select  lprod_gu, lprod_nm
from    lprod
where   lprod_gu not in (select distinct prod_lgu from prod);

--4. ���ݱ��� ���� ���� �ȸ� ��ǰ ��ȸ(��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, ���ϸ���)
with    cartview as(
    select  cart_prod, sum(cart_qty) as total
    from    cart
    group   by cart_prod
    order   by total desc
),
with    max
select  prod_id
        , (
            select  lprod_nm
            from    lprod
            where   lprod_gu = prod_lgu     )
        , (
            select  buyer_name
            from    buyer
            where   buyer_id = prod_buyer   )
from    prod

--5. ���ݱ��� ���� ���� �ȸ� ��ǰ ��ȸ(��ǰ�ڵ�, ��ǰ��, ��ǰ�з���, �ŷ�ó��, ���ϸ���)
--6. �ŷ�ó �� �ŷ� ǰ�� ���� ���� ���� �ŷ�ó ��ȸ(�ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�з���, ����ڸ�)
--7.   �ŷ�ó �� �ŷ� ǰ�� ���� ���� ���� �ŷ�ó ��ȸ(�ŷ�ó�ڵ�, �ŷ�ó��, �ŷ�ó�з���, ����ڸ�)
--8. ���� ���� ���� �������� ���� ��ǰ ��ȸ(����, ��ǰ�ڵ�, ��ǰ��, �з���)
--9. �� ȸ���� ���� �Ѿ� ��ȸ(ȸ�����̵�, ȸ����, �����Ѿ�)
--10. �� ��ǰ�� ���ſ� ��ȸ(���ſվ��̵�, ȸ����, �����Ѿ�)
