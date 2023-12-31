drop database if exists db_1;
create database db_1;
use db_1;


Create table If Not Exists Matches (player_id int, match_day date, result ENUM('Win', 'Draw', 'Lose'));
Truncate table Matches;
insert into Matches (player_id, match_day, result) values ('1', '2022-01-17', 'Win');
insert into Matches (player_id, match_day, result) values ('1', '2022-01-18', 'Win');
insert into Matches (player_id, match_day, result) values ('1', '2022-01-25', 'Win');
insert into Matches (player_id, match_day, result) values ('1', '2022-01-31', 'Draw');
insert into Matches (player_id, match_day, result) values ('1', '2022-02-08', 'Win');
insert into Matches (player_id, match_day, result) values ('2', '2022-02-06', 'Lose');
insert into Matches (player_id, match_day, result) values ('2', '2022-02-08', 'Lose');
insert into Matches (player_id, match_day, result) values ('3', '2022-03-30', 'Win');

select * from matches;

# todo 题目要求: 选手的 连胜数 是指连续获胜的次数，且没有被平局或输球中断。
# todo 编写解决方案来计算每个参赛选手最多的连胜数。
# todo 结果可以以 任何顺序 返回。

with t1 as (
    select
        player_id, match_day, result,
        row_number() over (partition by player_id order by match_day) as rn1,
        row_number() over (partition by player_id, result order by match_day) as rn2,
        (row_number() over (partition by player_id order by match_day)) - (row_number() over (partition by player_id, result order by match_day)) as diff
    from matches
)
, t2 as (
    select
        player_id, result, diff,
        count(*) as cnt
    from t1
    where result='Win'
    group by player_id, result, diff
)
, t3 as (
    select
        player_id,
        max(cnt) as longest_streak
    from t2
    group by player_id
)
select
    a.player_id,
    ifnull(b.longest_streak, 0) longest_streak
    # , coalesce(b.longest_streak, 0) longest_streak_2 # coalesce 返回第一个不为null的值
from (select distinct player_id from matches) a
left join t3 b on a.player_id=b.player_id
;
;