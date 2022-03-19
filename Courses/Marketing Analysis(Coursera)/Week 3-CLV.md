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