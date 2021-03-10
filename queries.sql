/* ---------------------------------------------------------------------------------------------
   1. Write a query in SQL to find the number of venues for EURO cup 2016.
   >> Encontrar el número de sedes de la EURO cup 2016. */

SELECT count(venue_id) as Num_of_Venues FROM soccer_venue;

+---------------+
| Num_of_Venues |
+---------------+
|            10 |
+---------------+

/* ---------------------------------------------------------------------------------------------
   2. Write a query in SQL to find the number goals scored in EURO cup 2016 within
      normal play Schedule.
   >> Encontrar el número de goles marcados en la EURO Cup 2016 dentro del calendario
      de juego normal. */

SELECT count(goal_id) NumGoals_inNormalTime FROM goal_details WHERE goal_type='N';

+-----------------------+
| NumGoals_inNormalTime |
+-----------------------+
|                    97 |
+-----------------------+

/* ---------------------------------------------------------------------------------------------
   3. Write a query in SQL to find the number of matches ended with draws.
   >> Encuentra el número de partidos que terminaron en empates. */

SELECT count(results) Tied_matches FROM match_mast WHERE results='DRAW';

+--------------+
| Tied_matches |
+--------------+
|           11 |
+--------------+

/* ---------------------------------------------------------------------------------------------
   4. Write a query in SQL to find the number of self-goals scored in EURO cup 2016.
   >> Encuentre el número de auto goles marcados en la EURO Cup 2016. */

SELECT count(goal_type) Num_SelfGoals FROM goal_details WHERE goal_type='O';

+---------------+
| Num_SelfGoals |
+---------------+
|             3 |
+---------------+

/* ---------------------------------------------------------------------------------------------
   5. Write a query in SQL to count the number of matches ended with a results in group stage.
   >> Contar el número de partidos terminados con un resultado en la fase de grupos. */

SELECT count(play_stage) as MatchGroupStage FROM match_mast WHERE play_stage='G';

+-----------------+
| MatchGroupStage |
+-----------------+
|              36 |
+-----------------+

/* ---------------------------------------------------------------------------------------------
   6. Write a query in SQL to find the number of matches were decided on penalties in the
      Round of 16.
   >> Encontrar el número de partidos que se decidieron por penales en los octavos de final */

SELECT count(decided_by) NumMatches FROM match_mast WHERE decided_by='P' AND play_stage='R';

+------------+
| NumMatches |
+------------+
|          1 |
+------------+

/* ---------------------------------------------------------------------------------------------
   7. Write a query in SQL to find the match no, date of play, and goal scored for that
      match in which no stoppage time have been added in 1st half of play.
   >> Encontrar el número de partido, la fecha de juego y el gol marcado para ese partido
      en el que no se ha agregado tiempo adicional en la primera mitad del juego */

SELECT match_no NumMatch, play_date DateMatch, goal_score Score FROM match_mast WHERE stop1_sec='0';

+----------+------------+-------+
| NumMatch | DateMatch  | Score |
+----------+------------+-------+
|        4 | 2016-06-12 | 1-1   |
+----------+------------+-------+

/* ---------------------------------------------------------------------------------------------
   8. Write a query in SQL to find the number of matches ending with only one goal win
      except those matches which was decided by penalty shootout.
   >> Encontrar el número de partidos que terminaron con un solo gol, excepto aquellos
      partidos que se decidieron mediante la tanda de penaltis */

SELECT count(match_no) NumMatches FROM match_mast WHERE goal_score='0-1' OR goal_score='1-0' AND decided_by!='P';

+------------+
| NumMatches |
+------------+
|         13 |
+------------+

/* ---------------------------------------------------------------------------------------------
   9. Write a query in SQL to find the total number of players replaced within normal time of play.
   >> Encontrar el número total de jugadores reemplazados dentro del tiempo normal de juego. */

SELECT count(in_out) NumPlayers FROM player_in_out WHERE in_out='O' AND play_schedule='NT';

+------------+
| NumPlayers |
+------------+
|        275 |
+------------+

/* ---------------------------------------------------------------------------------------------
   10. Write a query in SQL to find the number of penalty shots taken by the teams.
   >>  Encontrar el número de tiros de penalti ejecutados por los equipos */

SELECT team_id IdTeam, sum(kick_no) PenalTaken FROM penalty_shootout GROUP BY (team_id);

+--------+------------+
| IdTeam | PenalTaken |
+--------+------------+
|   1208 |         90 |
|   1211 |         81 |
|   1213 |         50 |
|   1214 |         25 |
|   1221 |         25 |
+--------+------------+

/* ---------------------------------------------------------------------------------------------
   11. Write a query in SQL to find the winner of EURO cup 2016.
   >>  Encontrar al ganador de la EURO cup 2016. */

SELECT soccer_country.country_name WinCountry
FROM match_details
INNER JOIN soccer_country ON match_details.team_id=soccer_country.country_id
WHERE match_details.play_stage='F'
AND match_details.win_loos='W';

+------------+
| WinCountry |
+------------+
| Portugal   |
+------------+

/* ---------------------------------------------------------------------------------------------
   12. Write a query in SQL to find the match no in which Germany played against Poland.
   >>  Encontrar el No. de partido en el que Alemania jugó contra Polonia. */

SELECT match_no
FROM match_details
JOIN soccer_country ON match_details.team_id=soccer_country.country_id
WHERE soccer_country.country_name in ('Poland', 'Germany')
GROUP BY match_no
HAVING count(team_id)=2;

+----------+
| match_no |
+----------+
|       18 |
+----------+

/* ---------------------------------------------------------------------------------------------
   13. Write a query in SQL to display the list of players scored number of goals in every matches.
   >>  Mostrar la lista de jugadores que anotaron goles en todos los partidos. */

SELECT player_mast.player_name PlayerName, count(goal_details.goal_id) GoalsNum
FROM goal_details
INNER JOIN player_mast ON player_mast.player_id=goal_details.player_id
GROUP BY player_name;

+-----------------------+----------+
| PlayerName            | GoalsNum |
+-----------------------+----------+
| ArmandoSadiku         |        1 |
| AlessandroSchopf      |        1 |
| TobyAlderweireld      |        1 |
| YannickCarrasco       |        1 |
| EdenHazard            |        1 |
| RadjaNainggolan       |        2 |
| AxelWitsel            |        1 |
| MichyBatshuayi        |        1 |
| RomeluLukaku          |        2 |
| LukaModric            |        1 |
| IvanPeriSic           |        2 |
| IvanRakitic           |        1 |
| NikolaKalinic         |        1 |
| TomasNecid            |        1 |
| MilanSkoda            |        1 |
| EricDier              |        1 |
| WayneRooney           |        1 |
| DanielSturridge       |        1 |
| JamieVardy            |        1 |
| DimitriPayet          |        3 |
| PaulPogba             |        1 |
| OlivierGiroud         |        3 |
| AntoineGriezmann      |        6 |
| JeromeBoateng         |        1 |
| JulianDraxler         |        1 |
| Mesutozil             |        1 |
| BastianSchweinsteiger |        1 |
| MarioGomez            |        2 |
| ThomasMuller          |        1 |
| ZoltanStieber         |        1 |
| BalazsDzsudzsak       |        2 |
| ZoltanGera            |        1 |
| AdamSzalai            |        1 |
| BirkirSaevarsson      |        1 |
| ArnorIngviTraustason  |        1 |
| BirkirBjarnason       |        2 |
| GylfiSigurdsson       |        1 |
| JonDadiBodvarsson     |        2 |
| KolbeinnSigthorsson   |        2 |
| LeonardoBonucci       |        1 |
| GiorgioChiellini      |        1 |
| EmanueleGiaccherini   |        1 |
| Eder                  |        2 |
| GrazianoPelle         |        2 |
| GarethMcAuley         |        2 |
| NiallMcGinn           |        1 |
| JakubBlaszczykowski   |        2 |
| RobertLewandowski     |        1 |
| ArkadiuszMilik        |        1 |
| RenatoSanches         |        1 |
| Nani                  |        3 |
| RicardoQuaresma       |        1 |
| CristianoRonaldo      |        3 |
| CiaranClark           |        1 |
| RobbieBrady           |        2 |
| WesHoolahan           |        1 |
| BogdanStancu          |        2 |
| VasiliBerezutski      |        1 |
| DenisGlushakov        |        1 |
| OndrejDuda            |        1 |
| MarekHamsik           |        1 |
| VladimirWeiss         |        1 |
| GerardPique           |        1 |
| AlvaroMorata          |        3 |
| Nolito                |        1 |
| FabianSchar           |        1 |
| XherdanShaqiri        |        1 |
| AdmirMehmedi          |        1 |
| OzanTufan             |        1 |
| BurakYilmaz           |        1 |
| NeilTaylor            |        1 |
| AshleyWilliams        |        1 |
| AaronRamsey           |        1 |
| GarethBale            |        3 |
| HalRobson-Kanu        |        2 |
| SamVokes              |        1 |
+-----------------------+----------+

/* ---------------------------------------------------------------------------------------------
   14. Write a query in SQL to find the goalkeeper of the team Germany who didn't concede
       any goal in their group stage matches.
   >>  Encontrar al portero del equipo de Alemania que no permitió ningún gol en sus partidos
       de la fase de grupos. */

SELECT player_name
FROM match_details
INNER JOIN player_mast ON player_mast.player_id=match_details.player_gk
INNER JOIN soccer_country ON soccer_country.country_id=match_details.team_id
WHERE play_stage='G'
AND match_details.goal_score=0
AND soccer_country.country_name='Germany';

+-------------+
| player_name |
+-------------+
| ManuelNeuer |
+-------------+

/* ---------------------------------------------------------------------------------------------
   15. Write a query in SQL to find the match no. and teams who played the match where highest
       number of penalty shots had been taken.
   >>  Encontrar el número de partido y los equipos que jugaron el partido en el que se ha
       ejecutado el mayor número de tiros de penalti */

SELECT match_no, soccer_country.country_name Country
FROM penalty_shootout
JOIN soccer_country ON penalty_shootout.team_id=soccer_country.country_id
GROUP BY match_no, Country
ORDER BY count(kick_no) DESC
LIMIT 2;

+----------+---------+
| match_no | Country |
+----------+---------+
|       47 | Germany |
|       47 | Italy   |
+----------+---------+

/* ---------------------------------------------------------------------------------------------
   16. Write a query in SQL to find the venues where penalty shootout matches played.
   >>  Encontrar los estadios donde se jugaron los partidos de la tanda de penaltis. */

SELECT soccer_venue.venue_name StadiumName
FROM match_mast 
INNER JOIN soccer_venue ON match_mast.venue_id=soccer_venue.venue_id
WHERE decided_by="P";

+-----------------------+
| StadiumName           |
+-----------------------+
| StadeGeoffroyGuichard |
| StadeVElodrome        |
| StadedeBordeaux       |
+-----------------------+

/* ---------------------------------------------------------------------------------------------
   17. Write a query in SQL to find the name of the venue with city where the EURO cup
       2016 final match was played.
   >>  Encontrar el nombre del estadio con la ciudad donde se jugó la final de la EURO Cup 2016. */
SELECT soccer_venue.venue_name StadiumName, soccer_city.city City
FROM match_mast
INNER JOIN soccer_venue ON match_mast.venue_id=soccer_venue.venue_id
INNER JOIN soccer_city ON soccer_venue.city_id=soccer_city.city_id
WHERE play_stage='F';

+---------------+-------------+
| StadiumName   | City        |
+---------------+-------------+
| StadedeFrance | Saint-Denis |
+---------------+-------------+

/* ---------------------------------------------------------------------------------------------
   18. Write a query in SQL to find the total number of goals scored by each player within normal
       play schedule and arrange the result set according to the heighest to lowest scorer.
   >>  Encontrar el número total de goles marcados por cada jugador dentro del calendario
       de juego normal y organizar el conjunto de resultados de acuerdo con el marcador
       de mayor a menor. */

SELECT player_mast.player_name PlayerName, count(goal_details.goal_id) GoalsNum
FROM goal_details
INNER JOIN player_mast ON player_mast.player_id=goal_details.player_id
WHERE goal_schedule='NT'
GROUP BY PlayerName
ORDER BY GoalsNum DESC;

+----------------------+----------+
| PlayerName           | GoalsNum |
+----------------------+----------+
| AntoineGriezmann     |        5 |
| OlivierGiroud        |        3 |
| GarethBale           |        3 |
| AlvaroMorata         |        3 |
| CristianoRonaldo     |        3 |
| Nani                 |        3 |
| BogdanStancu         |        2 |
| MarioGomez           |        2 |
| JakubBlaszczykowski  |        2 |
| RomeluLukaku         |        2 |
| BalazsDzsudzsak      |        2 |
| RobbieBrady          |        2 |
| RadjaNainggolan      |        2 |
| IvanPeriSic          |        2 |
| GarethMcAuley        |        2 |
| BirkirBjarnason      |        2 |
| DimitriPayet         |        2 |
| KolbeinnSigthorsson  |        2 |
| HalRobson-Kanu       |        2 |
| AshleyWilliams       |        1 |
| PaulPogba            |        1 |
| BurakYilmaz          |        1 |
| OzanTufan            |        1 |
| NikolaKalinic        |        1 |
| JonDadiBodvarsson    |        1 |
| AlessandroSchopf     |        1 |
| ZoltanGera           |        1 |
| LeonardoBonucci      |        1 |
| Mesutozil            |        1 |
| SamVokes             |        1 |
| YannickCarrasco      |        1 |
| RenatoSanches        |        1 |
| RobertLewandowski    |        1 |
| XherdanShaqiri       |        1 |
| JeromeBoateng        |        1 |
| ArnorIngviTraustason |        1 |
| JulianDraxler        |        1 |
| TobyAlderweireld     |        1 |
| MichyBatshuayi       |        1 |
| EdenHazard           |        1 |
| WayneRooney          |        1 |
| GiorgioChiellini     |        1 |
| MarekHamsik          |        1 |
| FabianSchar          |        1 |
| OndrejDuda           |        1 |
| EricDier             |        1 |
| LukaModric           |        1 |
| ArkadiuszMilik       |        1 |
| ThomasMuller         |        1 |
| GerardPique          |        1 |
| WesHoolahan          |        1 |
| CiaranClark          |        1 |
| EmanueleGiaccherini  |        1 |
| AdamSzalai           |        1 |
| ZoltanStieber        |        1 |
| VladimirWeiss        |        1 |
| NeilTaylor           |        1 |
| DenisGlushakov       |        1 |
| AdmirMehmedi         |        1 |
| JamieVardy           |        1 |
| Eder                 |        1 |
| IvanRakitic          |        1 |
| MilanSkoda           |        1 |
| TomasNecid           |        1 |
| Nolito               |        1 |
| AxelWitsel           |        1 |
| GylfiSigurdsson      |        1 |
| BirkirSaevarsson     |        1 |
| ArmandoSadiku        |        1 |
| AaronRamsey          |        1 |
+----------------------+----------+

/* ---------------------------------------------------------------------------------------------
   19. Write a query in SQL to find the scorer of only goal along with his country
       and jersey number in the final of EURO cup 2016.
   >>  Encontrar al autor del único gol junto con su país y número de camiseta en la
       final de la EURO Cup 2016. */

SELECT player_mast.player_name, soccer_country.country_name, jersey_no
FROM goal_details
INNER JOIN player_mast ON goal_details.player_id=player_mast.player_id
INNER JOIN soccer_country ON player_mast.team_id=soccer_country.country_id
WHERE play_stage='F';

+-------------+--------------+-----------+
| player_name | country_name | jersey_no |
+-------------+--------------+-----------+
| Eder        | Portugal     |         9 |
+-------------+--------------+-----------+

/* ---------------------------------------------------------------------------------------------
   20. Write a query in SQL to find the name and country of the referee who managed the
       opening match.
   >>  Encontrar el nombre y el país del árbitro que dirigió el partido de apertura. */

SELECT referee_mast.referee_name Referee, soccer_country.country_name Country
FROM match_mast
INNER JOIN referee_mast ON match_mast.referee_id=referee_mast.referee_id
INNER JOIN soccer_country ON referee_mast.country_id=soccer_country.country_id
WHERE match_mast.match_no='1';

+--------------+---------+
| Referee      | Country |
+--------------+---------+
| ViktorKassai | Hungary |
+--------------+---------+

/* ---------------------------------------------------------------------------------------------
   21. Write a query in SQL to find the name and country of the referee who assisted
       the referee in the final match.
   >>  Encontrar el nombre y el país del árbitro que asistió al árbitro en el partido final. */

SELECT asst_referee_mast.ass_ref_name AssistName, soccer_country.country_name Country
FROM match_details
INNER JOIN asst_referee_mast ON match_details.ass_ref=asst_referee_mast.ass_ref_id
INNER JOIN soccer_country ON asst_referee_mast.country_id=soccer_country.country_id
WHERE play_stage='F';

+------------+---------+
| AssistName | Country |
+------------+---------+
| SimonBeck  | England |
| JakeCollin | England |
+------------+---------+

/* ---------------------------------------------------------------------------------------------
   22. Write a query in SQL to find the stadium hosted the final match of EURO cup 2016
       along with the capacity, and audance for that match.
   >>  Encontrar el estadio que albergó el partido final de la Eurocopa 2016 junto con
       la capacidad y la audiencia para ese partido. */

SELECT soccer_venue.venue_name StadiumName, soccer_venue.aud_capacity Capacity, match_mast.audence Audence
FROM match_mast
INNER JOIN soccer_venue ON match_mast.venue_id=soccer_venue.venue_id
WHERE play_stage='F';

+---------------+----------+---------+
| StadiumName   | Capacity | Audence |
+---------------+----------+---------+
| StadedeFrance |    80100 |   75868 |
+---------------+----------+---------+

/* ---------------------------------------------------------------------------------------------
   23. Write a query in SQL to find the player who was the first player to be sent off at
       the tournament EURO cup 2016.
   >>  Encontrar el jugador que fue el primer expulsado en el torneo de la Eurocopa 2016. */

SELECT player_mast.player_name FirstBooked
FROM player_booked
INNER JOIN player_mast ON player_booked.player_id=player_mast.player_id
WHERE player_booked.sent_off='Y'
ORDER BY match_no ASC
LIMIT 1;

+---------------+
| FirstBooked   |
+---------------+
| OlivierGiroud |
+---------------+

/* ---------------------------------------------------------------------------------------------
   24. Write a query in SQL to find the yellow cards received by each country.
   >>  Encontrar las tarjetas amarillas recibidas por cada país. */

SELECT soccer_country.country_name Country, count(player_booked.team_id) YellowCards
FROM player_booked
INNER JOIN soccer_country ON player_booked.team_id=soccer_country.country_id
WHERE sent_off=''
GROUP BY player_booked.team_id
ORDER BY Country;

+-------------------+-------------+
| Country           | YellowCards |
+-------------------+-------------+
| Albania           |          10 |
| Austria           |           6 |
| Belgium           |           9 |
| Croatia           |           8 |
| CzechRepublic     |           4 |
| England           |           3 |
| France            |          12 |
| Germany           |          11 |
| Hungary           |          12 |
| Iceland           |          12 |
| Italy             |          16 |
| NorthernIreland   |           6 |
| Poland            |          10 |
| Portugal          |          13 |
| RepublicofIreland |           8 |
| Romania           |          10 |
| Russia            |           2 |
| Slovakia          |           9 |
| Spain             |           5 |
| Sweden            |           3 |
| Switzerland       |           5 |
| Turkey            |           7 |
| Ukraine           |           5 |
| Wales             |          11 |
+-------------------+-------------+

/* ---------------------------------------------------------------------------------------------
   25. Write a query in SQL to find the match where no stoppage time added in 1st half of play.
   >>  Encontrar el partido en el que no se haya añadido tiempo en la primera mitad del juego. */

SELECT match_no
FROM match_mast
WHERE stop1_sec='0';

+----------+
| match_no |
+----------+
|        4 |
+----------+