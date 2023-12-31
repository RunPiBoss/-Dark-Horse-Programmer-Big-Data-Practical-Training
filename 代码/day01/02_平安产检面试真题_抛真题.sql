drop database if exists db_1;
create database db_1;
use db_1;

-- 创建表
CREATE TABLE tb_score (
    name VARCHAR(50),
    subject VARCHAR(50),
    score INT
);

-- 插入数据
INSERT INTO tb_score (name, subject, score) VALUES
('张三', '语文', 81),
('张三', '数学', 75),
('李四', '语文', 76),
('李四', '数学', 90),
('王五', '语文', 81),
('王五', '数学', 100);

select * from tb_score;

select
    name,
    sum(if(subject = '语文', score, null)) '语文',
    sum(if(subject = '数学', score, null)) '数学'
from tb_score
group by name