/*
Indian Election Data Exploration
*/

SELECT *
FROM IndiaElectionResults..constituencywise_details

SELECT *
FROM IndiaElectionResults..

SELECT *
FROM IndiaElectionResults..partywise_results

SELECT *
FROM IndiaElectionResults..states

SELECT *
FROM IndiaElectionResults..statewise_results

--Total seats

SELECT
DISTINCT COUNT(parliament_constituency) AS Total_Seats
FROM constituencywise_results

--Total number of seats available for elections in each state

SELECT
s.state AS State_name,  COUNT (cr.parliament_constituency) AS Total_Seats
FROM IndiaElectionResults..constituencywise_results cr
INNER JOIN IndiaElectionResults..statewise_results sr ON cr.parliament_constituency = sr.parliament_constituency
INNER JOIN IndiaElectionResults..states s ON  sr.state_id = s.state_id
GROUP BY s.state

--Total seats won by NDA Alliance

SELECT 
     SUM( CASE 
	          WHEN Party IN(
			     'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
				'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
			               ) THEN [Won]
				ELSE 0	 
	     END) AS NDA_Total_Seats_Won
FROM IndiaElectionResults..partywise_results

--Seats won by NDA Alliance Parties

SELECT	
	Party AS Party_Name, 
	Won AS Seats_Won
FROM
	IndiaElectionResults..partywise_results
WHERE 
	Party IN (
			    'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
				'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
			)
ORDER BY Seats_Won DESC

--Total seats won by I.N.D.I.A Alliance

SELECT 
     SUM( CASE 
	          WHEN Party IN(
			     'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
			               ) THEN [Won]
				ELSE 0	 
	     END) AS INDIA_Total_Seats_Won
FROM IndiaElectionResults..partywise_results

--Seats won by INDIA Alliance

SELECT 
party, won
FROM  IndiaElectionResults..partywise_results
WHERE Party IN(
			     'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
			               ) 
ORDER BY Won DESC

--Add a new column in the table partywise_results to get the party alliance

ALTER TABLE IndiaElectionResults..partywise_results 
ADD party_alliance VARCHAR(50)

--I.N.D.I.A Alliance

UPDATE IndiaElectionResults..partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
				);

--NDA Alliance

UPDATE IndiaElectionResults..partywise_results
SET party_alliance = 'NDA'
WHERE Party IN (
			'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
				'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
				);

--Parties with no alliance
UPDATE IndiaElectionResults..partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

--Total seats won by each alliance

SELECT party_alliance, SUM(Won) AS TotalSeatsWon
FROM IndiaElectionResults..partywise_results
GROUP BY party_alliance

--Easier way to get seats won by each alliance

SELECT party, Won
FROM IndiaElectionResults..partywise_results
WHERE party_alliance = 'I.N.D.I.A'
ORDER BY Won DESC

SELECT party, Won
FROM IndiaElectionResults..partywise_results
WHERE party_alliance = 'NDA'
ORDER BY Won DESC

SELECT party, Won
FROM IndiaElectionResults..partywise_results
WHERE party_alliance = 'OTHER'
ORDER BY Won DESC

--Winning candidate's name, party name, total votes, margin of victory for a specific state and constituency
-- Change constituency_name to find results for a specific constituency
SELECT
cr.Winning_Candidate, pr.Party, cr.Total_Votes, cr.Margin, s.State, cr.Constituency_Name, pr.party_alliance
FROM IndiaElectionResults..constituencywise_results cr
INNER JOIN IndiaElectionResults..partywise_results pr ON cr.Party_ID = pr.Party_ID
INNER JOIN IndiaElectionResults..statewise_results sr ON  cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN IndiaElectionResults..states s ON sr.state_id = s.State_ID
WHERE  cr.Constituency_Name = 'AGRA'

--Distribution of EVM votes VS Postal votes for candidates in a specific constituency

SELECT
cd.EVM_Votes, cd.Postal_Votes, cd.Total_Votes, cd.Candidate, cr.Constituency_Name
FROM IndiaElectionResults..constituencywise_details cd
INNER JOIN IndiaElectionResults..constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE cr.Constituency_Name = 'AMETHI'

--Parties that won the most seats in a state and the number of seats each party won

SELECT pr.Party, COUNT(pr.Won) AS SeatsWon
FROM IndiaElectionResults..partywise_results pr
INNER JOIN IndiaElectionResults..constituencywise_results cr ON pr.Party_ID = cr.Party_ID
INNER JOIN IndiaElectionResults..statewise_results sr ON  cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN IndiaElectionResults..states s ON sr.State_ID = s.State_ID
WHERE s.State ='Andhra Pradesh'
GROUP BY pr.Party
ORDER BY SeatsWon DESC

--Total number of seats won by each party alliance in each state

SELECT s.State, SUM(CASE WHEN pr.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_SeatsWon,
SUM(CASE WHEN pr.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_SeatsWon,
SUM(CASE WHEN pr.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_SeatsWon
FROM IndiaElectionResults..partywise_results pr
INNER JOIN IndiaElectionResults..constituencywise_results cr ON pr.Party_ID = cr.Party_ID
INNER JOIN IndiaElectionResults..statewise_results sr ON  cr.Parliament_Constituency = sr.Parliament_Constituency
INNER JOIN IndiaElectionResults..states s ON sr.State_ID = s.State_ID
--WHERE s.State ='Rajasthan'
GROUP BY s.State 

--Candidate that received the highest number of EVM votes in each constituency (Top 10)

SELECT TOP 10
cr.Constituency_Name,cd.Constituency_ID, cd.Candidate, cd.EVM_Votes
FROM  IndiaElectionResults..constituencywise_details cd 
JOIN IndiaElectionResults..constituencywise_results cr ON  cd.constituency_ID = cr.Constituency_ID
WHERE
	cd.EVM_Votes = (
	          SELECT MAX( cd1.EVM_Votes)
			  FROM  IndiaElectionResults..constituencywise_details cd1
			  WHERE cd1.Constituency_ID = cd.Constituency_ID
					)
ORDER BY cd.EVM_Votes DESC

--Candidate that won and the runner-up candidate in each constituency state
-- CTE Ranked candidates
WITH RankedCandidates AS (
		SELECT
		cd.Constituency_ID, cd.Candidate, cd.Party, cd.EVM_Votes, cd.Postal_Votes, cd.EVM_Votes + cd.Postal_Votes AS TotalVotes,
		ROW_NUMBER() OVER(PARTITION BY cd.constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
		FROM 
		IndiaElectionResults..constituencywise_details cd
        INNER JOIN IndiaElectionResults..constituencywise_results cr ON  cd.constituency_ID = cr.Constituency_ID 
		INNER JOIN IndiaElectionResults..statewise_results sr ON  cr.Parliament_Constituency = sr.Parliament_Constituency
        INNER JOIN IndiaElectionResults..states s ON sr.State_ID = s.State_ID
		WHERE s.State = 'Maharashtra'
						)

SELECT
		cr.Constituency_Name,
		MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
		MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
RankedCandidates rc 
INNER JOIN IndiaElectionResults..constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY cr.Constituency_Name
ORDER BY cr.Constituency_Name

--Total number of seats, candidates, parties, votes and the breakdown of EVM and postal votes for each state

SELECT 
	COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
	COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
	COUNT(DISTINCT p.Party) AS Total_Parties,
	SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
	SUM(cd.EVM_Votes) AS Total_EVMVotes,
	SUM(cd.Postal_Votes) AS Total_PostalVotes
FROM
	IndiaElectionResults..constituencywise_results cr 
	INNER JOIN IndiaElectionResults..constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
	INNER JOIN IndiaElectionResults..statewise_results sr ON  cr.Parliament_Constituency = sr.Parliament_Constituency
    INNER JOIN IndiaElectionResults..states s ON sr.State_ID = s.State_ID
	INNER JOIN IndiaElectionResults..partywise_results p ON cr.Party_ID = p.Party_ID
WHERE s.State = 'Maharashtra'