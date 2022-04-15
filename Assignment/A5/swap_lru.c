#include <defs.h>
#include <riscv.h>
#include <stdio.h>
#include <string.h>
#include <swap.h>
#include <swap_lru.h>
#include <list.h>
#include <pmm.h>

#define boolean int
#define True 1
#define False 0

list_entry_t pra_list_head;
list_entry_t* curr_ptr;

static void throw_RE(){
     assert(False);
}


static int
_lru_init_mm(struct mm_struct *mm)
{     
    //TODO
     list_init(&pra_list_head);
     mm->sm_priv = &pra_list_head;
     //cprintf(" mm->sm_priv %x in fifo_init_mm\n",mm->sm_priv);
     return 0;
}

static int
_lru_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
    //TODO
    list_entry_t *head=(list_entry_t*) mm->sm_priv;
    list_entry_t *entry=&(page->pra_page_link);
 
    assert(entry != NULL && head != NULL);
    //record the page access situlation

    //(1)link the most recent arrival page at the back of the pra_list_head qeueue.
    list_add(head, entry);
    return 0;
}


static int
_lru_swap_out_victim(struct mm_struct *mm, struct Page ** ptr_page, int in_tick)
{
    //TODO
    if(mm == NULL || ptr_page == NULL){
    	throw_RE();
    }
    
    if(in_tick != 0){
    	throw_RE();
    }
    
    list_entry_t* head=(list_entry_t*) mm->sm_priv;
    list_entry_t* current = list_prev(head);
    list_entry_t* vic = NULL;
    struct Page* result = NULL;
    int minimum = 1919810114;
    
    while(current != head){
    	struct Page* tmp_page = le2page(current, pra_page_link);
    	int temp = *(unsigned char*) tmp_page->pra_vaddr;
    	if(temp < minimum){
    		minimum = temp;
    		result = tmp_page;
    		vic = current;
    	}
    	
    	current = list_prev(current);
    }
    
    if(vic != NULL){
    	
    	*ptr_page = le2page(vic, pra_page_link);
    	list_del(&result->pra_page_link);
    }else {
    	*ptr_page = le2page(head, pra_page_link);
    }
    cprintf("Here!\n");
    return 0;
}




static int
_lru_check_swap(void) {

    int i = 0x10;
    
    cprintf("---------LRU check begin----------\n");
    cprintf("write Virt Page 3 in lru_check_swap\n");
    *(unsigned char *)0x3000 = i;i+=1;
    assert(pgfault_num==4);
    cprintf("write Virt Page 1 in lru_check_swap\n");
    *(unsigned char *)0x1000 =  i;i+=1;
    assert(pgfault_num==4);
    cprintf("write Virt Page 4 in lru_check_swap\n");
    *(unsigned char *)0x4000 =  i;i+=1;
    assert(pgfault_num==4);
    cprintf("write Virt Page 2 in lru_check_swap\n");
    *(unsigned char *)0x2000 =  i;i+=1;
    assert(pgfault_num==4);
    cprintf("write Virt Page 5 in lru_check_swap\n");
    *(unsigned char *)0x5000 =  i;i+=1;
    assert(pgfault_num==5);
    cprintf("write Virt Page 3 in lru_check_swap\n");
    *(unsigned char *)0x3000 =  i;i+=1;
    assert(pgfault_num==6);
    cprintf("write Virt Page 1 in lru_check_swap\n");
    *(unsigned char *)0x1000 =  i;i+=1;
    assert(pgfault_num==7);
    cprintf("write Virt Page 4 in lru_check_swap\n");
    *(unsigned char *)0x4000 =  i;i+=1;
    assert(pgfault_num==8);
    cprintf("write Virt Page 4 in lru_check_swap\n");
    *(unsigned char *)0x4000 =  i;i+=1;
    assert(pgfault_num==8);
    cprintf("write Virt Page 5 in lru_check_swap\n");
    *(unsigned char *)0x5000 =  i;i+=1;
    assert(pgfault_num==8);
    cprintf("write Virt Page 2 in lru_check_swap\n");
    *(unsigned char *)0x2000 =  i;i+=1;
    assert(pgfault_num==9);
    cprintf("write Virt Page 3 in lru_check_swap\n");
    *(unsigned char *)0x3000 =  i;i+=1;
    assert(pgfault_num==10);
    cprintf("LRU check succeed!\n");

    return 0;
}


static int
_lru_init(void)
{
    return 0;
}

static int
_lru_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}

static int
_lru_tick_event(struct mm_struct *mm)
{ return 0; }


struct swap_manager swap_manager_lru =
{
     .name            = "lru swap manager",
     .init            = &_lru_init,
     .init_mm         = &_lru_init_mm,
     .tick_event      = &_lru_tick_event,
     .map_swappable   = &_lru_map_swappable,
     .set_unswappable = &_lru_set_unswappable,
     .swap_out_victim = &_lru_swap_out_victim,
     .check_swap      = &_lru_check_swap,
};

