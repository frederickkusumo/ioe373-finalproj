CREATE VIEW CustomerAccounts AS
SELECT
  Dem.CustomerID,
  SUM(IIF(Bank.AccountType = 'Personal Loan', 1, 0)) AS PersLoan,
  SUM(IIF(Bank.AccountType = 'Securities Account', 1, 0)) AS SecAccount,
  SUM(IIF(Bank.AccountType = 'CD Account', 1, 0)) AS CDAccount,
  SUM(IIF(Bank.AccountType = 'Online', 1, 0)) AS OnlineAccount,
  SUM(IIF(Bank.AccountType = 'Credit Card', 1, 0)) AS CreditCard
FROM
  CustomerDemographics Dem
  LEFT JOIN CustomerBankAccounts Bank ON Dem.CustomerID = Bank.CustomerID
GROUP BY Dem.CustomerID;


CREATE VIEW DataAnalysis AS
SELECT DISTINCT
  Dem.CustomerID,
  Dem.Age,
  Dem.ZIPCode,
  Dem.Family,
  Dem.Experience,
  IIF(Dem.Education = 1, 1, 0) AS EducUgrad,
  IIF(Dem.Education = 2, 1, 0) AS EducGrad,
  IIF(Dem.Education = 3, 1, 0) AS EducProf,
  Fin.Income,
  Fin.CCAvg,
  Fin.Mortgage,
  Acc.SecAccount,
  Acc.CDAccount,
  Acc.OnlineAccount,
  Acc.CreditCard,
  Acc.PersLoan
FROM ((
  CustomerDemographics Dem
  INNER JOIN CustomerFinancials Fin ON Dem.CustomerID = Fin.CustomerID)
  INNER JOIN CustomerAccounts Acc ON Dem.CustomerID = Acc.CustomerID);
