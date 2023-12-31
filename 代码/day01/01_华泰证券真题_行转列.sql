drop database if exists db_1;
create database db_1;
use db_1;

-- 创建表
CREATE TABLE tb_order (
    year INT,
    month INT,
    amount DECIMAL(5, 2)
);
-- 插入数据
INSERT INTO tb_order (year, month, amount) VALUES
(1991, 1, 1.1),
(1991, 2, 1.2),
(1991, 3, 1.3),
(1991, 4, 1.4),
(1992, 1, 2.1),
(1992, 2, 2.2),
(1992, 3, 2.3),
(1992, 4, 2.4);

select *
from tb_order;

select
    year,
    # month, amount,
    # 注意: 分完组之后 select中只能出现被分组的列, 如果想使用非分组的列, 就要使用聚合函数
    # 只要使用分组, 大概率就要使用 聚合函数
    # 这里的原理是在查的时候将需要的类使用开窗函数分组，计算后起一个别名产生新列
    # 这里之所以写一个sum是因为month未在分组的列中，需要使用聚合函数
    round(sum(if(month = 1, amount, null)), 1) m1,
    round(sum(if(month = 2, amount, null)), 1) m2,
    round(sum(if(month = 3, amount, null)), 1) m3,
    round(sum(if(month = 4, amount, null)), 1) m4
from tb_order
group by year