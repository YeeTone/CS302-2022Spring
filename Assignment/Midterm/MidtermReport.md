# Midterm Report
Name：Yitong WANG(王奕童) 11910104@mail.sustech.edu.cn

SID：11910104

Lab：Friday5-6节

Lab Teacher：Yun SHEN(沈昀) sheny@mail.sustech.edu.cn

Lab SA:
- Yining TANG(汤怡宁) 11811237@mail.sustech.edu.cn
- Yushan WANG(王宇杉) 11813002@mail.sustech.edu.cn

## 1. Terminologies of virtualization
### 1.1 Virtualization definition
Virtualization is used to split the hardware resource of computers so that difference programs can have an isolated running environment and be executed at the same time. 
Virtualization allows the software to use the memory abstraction so that it does not to operate on the hardware directly. 
Moreover, with virtualization, users can run different programs and applications on the same machine.

### 1.2 Three usage models of virtualization
#### Workload isolation
This means in order to tolerate the system fault, the virtualization application first copies an identical version of itself, then runs them in two different VMs with the same workload. Thus the system security could be improved.

#### Workload consolidation
Work consolidation allows the companies to execute several different programs which requires to be run certain operating systems on several hardware platforms previously, on only one hardware platform. Work consolidation applied virtualization so that the several kinds of operating systems(older and newer version) at one machine at the same time.

#### Workload migration
This concept means the operation that moves one running workload from one architecture environment to another.
Saving the application running status in a virtual machine will be a nice choice since it will not depend on the hardware support.
Moreover, the work balancing and failure prediction could improve the stability of migration process.
