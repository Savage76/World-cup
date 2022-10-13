--  How many matches were played each world cup year from 1930

SELECT 
    year, COUNT(round) AS Total_Matches
FROM
    worldcupresults
GROUP BY Year;
 
 -- Total goals scored for each tournament year
 
SELECT 
    year, SUM(homegoals + awaygoals) AS Goals
FROM
    worldcupresults
GROUP BY year;
 

-- All teams who have reached semis and how many times
(SELECT 
    hometeam AS teams, COUNT(round)
FROM
    worldcupresults
WHERE
    round = 'semi-finals'
GROUP BY hometeam) UNION ALL (SELECT 
    AwayTeam AS teams, COUNT(round)
FROM
    worldcupresults
WHERE
    round = 'semi-finals'
GROUP BY AwayTeam);


(SELECT DISTINCT
    hometeam, COUNT(hometeam)
FROM
    worldcupresults
WHERE
    round = 'semi-finals'
GROUP BY hometeam) UNION ALL (SELECT DISTINCT
    awayteam, COUNT(awayteam)
FROM
    worldcupresults
WHERE
    round = 'semi-finals'
GROUP BY awayteam);

-- All teams who have reached finals and how many times
(SELECT 
    hometeam AS teams, COUNT(round)
FROM
    worldcupresults
WHERE
    round = 'final'
GROUP BY hometeam) UNION ALL (SELECT 
    AwayTeam AS teams, COUNT(round)
FROM
    worldcupresults
WHERE
    round = 'final'
GROUP BY AwayTeam);

-- How many goals and average goals scored in all semi-finals
SELECT 
    SUM(homegoals + awaygoals) AS Goals,
    AVG(homegoals + awaygoals) AS Average_goals
FROM
    worldcupresults
WHERE
    round = 'semi-finals';


-- How many goals and average goals scored in all quarter-finals
SELECT 
    SUM(homegoals + awaygoals) AS Goals,
    AVG(homegoals + awaygoals) AS Average_goals
FROM
    worldcupresults
WHERE
    round = 'quarter-finals';

-- How many goals and average number scored in all finals
SELECT 
    SUM(homegoals + awaygoals) AS Goals,
    AVG(homegoals + awaygoals) AS Average_goals
FROM
    worldcupresults
WHERE
    round = 'final';

-- How many matches were played outside quarter- finals and above
SELECT 
    COUNT(round)
FROM
    worldcupresults
WHERE
    round >= 'quarter-finals';


-- New column for each outcome of every match
ALTER TABLE worldcupresults
ADD Outcome char(10);

SELECT 
    homegoals,
    awaygoals,
    CASE
        WHEN homegoals > awaygoals THEN 'H'
        WHEN awaygoals > homegoals THEN 'A'
        WHEN homegoals = awaygoals THEN 'D'
    END AS Outcome
FROM
    worldcupresults;
