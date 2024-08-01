CREATE DATABASE Finance;

USE Finance;

SELECT * FROM bank_loan;

--Total Loan Applications (38576)

SELECT COUNT(id) AS Total_Loan_Applications
FROM bank_loan;


--MTD (4314)

SELECT COUNT(id) AS MTD_Total_Loan_Applications
FROM bank_loan
WHERE MONTH(issue_date) = 12;

--PMTD (4035)

SELECT COUNT(id) AS PMTD_Total_Loan_Applications
FROM bank_loan
WHERE MONTH(issue_date) = 11;

--Total Funded Amount (435757075)

SELECT SUM(loan_amount) AS Total_Funded_Amount
FROM bank_loan;

--Total Received Amount (473070933)

SELECT SUM(total_payment) AS Total_Received_Amount
FROM bank_loan;

--Average of Interest Rate (12.05)

SELECT ROUND(AVG(int_rate), 4)*100 AS Avg_Interest_Rate
FROM bank_loan;

--Average of Debt to Income Ratio (13.33)

SELECT ROUND(AVG(dti), 4)* 100 AS Avg_DTI
FROM bank_loan;

--SECONDARY KEY PERFORMANCE INDICATORS

--Good Loan Percentage (86)

SELECT
	COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100
	/
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan;

--Good Loan Applications (33243)

SELECT COUNT(id) AS Good_Loan_Applications
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current');

--Good Loan Funded Amount (370224850)

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current');

--Good Loan Received Amount (435786170)

SELECT SUM(total_payment) AS Good_Loan_Received_Amount
FROM bank_loan
WHERE loan_status IN ('Fully Paid', 'Current');

--Bad Loan Percentage (13)

SELECT 
	COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100
	/
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan;

--Bad Loan Applications (5333)

SELECT COUNT(id) AS Bad_Loan_Applications
FROM bank_loan
WHERE loan_status = 'Charged Off';

--Bad Loan Funded Amount (65532225)

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount
FROM bank_loan
WHERE loan_status = 'Charged Off';

--Bad Loan Received Amount (37284763)

SELECT SUM(total_payment) AS Bad_Loan_Received_Amount
FROM bank_loan
WHERE loan_status = 'Charged Off';


--Loan Status Grid View

SELECT loan_status, 
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount,
ROUND(AVG(int_rate), 4)*100 AS Avg_Interest_Rate,
ROUND(AVG(dti), 4)*100 AS Avg_DTI
FROM bank_loan
GROUP BY loan_status;

--Monthly Trends by Issues

SELECT 
MONTH(issue_date) AS Month_No,
DATENAME(MONTH, issue_date) AS Month_Name,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date);

--Regional Analysis By State

SELECT
address_state,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan
GROUP BY address_state
ORDER BY Total_Loan_Applications DESC;

--Loan Term Analysis

SELECT
term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan
GROUP BY term
ORDER BY Total_Loan_Applications DESC;

--Employee Length Analysis

SELECT
emp_length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan
GROUP BY emp_length
ORDER BY Total_Loan_Applications DESC;

--Loan Purpose Breakdown

SELECT
purpose,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan
GROUP BY purpose
ORDER BY Total_Loan_Applications DESC;

--Home Ownership Analysis

SELECT
home_ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM bank_loan
GROUP BY home_ownership
ORDER BY Total_Loan_Applications DESC;


