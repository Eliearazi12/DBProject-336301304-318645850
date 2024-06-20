/*Add check constraint - to make sure the net column in salaries is positive value*/
ALTER TABLE salaries
  ADD CONSTRAINT Net_check CHECK (Net >= 0);

/*Add check constraint - to make sure the rank column in worker is only from specific value*/
ALTER TABLE Worker
  ADD CONSTRAINT rank_constraint CHECK (Rank IN( 'Junior' , 'Intern', 'MidLevel', 'Manager', 'Senior', 'Expert' , 'Director'));
  
/*constraint that every branch has a max of 999 workers*/
ALTER TABLE branches
  ADD CONSTRAINT workes CHECK (NumberOfWorkers < 1000);
