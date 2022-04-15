#include <defs.h>
#include <riscv.h>
#include <stdio.h>
#include <string.h>
#include <swap.h>
#include <swap_clock.h>
#include <list.h>
#include <pmm.h>

#define boolean int
#define True 1
#define False 0


list_entry_t pra_list_head;
list_entry_t* curr_ptr;

// reference 1: https://blog.csdn.net/weixin_43995093/article/details/101688540
// reference 2: https://www.cnblogs.com/ECJTUACM-873284962/p/11282723.html
// reference 3: https://read01.com/ADJ80o.html#.YlgwcChBybg

static void throw_RE(){
     assert(False);
}

static int
_clock_init_mm(struct mm_struct *mm)
{     
     if(mm != NULL) {
     	 mm->sm_priv = NULL;
     }else {
         throw_RE();
     }
     
     return 0;
}

static int
_clock_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
    if(mm == NULL || page == NULL){
        throw_RE();
    }
    list_entry_t *head=mm->sm_priv;
    list_entry_t *entry=&(page->pra_page_link);
    if(entry == NULL){
    	throw_RE();
    }

    // Insert before pointer
    if (head == NULL) {
        list_init(entry);
        mm->sm_priv = entry;
    } else {
        list_add_before(head, entry);
    }
    return 0;
}

boolean isAccessed(struct mm_struct* mm){
	if(mm == NULL){
		throw_RE();
	}
	return *get_pte(mm->pgdir, le2page(curr_ptr, pra_page_link) -> pra_vaddr, 0) & PTE_A;
}

boolean isDirty(struct mm_struct* mm){
	if(mm == NULL){
		throw_RE();
	}
	return *get_pte(mm->pgdir, le2page(curr_ptr, pra_page_link) -> pra_vaddr, 0) & PTE_D;
}

void clearAccess(struct mm_struct* mm){
	if(mm == NULL){
		throw_RE();
	}
	struct Page* page = le2page(curr_ptr, pra_page_link);
	pte_t* ptep = get_pte(mm-> pgdir, page-> pra_vaddr, 0);
	*ptep &= ~PTE_A;
	tlb_invalidate(mm->pgdir, page->pra_vaddr);

}

static list_entry_t* first_fit_noClearAccess(struct mm_struct* mm, list_entry_t* head, int expectedAccessed, int expectedDirty){
	list_entry_t* result = NULL;
	do{
	     if(expectedDirty){
	     	if(isAccessed(mm) == expectedAccessed && isDirty(mm)){
	     		result = curr_ptr;
	     		break;
	     	}
	     }else {
	     	if(isAccessed(mm) == expectedAccessed && isDirty(mm) == 0){
	     		result = curr_ptr;
	     		break;
	     	}
	     
	     }
	     curr_ptr = list_next(curr_ptr);
	     if(curr_ptr == head){
	     	break;
	     }
	
	}while(True);
	
	return result;
	
}

static list_entry_t* first_fit_clearAccess(struct mm_struct* mm, list_entry_t* head, int expectedAccessed, int expectedDirty){
	list_entry_t* result = NULL;
	do{
	     if(expectedDirty){
	     	if(isAccessed(mm) == expectedAccessed && isDirty(mm)){
	     		result = curr_ptr;
	     		break;
	     	}
	     }else {
	     	if(isAccessed(mm) == expectedAccessed && isDirty(mm) == 0){
	     		result = curr_ptr;
	     		break;
	     	}
	     
	     }
	     clearAccess(mm);
	     curr_ptr = list_next(curr_ptr);
	     if(curr_ptr == head){
	     	break;
	     }
	
	}while(True);
	
	return result;
	
}

static list_entry_t* search_00_01_00_01(struct mm_struct* mm, list_entry_t* head){
     
     if(mm ==NULL || head == NULL) {
     	throw_RE();
     }

     list_entry_t* selected = NULL;
     curr_ptr = head;
     selected = first_fit_noClearAccess(mm, head, 0, 0);
     
     if (selected == NULL){
     	selected = first_fit_clearAccess(mm, head, 0, 1);
     }
     if (selected == NULL){
        selected = first_fit_noClearAccess(mm, head, 0, 0);
     }

     if (selected == NULL){
        selected = first_fit_noClearAccess(mm, head, 0, 1);
     }
     return selected;
}

static int
_clock_swap_out_victim(struct mm_struct* mm, struct Page ** ptr_page, int in_tick)
{
     if(mm == NULL || ptr_page == NULL){
     	throw_RE();
     }
     list_entry_t* head=(list_entry_t*) mm->sm_priv;
     
     if(head == NULL || in_tick != 0){
     	throw_RE();
     }
       
     // Remove pointed element
     head = search_00_01_00_01(mm, head);
     if (list_empty(head)) {
        mm->sm_priv = NULL;
     } else {
         mm->sm_priv = list_next(head);
        list_del(head);
     }
     *ptr_page = le2page(head, pra_page_link);
     return 0;
}


static int
_clock_check_swap(void) {

    cprintf("---------Clock check begin----------\n");
    cprintf("write Virt Page c in clock_check_swap\n");
    *(unsigned char *)0x3000 = 0x0c;
    assert(pgfault_num==4);
    cprintf("write Virt Page a in clock_check_swap\n");
    *(unsigned char *)0x1000 = 0x0a;
    assert(pgfault_num==4);
    cprintf("write Virt Page d in clock_check_swap\n");
    *(unsigned char *)0x4000 = 0x0d;
    assert(pgfault_num==4);
    cprintf("write Virt Page b in clock_check_swap\n");
    *(unsigned char *)0x2000 = 0x0b;  
    assert(pgfault_num==4);
    cprintf("write Virt Page e in clock_check_swap\n");
    *(unsigned char *)0x5000 = 0x0e;
    assert(pgfault_num==5);
    cprintf("write Virt Page b in clock_check_swap\n");
    *(unsigned char *)0x2000 = 0x0b;
    assert(pgfault_num==5);
    cprintf("write Virt Page a in clock_check_swap\n");
    *(unsigned char *)0x1000 = 0x0a;
    assert(pgfault_num==6);
    cprintf("write Virt Page b in clock_check_swap\n");
    *(unsigned char *)0x2000 = 0x0b;
    assert(pgfault_num==6);
    cprintf("write Virt Page c in clock_check_swap\n");
    *(unsigned char *)0x3000 = 0x0c;
    assert(pgfault_num==7);
    cprintf("write Virt Page d in clock_check_swap\n");
    *(unsigned char *)0x4000 = 0x0d;
    assert(pgfault_num==8);
    cprintf("write Virt Page e in clock_check_swap\n");
    *(unsigned char *)0x5000 = 0x0e;
    assert(pgfault_num==9);
    cprintf("write Virt Page a in clock_check_swap\n");
    assert(*(unsigned char *)0x1000 == 0x0a);
    *(unsigned char *)0x1000 = 0x0a;
    assert(pgfault_num==9);
    cprintf("Clock check succeed!\n");

    return 0;
}


static int
_clock_init(void)
{
    return 0;
};

static int
_clock_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}

static int
_clock_tick_event(struct mm_struct *mm)
{ return 0; }


struct swap_manager swap_manager_clock =
{
     .name            = "clock swap manager",
     .init            = &_clock_init,
     .init_mm         = &_clock_init_mm,
     .tick_event      = &_clock_tick_event,
     .map_swappable   = &_clock_map_swappable,
     .set_unswappable = &_clock_set_unswappable,
     .swap_out_victim = &_clock_swap_out_victim,
     .check_swap      = &_clock_check_swap,
};
