# Week 3-Customer Lifetime Value

Dates: 2019년 9월 30일 → 2019년 10월 4일
Type: 📒 Lesson

# Customer Lifetime Value (CLV)

## Definition

- It computes the dollar value of an individual customer relationship (expected Net Present Value of the cash flows from a customer relationship)
- It is both backward looking and forward looking
    - Computing value of past customers
    - Using that information to project forward

## When to use CLV?

- Determine how much to spend to acquire a customer
- Determine how aggressively to spend to retain a customer or a group of customers
- Value a company

## Calculating CLV -with example of Netflix

| Expected Customer Lifetime in Months | 20/months |
| --- | --- |
| Average Gross Margin per Month per Customer | $50 |
| Average Marketing Costs per Month per Customer | $0 |
| Average Net Margin per Month per Customer
(Average Gross Margin/month,customer - Average Marketing Costs/month.customer) | $50 |
| Customer Lifetime Value
(Expected Customer Lifetime/month * Average Net margin/month) | $1000 |
- 신규 고객의 가치는 약 1,000달러라고 할 수 있음
- 따라서 신규고객을 유치할 때 1,000달러 이상을 지출하면 넷플릭스의 손해
- CLV = all future customer revenue streams minus product and servicing costs and remarketing costs.

### Base CLV Model - Example

Assumptions

- Net Margin per Netflix Customer = M(Gross Margin per customer) - R(Retention Spending)
- Retention rate(r) = 80%
- Number of customers who joined Netflix in June2014 = 100

| Month | Number of Customers | Total Net Profit | Total Net Profit | Present Value of 
Total Net Profit |
| --- | --- | --- | --- | --- |
| June 2014 | 100 | [M-R]*100 | 50*100 | 5,000 |
| July 2014 | r * 100 = 80 | r * 100 * [M-R] | 80*50 | 4,000 |
| August 2014 | r*(r*100)= | r^2 100 * [M-R] | 64*50 |  |
| September 2014 | r*(r*(r*100))) =  | r^3*100*[M-R] |  |  |

### Base CLV Model

$M : Contribution per period from active customers. **Contribution = Sales Price - Variable Costs**

$R : Retention Spending per period per active customer

r: retention rate(fraction of current customers retained each period)

d: discount rate per period (money that the company could earn when investing in financial market)

Present Value of net profit calculation is extended up to infinity...

CLV = [$M - $R] x [(1+d) / (1+d-r)]

- [$M - $R] : Short-Term Margin
- [(1+d) / (1+d-r)] : Long-Term Multiplier

If all else is equal, an increase in retention rate would affect 

- Short -term margin remains the same
- Long-term multiplier increases

### Netflix Example

Netflix charges $19.95 per month. Variable costs are about $1.50 per account per month. With marketing spending of $6 per year, their attrition is only 0.5% per month. At a monthly discount rate of 1%, what is the CLV of a customer?

| $M | 19.95 - 1.50 = 18.45 |
| --- | --- |
| $R | $6 / 12 = $0.5 |
| r | 1 - 0.005 = 0.995 |
| d | 0.01 |
| CLV |      [$M - $R] x [(1+d)/(1+d-r)]
=  [$18.45 - $0.5] x [(1+0.01) / (1+.01 - 0.995)]
=  [$17.95] x [67.333]     =  $1,209 |
- Scenario
    
    If Netflix cuts retention spending from $6 to $3 per year, they expect attrition will go up to 1% per month. Should they cut the retention?
    
    → To decide, Netflix have to recalculate changed CLV
    
    | $M | $19.95 - $1.50 = $18.45 |
    | --- | --- |
    | $R | $3/12 = $0.25 |
    | r | 1 - 0.01 = 0.99 |
    | d | 0.01 |
    | CLV | [$18.45 - $0.25] x [(1 + .01) / (1 + .01 - 0.99)]
    = $919 |

## Issues when Applying CLV

1. Time Horizon - Should we assume the company situation is the same for infinite?
    
    Looking at the percent of CLV accruing in the first five years
    
    ![Untitled](Week%203-Cus%20c3d04/Untitled.png)
    
    - if the discount rate goes down, it’s stable market
    - if the discount rate goes up, it’s volatile market
    - Increased retention rate implies that the customers are more likely to stay with the company for a long time. the percent of overall CLV accrued decreases for first five years.
2. Initial Margin
    - Customer pays before using the service e.g. apartment tentals, Netfix, Hulu
        
        CLV = [$M - $R] x [(1+d)/(1+d-r)]
        
    - Customer pays after using the service e.g. credit cards
        
        CLV = [$M - $R] x [r/(1+d-r)]          (   (M-R)  x [(1+d)/(1+d-r)] - m )  - extracting first margin )
        
3. Cohort and Incubate
    - Cohort means ‘ customers acquired at the same time period (month, quarter or year)
    - Since retention changes with time since acquisition (시간이 지날수록 점차 증가했다가 시간이 많이 흐른 뒤에는 그대로 유지됨), CLV calculations are better if they are done separately for each cohort
4. Contractual vs Non Contractual
    - Xfinity and Netflix have a contract with customers
    - They know when a customer unsubscribes to the service
    - This helps is knowing lifetime duration and retention rate
    
    What if a customer does not sign a contract to use a service? e.g Kroger, grocery stores
    
    → You have to use empirical model to predict retention rate