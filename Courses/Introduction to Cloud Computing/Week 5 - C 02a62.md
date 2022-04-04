# Week 5 - Cloud Security

Dates: 2019년 10월 17일
Type: 📒 Lesson

# Security Issue in Cloud

- In traditional way, you are fully responsible for the entire app server you deploy
- In cloud model, the responsibility is shared between you and the cloud provider.
- You are responsible for : the workload, data
- The cloud provider is responsible for : security of the platform
- Devops and Security
    - Security needs to be forethought, not afterthought (아키텍쳐 설계 단에서 고려)
        
        ex) Are there encrypt data or sensitive data included?
        
    - SecDevOps : embed security into the entire lifecycle.

## Cloud Security Concerns

- Data Loss and Leakage
- Unauthorized Access
- Insecure interfaces and APIs

1. First line of defense
    1. Authenticate and authorize users
    2. Provide user-specific access
        
        Main types of users
        
        - Administrative users (Administrators, Operators, Managers)
            
            roles that typically create, update and delete application and instances, and also need insight into their team members’ activities
            - An attacker with administrative access could be:
            
            - Steal data from databases
            - Deploy malicious applications
            - Deface and destroy existing applications
        - Developer users (Application/Platform developer, App publisher)
            
            Can read sensitive information, create applications, update and delete applications
            
        - Application users
    
    → Colud can manage users differently through API key
    
    ![Untitled](Week%205%20-%20C%2002a62/Untitled.png)
    
    → **Reporting** helps provide a user-centric view of access to resources or resource-centric view of access by users. Administrators can 
    
    - Decide which users can access which resources
    - Changes in user access rights
    - Access methods used by each user
    
    ![Untitled](Week%205%20-%20C%2002a62/Untitled%201.png)
    
    → **Audit and Compliance** is a critical service within identity and access management framework, both for cloud provider and cloud consumer.
    
    → **User and Service Access Management** is a streamline access control which enables cloud application/service owners to provision and de-provision
    
    → Require maximum control over the whole life cycle for users to mitigate risks
    
    Ways to mitigate risks..
    
    - Provisioning users by specifying roles on resources for each user
    - Password policies that requires more complex character patterns
    - Multifactor authentication like time-based one-time passwords
    - Immediate de-provisioning of access when users leave or change roles
    
    ** Access groups : A group of users created so that the same access can be assigned to all entities within the group with one or more access policies ( Access policies are defined by subject - who , target - what resource or service, role - to which the resource granted 범위 의미)
    

## Encryption

The last line of defense in a layered security model.

Certificate management → Key management → Data Access Control → Encrypts data

- **Definition of Encryption**
    
    Scrambling data in a way that makes it illegible. Enables only selected users can see the data
    
    - Encryption Algorithm: Defines the rules by which data will be transformed
    - Decryption Key: Defines how encrypted data will be transformed back to legible data
    
    ![Untitled](Week%205%20-%20C%2002a62/Untitled%202.png)
    
- Data Protection States
    - Encryption at Rest
        - Protects stored data
        - Multiple encryption options   ex) block and file storage, built-in for object storage, databse encryption
    - Encryption in Transit
        - Protects data while transmitting
        - Includes encrypting before transmission
        - Authenticates endpoints
        - Decrypts data on arrival     ex) Secure Socket Layer(SSL), Transport Layer Security(TLS)
    - Encryption in Use
        - Protects data in use in memory
        - Allows computations to be performed on encrypted text without decryption
- Cloud storage encryption can be server-side or client-side
    - Server-side
        - Create and manage your own encryption keys, or
        - Generate and manage keys on Cloud
    - Client-side
        - Occurs before data is sent to cloud
        - Cloud providers cannot decrypt hosted data
- Multi-Cloud Data Encryption
    - Features: data access management, integrated key management, and sophisticated encryption
    - multi-cloud data encryption console manage access policies, create/manage keys, and aggregate access logs
- Key management
    - Encryption does not eliminate data security (it moves security from data itself to encryption keys)
    - Key management (by cloud service) enables customers to encrypt sensitive data at rest
    - It also easily create and manage the entire lifecycle of cryptographic keys
    - Protect data from cloud providers
- Best Practices for Key management
    - Storing encryption keys separately from the encrypted data
    - Taking key backups offsite and auditing them regularly
    - Refreshing the keys periodically
    - Implementing multi-factor authentication for both the master and recovery keys

## Cloud Monitoring

Cloud monitoring is not just about automated tools but includes strategies, practices and processes for analyzing, tracking and managing cloud-base services and apps.

- Cloud monitoring helps to
    - Accelerate the diagnosis and resolution of performance incidents
    - Control the cost of your monitoring infrastructure
    - Mitigate the impact of abnormal situations with proactive notifications
    - Get critical Kubernetes and container insights for dynamic microservice monitoring
    - Troubleshoot your apps and infra
- It provides
    - Data in real-time with round the clock monitoring of VMs, services, databases, apps
    - Multilayer visibility into application, user, and file access behavior across all apps
    - Advanced reporting and auditing capabilities for ensuring regulatory standards
    - Large-scale performance monitoring integrations across multicloud and hybrid cloud
- Cloud Monitoring Categories
    - Infrastructure
        - Identify minor and large-scale failures so that developers can take corrective action
    - Database
        - Help track processes, queries and availability of services to ensure accuracy and reliability
    - Application Performance Monitoring
        - Help improve user experience by minimizing downtime and lowering operational costs
        - Meet app and user SLAs
- Best Practices for Cloud Monitoring
    - Leverage end-user experience monitoring solutions
    - Move all aspects of infrastructure under one monitoring platform (helpful to manage all KPIs in one place with complete visibility into performance optimization)
    - Use monitoring tools that help track usage and cost
    - Increase cloud monitoring automation (help to gain operational efficiencies)

## Job Profile Examples for Cloud developers

![Untitled](Week%205%20-%20C%2002a62/Untitled%203.png)

## 연습테스트 오답정리

1. What are some of the benefits of using access groups? *Select two.*

내가 선택한 답

- Access groups define the users, the resources to which access is being granted, and the permission level that each user has on these resources
    
    → An access group defines the users and service IDs that are being grouped together. Access policies define the resources to which access is being granted, and the level of access that the group has permission for.
    
- The use of access groups helps to reduce the number of policies in an account

정답

- Access groups provide a more streamlined way to assign access rights to a group of users and service IDs as compared to assigning individual access
- The use of access groups helps to reduce the number of policies in an account

1. Identify the two main parts of an encryption system from the provided options. *Select two.*

내가 선택한 답

- Client-side encryption
- Server-side encryption
    
    → Ways in which cloud storage data can be encrypted
    

정답

- The decryption key
- The encryption algorithm