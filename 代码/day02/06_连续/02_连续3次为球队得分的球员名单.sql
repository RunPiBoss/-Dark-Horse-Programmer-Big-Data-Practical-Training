-- 创建分数表，并为列名增加注释
CREATE TABLE tb_score (
    team_name VARCHAR(50) COMMENT '球队名称',
    player_id INT COMMENT '球员ID',
    player_name VARCHAR(50) COMMENT '球员姓名',
    score INT COMMENT '得分',
    score_time DATETIME COMMENT '得分时间'
);

-- 插入数据以满足条件
INSERT INTO tb_score (team_name, player_id, player_name, score, score_time) VALUES
('洛杉矶湖人队', 23, '勒布朗·詹姆斯', 3, '2023-12-25 10:00:00'),
('洛杉矶湖人队', 23, '勒布朗·詹姆斯', 3, '2023-12-25 10:15:00'),
('洛杉矶湖人队', 23, '勒布朗·詹姆斯', 1, '2023-12-25 10:30:00'),
('洛杉矶湖人队', 3, '安东尼·戴维斯', 2, '2023-12-25 10:32:00'),
('洛杉矶湖人队', 23, '勒布朗·詹姆斯', 3, '2023-12-25 10:45:00'),
('洛杉矶湖人队', 23, '勒布朗·詹姆斯', 3, '2023-12-25 11:00:00'),
('洛杉矶湖人队', 23, '勒布朗·詹姆斯', 2, '2023-12-25 11:15:00'),
('洛杉矶湖人队', 23, '勒布朗·詹姆斯', 2, '2023-12-25 11:30:00'),
('金州勇士队', 30, '斯蒂芬·库里', 1, '2023-12-25 10:10:00'),
('金州勇士队', 30, '斯蒂芬·库里', 1, '2023-12-25 10:25:00'),
('金州勇士队', 30, '斯蒂芬·库里', 1, '2023-12-25 10:40:00'),
('金州勇士队', 11, '克莱·汤普森', 2, '2023-12-25 10:45:00'),
('金州勇士队', 30, '斯蒂芬·库里', 2, '2023-12-25 10:55:00'),
('金州勇士队', 30, '斯蒂芬·库里', 2, '2023-12-25 11:10:00'),
('金州勇士队', 30, '斯蒂芬·库里', 3, '2023-12-25 11:25:00'),
('金州勇士队', 30, '斯蒂芬·库里', 3, '2023-12-25 11:40:00'),
('金州勇士队', 30, '斯蒂芬·库里', 3, '2023-12-25 11:55:00');

select * from tb_score;


with t1 as (
    select
        team_name, player_id, player_name, score, score_time,
        lead(player_id, 1) over (partition by team_name order by score_time) as lead_1,
        lead(player_id, 2) over (partition by team_name order by score_time) as lead_2
    from tb_score
)
select
    distinct player_id, player_name
from t1
where player_id=lead_1 and player_id=lead_2
;