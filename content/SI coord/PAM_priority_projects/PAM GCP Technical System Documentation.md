**PAM GCP Technical System Documentation**

*Overview: Summary of key decisions, technical system set-up, and use expectations for using software applications in the PAM GCP. This document is an initial way to collaborate on developing the documentation and will be transitioned to the National PAM Network GitHub once folks have access.* 

**The acoustics SI and project design philosophy:**  
The ggn-nmfs-pamdata-prod-1 (“pamdata”) GCP project is designed to encompass the requirements of the PAM SI, while best prioritizing the wants and needs of the end-users and use cases, and staying near best admin practices for NMFS OCIO GCP. The relevant objectives of the PAM acoustics SI include acoustic data storage across NMFS, and passive acoustic monitoring applications that generally feed from this data. The primary end-users of the system include data owners and users, and application owners, developers, and users. 

**Permissions structure:**  
A principle and role based structure was designed for project capabilities. By defining specific [principle groups](https://source.cloud.google.com/ggn-nmfs-pamdata-prod-1/tf-repo-pamdata/+/master:principles.tf) (project supervisor, application developer, etc) the project is resilient to changes in individual users. [Roles](https://source.cloud.google.com/ggn-nmfs-pamdata-prod-1/tf-repo-pamdata/+/master:roles.tf) are given to these principle groups- for example, the project supervisors principle group is given viewing roles for most of the resources in the project for their visibility.  

For quick configuration and transparency during the dynamic early stages of the project, principle and role definitions are managed by a central “project admin” principle group via terraform. NMFS OCIO best practice recommends [Terraform](https://docs.google.com/document/d/1SPbbIz2hN4Gh236C7uAwGjzk-2AnpTPECJLsHB1RMPM/edit#heading=h.urcjjnawq27j) for more transparent project resource configuration and management, and this allows for simplicity and transparency. 

Alternatives: In the future, we may wish to delegate assignment of users to principle groups in a way that better resembles the true acoustics SI responsible parties (ie, supervisors can assign the project admin(s), data authorities can designate their respective data admin(s), etc). In the short term, this may result in too much unpredictability to the dynamic project. 

Below are some of the currently defined principles for the project: 

| Principle group name | Definition and roles |
| :---- | :---- |
| Project admin | Highest GCP admin role, controls project terraform (all principle, role, resource definitions) |
| Project supervisors | Highest SI role, has visibility across project resources, tells project admin what to do |
| Data authority | Responsible party for a particular FMC data storage bucket |
| Data admin | Administrates the contents (write/delete) of a particular storage bucket |
| Application developer | Access to software development resources |

**Resources:**

The pamdata project is expected to house PAM data from across NMFS, application development resources, and various applications (\<30) in various states of development. Sprawl is a serious threat, in particular since many end-users of the system (owners/authorities, supervisors, users) tend to understand the system through use of a web browser as opposed to filterable api calls. In other words, resource sprawl will lead to reduced understandability of the project across the PAM SI end users and is thus carefully considered. 

**Data resources:** 

Each FMC has a distinct storage bucket for their data. This allows for some flexibility in data naming and easier isolation of permissions between FMCs. Principle groups that are designated here are data authorities (the data owner or responsible party, usually the PI of an FMC acoustics group), and the data admins (the technical users responsible for maintaining the contents of the storage bucket).

The browser allows for [easy viewing of the storage buckets](https://console.cloud.google.com/storage/browser?project=ggn-nmfs-pamdata-prod-1) such that non-technical users can easily interpret the current state of the data across the NMFS FMCs. However, the tool cannot distinguish the FMC buckets from application buckets, and in order to maintain easy interpretability applications will be encouraged to consolidate to fewer buckets as appropriate. Currently, three additional buckets outside of the FMC data buckets exist: the terraform state bucket, an application intermediate bucket, and an application output bucket.  

**Development resources:** 

The following resources have been stood up for application development: 

Hardened docker image/server: Based on NMFS hardened linux container and preloaded with docker. I developed an imagining pipeline for this, meaning it will be easy to keep up to date and we can make as many copies of this as developers need them. Developing on this instead of locally will be a little closer to cloud and streamlines and simplifies some assumptions. Please make sure any developers working on containers understand this option exists and the advantages in doing development here (hardware flexibility, more similar to production, built in permissions w/o key management, etc). 

Docker registry: This is where container images will be placed (whether we build or import them), and it is a key backbone of a variety of GCP container orchestration services. 

Application storage buckets: There are two new storage buckets, pamdata-app-intermediates and pamdata-app-outputs. Some of the time applications will need their own specific tiering and lifecycle, but I wanted to start with just these two, especially for early development, given that they are visible along with the FMC data buckets and we tend to like to use the console as a browsing tool to keep track of these. Keeping it to two, and dividing permissions by prefix, will keep the bucket display from getting too muddied. 

Networking: Created networks and subnets \- one for application and development machines, which require ssh and NAT internet connectivity, and one for batch processing, which relies on only private google connectivity by default, but other connectivity can be added as a particular app might need. 

