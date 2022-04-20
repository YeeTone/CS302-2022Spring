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

The best-suited workload for migration:
- capacity varies a lot
- data storage and protection
- micro-service application with several layers
- need to be expanded by the requirement

### 1.3 Three well-known VMMs
XenoLinux(X), VMware workstation 3.2(V) and User-Mode Linux(U)

### 1.4 Five concepts
#### Paravirtualization
Paravirtualization is a kind of hardware virtualization implementation technique.
Paravirtualization uses VMMs to communicate with the local hardware.
It accelerates the program, and does not need to re-compile or cause system fault, or make any changes to the users' applications.
Therefore it needs to have some modification to the users' operating system to fit the corresponding hardware interfaces.
But it cannot support all operating systems. For instance, Xen cannot run on the Windows 10 platform.

#### Full virtualization
In the full virtualization is another kind of hardware virtualization implementation technique.
This technique uses virtual machine to handle the cooperation between OS and local hardware.
Full virtualization can be faster than the hardware simulation, but slower than the original machine.
And full virtualization does not need to make change to the users' OS.
It can also support several OSes, which needs to support the local hardware.

#### Binary translation
This is used to translate the original binary code to simulate another instruction set. It can be implemented by hardware or software.
It could be used in the translation of VMMs so that VMMs can support a wider range of target opearting systems.

#### Hardware-assisted virtualization
#### Hybrid virtualization
