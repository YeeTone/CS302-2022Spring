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
Hardware-assisted virtualization is a native implementation of virtualization.
Hardware provides structure to support the virtual machine to allow and watch the user OS to run independently.

Moreover, there are several platform supporting this technique, such as AMD-V and Intel VT-x in x86, VT-d in IOMMU etc.
#### Hybrid virtualization
Hybrid virtualization is becoming prevailing amont the users.
It can combine several kinds of virtualization technique and gather their benefits.

It has several advantages among the previous virtualization: 
1. It can reduce the expense for changing codes in users' applications;
2. It does not spend too much time on the shutdown of operating system;
3. It could be more cheap and cost less money by the developers;
4. It can support several resource access when the resource is required;

Thus it is becoming popular among several companies and actual development environment.

## 2. Privilege levels
### 2.1 Privilege
There are 4 privilege levels, whose level number means: the lower level number, the higher the privilege levels.

1. Level 0: OS Kernel
2. Level 1: OS Services
3. Level 2: OS Services
4. Level 3: User Applications

Three examples:
TODO!

### 2.2 Ring compression
As described previously, there are 4 levels in the privilege rings.
In order to protect VMM which is from user software, IA-32 uses 2 mechanisms named segment limits and paging.

However, IA-32 cannot differentiate the privilege leve of 0-2.
Thus the guest operating system can only be executed on level 3 and cannot get protection.
This is called ring compression.

### 2.3 Ring compression for X86 (IA-32)

TODO!

### 2.4 Ring compression for x86-64

TODO!

### 2.5 Ring aliasing
This appears when a software is executed under the privilege level. But the software is not written in this privilege level.

### 2.6 VMX root and VMX non-root in VT-x
VMX root: the codes are executed between the instructions `vm-exit` and `VMRESUME`.

VMX non-root: the codes are executed in the normal kernel mode.

### 2.7 Address the challenge
Some commands can be executed by the virtual machine normal, thus it is not required to simulate the privileged commands.
VMMs are allowed to execute the user software in its prefered privilege level. VMMs are able to be freed from the priviledged simulation commands.

## 3. System calls, interrupts and exceptions
### 3.1 Purpose & Difference
Purpose of system call: request for the system service provided by the hardware. OS banned the user to use hardware resource directly, thus the user can only use the interfaces provided by the operating system to access the resource.

Difference: 
- System call: user program request the operating system to get the support by the hearware resource.
- Function call: just a program request another one to complete the specific funtion.

### 3.2 Hypercall in Xen
Hypercall is a synchronous procedure that domain uses to do some operations needing privleges such as updating the pagetables.

### 3.3 Xen & exceptions

TODO!

### 3.4 Challenges of virtualizing interrupts

TODO!

### 3.5 Xen & interrupts

TODO!

### 3.6 VMCS
#### VMCS
VMCS can manage the entries and exits of VMs, and the behaviour of processor in the operations of VMX non-root.
VMCS can implement the virtualization of CPUR in Intel x86 and record the vCPU status.

#### VM exit & VM entry
- VM exit: the transition from current running VM to VMM, since VMM must gain the system control for some reasons. This operation lets CPU change into VMX Root status.
- VM entry: the transition from VMM to current running VM. This operation lets CPU change into VMX non-Root status.

### 3.7 Virtualize interrupts by Xen and Intel VT-x

TODO!

### 3.8  Intel VT-x support for exception virtualization

TODO!

## 4. Address translation

### 4.1 x86 (IA-32) address translation

### 4.2 x86-64 address translation

### 4.3 Memory relation

### 4.4 Xen management

### 4.5 Address-space compression

### 4.6 Xen solution to 4.5

### 4.7 Intel EPT

### 4.8 Xen allocation
