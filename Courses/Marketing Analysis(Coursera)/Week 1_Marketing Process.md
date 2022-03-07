# Week 1

Dates: 2022년 2월 28일 → 2022년 3월 6일
Topic: Course Overview, Marketing Process
Type: 📒 Lesson

### Course Aim

- Use analytics to improve my marketing process
    - Understand, measure, and track brand value
    - Understand, calculate, use customer lifetime value to inform business and marketing decisions
    - Understand, design, implement, and analyze marketing experiments
    - Understand, interpret, and apply insights from regression analysis
    

### Quizzes

- Practice Quizzes: Provided each week as an experience solving the graded quizzes
- Graded Quizzes: Provided at the **end of each module.** Each constitutes 10% of the final score. Minimum **passing grade is 80 percents.**

### Assessments

- Special Promotion: Get practicing analytic skills on  [http://www.management-by-the-numbers.com/coursera/](http://www.management-by-the-numbers.com/coursera/)   Promotion Code: Raj
- Peer-reviewed projects: Each assignments worth 25% of the final grade. Minimum passing grade is 80 percents.

### Reference Book

- Cutting Edge Marketing Analytics

---

### The Marketing Process

Different Kinds of Marketing Analytics

1. Descriptive Analytics (Looking at the past)
- Alerts : What actions are needed?
- Ad hoc reports: How many, how often, where? Check Abnormal happenings
1. Predictive Analytics (so what will happen?)
- Randomized Testing: What if we try this? - AB Testing, Price/Promotion changes bring what
- Predictive Modeling: What will happen next?
1. Prescriptive
- Optimization: What’s the best option?

The depth of Intelligence will be like:

Ad hoc reports→ Alerts → Randomized Testing → Predictive Modeling → Optimization

![Untitled](Week%201%20fc524/Untitled.png)

### Airbnb Marketing Process

- Find Objectives
    
    → the Airbnb could make objective about how to improve customer experience
    
- Make Strategies
    - Segmentiation
        
        means categorizing customers based on standards: ex. travel purpose, price sensitivity
        
    - Targeting
        
        Looking at which segment to focus on
        
    - Positioning
        
        뭔소린지 모르겟네
        
- Strategic challenge of Airbnb
    - To find this, first understand how they make money (Airbnb case- makes guests and hosts come together and Airbnb charges both sides of the platform)
    
    → Strategic challenge Airbnb Address: make the portal to be rented as soon as possible
    
- Find data generated on the website to address the strategic challenge

### Steps of Analytics Process

1. Build a Mental model : To identify the metric Airbnb is trying to maximize (metric: profit per property)
    - how mental model is used for the marketing process?
        - To outline the factors that influence the target metric
        - As a hypothesis to test the data
        - To target an intuitive sense of what is happening in the market
        - As the basis of predictive model
    
    In this case, profit Airbnb is trying to maximize is profit per property: obtained by multiplying gross margin .. This consists of property price(the company charge for), number of rentals, minimum stay etc
    
    (1) Find what target(Customer) influence
    
    In this case, numbers of rentals
    
    (2) Find how customers pick their rental place : ITC, other customers’ reviews
    
    (3) Find out contributors to the rental number to build a predictive model
    
    ex) Review data→ Use text analytics. Change raw data with grammar mistakes into review sentiment. **review_sentiment** is something makes text data into numbers (like scores)
    
    (4) Make final predictive model (Regression) and analyze the influences of contributors
    
    Airbnb look into contributors to find out which contributors influence the most for different kinds of groups
    
     
    

### Descriptive Analytics

Looking at historic information and Summarizing the past information

ex) In Airbnb Case, it’s about reports how often a property is rented, in which place, and why and what are happening in terms of some abnormalities.

오답정리

- Make a slogan for over-the counter sleep pill
    
    my answer: segmentation → correct
    

**질문 3**

**Your company sells a lot of recycled copy paper to companies, but not school districts. What step in the marketing process are you going to focus on to bring in business from schools?**

My answer: Strategy

Correct answer: Tactics  (b.c already did segmentation(market is consists of companies and schools) , already determined target(school), already positioned the product (recycled copy paper versus regular one)

****질문 4****

**Food & Wine Magazine just published their list of the best restaurants and you are surprised that the restaurant you manage isn't on it. You head to Yelp.com to read your online reviews. What's your next step?**

My answer: Plug the review into a prescriptive model to figure out what you should do to improve ratings 

Correct answer: Find the review sentiment score suing R software(b.c Reviews cannot be plugged into a model until text analytics)

****질문 7****

**Your company sells sports energy drinks and has created a campaign with the slogan "Ski all day and party all night." What element of strategy does this represent?**

My answer: Segmentation

Correct answer: Targeting (The company is targeting young skiers who like party)

****질문 8****

**You work for a popular athletic wear company that wants to launch a women's swimsuit line in the spring. What type of analytics will you conduct to determine how one-piece vs. two-piece bathing suits will sell this year?**

My answer: Prescriptive (thought it is about optimization - which one is better)