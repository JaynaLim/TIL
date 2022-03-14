# Week 3 - Cloud Infrastructure

Dates: 2022년 3월 14일 → 2022년 3월 21일
Type: 📒 Lesson

## Overview of Cloud Infrastructure

### Cloud Infrastructure

- consists of data centers, storage, networking components and compute resources
- customers need to plan the infrastructure architecture after choosing service model
- The infrastructure layer is the foundation of the cloud, consisted of physical resources that are housed in Regions(a geographic area where a cloud provider’s infrastructure is clustered)
- Zones are located in each Region and the isolation of zones improves the cloud’s overall fault tolerance (한 지역에 자연재해 등 이유로 cloud infra가 고장나도, 다른 지역의 Zone을 통해 안정적으로 운영될 수 있음)

### Computing Resources

- Virtual Servers
    - Software based server (use hypervisor to construct VMs)
- Bare Metal Servers
    - Physical servers that doesn’t use virtualization (no VMs)
- Serverless
    - Abstraction layer on the top of the Virtual machine

### Storage Options

- Block Storage
- File Storage

Block & File storage is normally used in  traditional data center

- Object Storage

Commonly used in Cloud today

### Networking

- Networking in cloud includes traditional networking hardware like routers and switches.
- Using Apis, it makes networking easier in provisioning, configuration and management.

### Virtualization

 Process of creating a software based, or virtual version of computing things (storage, networking, servers, application.. etc)

- Hypervisor
    - Makes virtualization feasible
    - A piece of software that runs above the physical server or host
    - Pull resources from the physical server and allocate them to virtual environments
    - We can run many VMs with different OS on a hypervisor
- Two types of hypervisor
    - Type 1 Hypervisor (=BareMetal Hypervisor)
        - Built directly on the top of the physical server
        - Most frequently used
        - Secure, lower the latency
        - Examples: VMware, ESXi, Microsoft Hyper-v, open-source KVM
    - Type2 (=Hosted)
        - Put a host os between the physical server and the hypervisor
        - Used for unusual virtualization
        - Higher latency, less frequent
        - Examples: Oracle, VirtualBox, VMware Workstation
- Benefits of virtualization
    - Cost saving (don’t need additional physical servers to use different VMs)
    - Agility and Speed (time saving than building entirely new environment)
    - Lower your downtime (move VMs quickly in that virtualization enables you to move VMs from one hypervisor to another)
    

### Types of Virtual Machines (depending on the cloud provider)

1. Shared or public Cloud VMs
    - Physical server is virtualized and multi-tenants share the server
    - The core sizes and configuration range is predefined to ease sharing between multi tenants (also storage and RAMs)
    - Priced by time
2. Transient or Spot VMs
    - Take advantage of unused capacity in cloud data center at low cost (the cloud center can retake the computing resources anytime)
    - Good for non-production workloads like testing and developing applications, running stateless workloads, testing scalability, running big data and high performance workloads at low cost
3. Reserved virtual server instances
    - Reserve capacity and guarantee resources for future deployments
    - lower or supplement capacities on monthly or weekly basis
4. Dedicated Hosts
    - Single tenant isolation (only your VM is run on the physical server)
    - Need to specify the data center and POD
    - Maximum control over workload placement
    - Used for meeting compliance and regulatory requirements or specific licensing term

### Bare Metal Server

- single-tenant, dedicated physical server
- The provider manages server up to the operating system(OS) → Anything about hardware or rack connection is the responsibility of the provider
- The customer is responsible for everything else on the server(administering & managing)
- Either preconfigured by the cloud provider or custom-configured per customer specification
- Processor, RAM, Hard Drives, Specialized component, OS can be configured and Customers can build their own OS or hypervisor even if the cloud provider doesn’t provide those OS/HV
- GPUs can be added
- Characteristics
    - Can take longer to provision (b.c it’s physical server) minutes to hours
    - More expensive than VMs
    - only offered by some cloud provider
    - Fully customizable / demanding environments
    - Dedicated or long-term usage, Highly secure
    - For High performance Computing
- Usages
    - Big data analytics, GPU-intensive solutions, ERP, CRM, AI, Virtualization, HPC
    - Suitable for applications which needs high security, typically run on on-premises environment
- Bare Metal Servers  VS Virtual Servers
    
    
    | Bare Metal Servers | Virtual Servers |
    | --- | --- |
    | Work best for CPU and I/O intensive workloads | Rapidly provisioned |
    | Excel with highest performance and security (Meet strict compliance requirements) | Provide an elastic & scalable environment |
    | Offer complete flexibility, control and transparency | Low cost to use |
    | Come with added management and operational overhead | Limited throughput and performance (b.c customers should share the server) |
    

### Secure Networking in Cloud

- Building a Cloud Network is important in that it enables creating a set of logical constructs that deliver networking functionality, securing enterprise IT environments, and ensuring high performing business application.
- Networking in Cloud vs On Premise

| Cloud Network | On Premise |
| --- | --- |
| Logical Instances
- vNICs
Delivered as a service not rack-mounted devices | Physical Devices
- NICs(Network Interface Controller) |
- Cloud는 networking space에 VPC(Virtual private Cloud)를 포함해 논리적으로 분리된 세그먼트를 둔다.
- VPC는 다시 subnet이라고 불리는 작은 세그먼트로 분리되는데, 이렇게 논리적으로 분할된 클라우트 네트워크는고객에게 안전성과 확장성을 제공한다. (subnet 안에 VSI나 Storage를 만듦)
- Subnet allows users to deploy enterprise applications using the same multi-tier concepts used in on-premises environments
- Every subnet is protected by ACLS(Access Control Lists), a subnet-level fire wall
- Also can create security group within the subnet so that instance level such as VSIs can be protected
- Load Balancers
    - 만약 subnet이 많이 확장되고, 사내의 다른 On premise 시스템이나, 인터넷 액세스를 위한 게이트웨이 인스턴스 등이 추가된다고 하면, 이렇게 많은 subnet 어플리케이션이 계속 상호반응하도록 만들어야 할 필요가 있다. 이것을 담당하는 것이 Load Balancer이다.

### Containers

- executable unit of software where application code is packaged along with libraries and dependencies
- It makes the code run anywhere
- small, fast, portable and unlike VMs, it do not need to include guest OS in every instance. it simply leverage the features and resources of the host OS
- Why container is efficient? (in the comparison with VM)
    
    Suppose you make a new application
    
    - VM case: On a hardware, you have Host OS and hypervisor to make VMs. Each VM needs a guest OS(the copy of host OS) even if the type of guest OS is same with that of host OS. When push the application it needs Linux OS, so the Virtual Machine needs guest OS + Linux OS and libraries for the application. If you want to scale out, you have to make more virtual machines that needs same resources with the first virtual machine. So the overall computing resources go high. → Not suitable for agile DevOps
    - Container case: (create docker file → build the image → push it to registry)
        
        first manifest the container (in docker world, you manifest channel) and then create the actual image itself(docker - docker image, Rocket - ACI) With container with application, set up a host OS. Instead of Hypervisor, container needs runtime engine. It doesn’t need guest OS even when you deploy out multiple containers
        

### Cloud Storage

- Some storage needs to be attached to a compute node before accessed while many can be accessed through internet
- Bill on per gigabyte basis
- Types of Cloud Storage
    - Direct Attached (Local Storage)
        - within same server or rack
        - Fast and mainly used for OS
        - Ephemeral(only lasts as long as the compute resource it’s attached to - cannot be shared with other nodes) → not resilient to failure
    - File Storage
        - compute nodes ‘NFS Storage’ (Network File System) - connected to compute nodes over a standard ethernet network (can be mounted to multiple nodes)
        - Disadvantages : Slower (이더넷을 타고 전달되기 때문에)
        - Low cost, Can attached to multiple servers
    - Block Storage
        - Advantages: Faster read/write
        
        ** Persistence : what happens to the storage once the compute node it is attached to is terminated
        
        ** Snapshot: a point in time image of the storage (fast to create, don’t require downtime, record only changes to data)
        
    - Object Storage (하나의 ~~SAN을 중심으로 연결되어있음)~~
        - Disadvantages: Slowest speed
        - Advantages: Least expensive, Infinite in size
        - Can be accessed using an API
        

• A Content Delivery Network (CDN) is a distributed server network that accelerates internet content delivery by delivering temporarily stored or cached copies of website or media content to users based on their geographic location.