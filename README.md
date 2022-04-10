## dbsp22_project Phase C 
### Shelby Coe (scoe4) and Sydney Friedel (sfriede5)

First, we want to address changes in our project since Phase B. This isn't a concern since we already discussed making this change with Punit and received his approval, but we want to make Professor More and the CAs aware. While retrieving data, we realized that many attributes, all of which stem from U.S. government data, were severely limited in terms of number/frequency of recordings. This meant we were not able to find two sets of recordings (old and new) for all attributes, so we could not create the "RelationOld" and "RelationNew" relations we described in our Phase B schema without having mostly null values in each table. 

Given this limitation, we and our advisor found it best to only collect data from the 2019-2020 period, as we could find data for nearly all attributes during this time, and eliminate proposed queries concerned with how different state statistics changed over time. We modified our database schema to not have "old" and "new" versions of each relation, but just a single version of each. Note that though this eliminates some of our original proposed queries, we created additional, equally complex queries to make up for it. All the new queries are listed below. 
Also, there are a few slight tweaks to the schema described in Phase B: some attribute names were changed to better reflect the data we found (e.g. 'obesityPercent' was renamed to 'obesityPrevalence'), a few new race attributes were added to the Demographics relation, and the avgMotherAge and avgFatherAge attributes had to be removed from the Health relation, as we could not find this data for the 2019-2020 time period. 

Lastly, we want to explain our reasoning for the tuples we chose to create our relation-small.txt files. Given that our project domain is the sociological statistics about the 50 U.S. states, we thought it would be best and most interesting to select a small subset of states with a wide variety of population, size, political affiliation, and other factors. In addition, several states within this subset had null values for attributes across different relations, making this a somewhat adversarial set in terms of future queries and computations.

##### New Proposed Queries:
1. In order of best to worst-scored public education system (in terms of NAEP and standardized test scores), list the unemployment rate, percent of population that is homeless, and the average starting salary of teachers for each state. 
2. What is the average household income for states where the teen pregnancy rate is higher than the average rate for all states?
3. Do states the healthiest states (in terms of cancer mortality, obesity, drug overdoses, etc.) have the highest average incomes and GDP?
4. What is the average income for adults in the five states with the highest high school graduation rate? Lowest high school graduation rate?
Does this change when using college graduation rates?
5. What is the mean average income in each state for U.S. born individuals across all 50 states? How does this compare to foreign born individuals?
6. What is the percent of adults who have completed college for states with major metropolitan areas and the highest percent of unhoused people?
7. Of the states in which abortion rate is significantly higher than the average rate for all states, what was the average household income for that state that year? What percent of the state's population was above the poverty line?
8. For states in which the rate of drug overdoses and sucide are significantly lower than other states, what was the highschool graduation rate? Average SAT/ACT scores?
9. In descending order of education spending per pupil, list each state's percentage of adults who have completed college and the average highschool graduation rate.
10. Of states with the highest rates of teen suicide, what is their average annual education funding and teacher starting salary? How does this compare to states with the lowest rates of teen suicide?
11. What is the difference in overall health for states with very different rates of unhoused people, percent in poverty, and unemployment rates?
12. For states with the highest and lowest median incomes, what is the difference between the US-born and foreign-born median incomes, and how racially diverse is this state?
13. For states with a relatively high unemployment rate compared to the average of all states, list the risk factor and health statistics. How do these values compare to the average values for all states?
14. For states with the highest and lowest cancer mortality rates, how do the number of STIs per 100,000 people, obesity prevalence, and drug overdose statistics compare?
15. Ordering the states from least to most racially diverse, list the state GDP and median household income.
16. What is the average graduation rate of each state for the five states with the lowest poverty levels? What is the poverty level of each state for the five states with the highest graduation rate? Is there an overlap?
17. What is the average salary of teachers in the best performing states in terms of standardized test scores and highschool graduation rates?
18. What is the average difference between high school teacher salaries in the most and least densely populated states?
19. List the states and the average income of working adults for states ordered by the average teacher salary of the state.
20. List the states and the average income of working adults for states ordered by the average gross rent as a percentage of household income.

