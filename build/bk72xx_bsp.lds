MEMORY
{
 flash (rx) : ORIGIN = 0x00010000, LENGTH = 1912K
 itcm (rwx): ORIGIN = 0x003F0000, LENGTH = 16k
 ram (rw!x): ORIGIN = 0x00400100, LENGTH = 256k - 0x100
}
OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_vector_start);
_vector_start = ORIGIN(flash);
SECTIONS
{
 . = ORIGIN(flash);
 .vectors :
 {
  KEEP(*(*.vectors))
  KEEP( *(*.boot))
 } > flash
 .init_array :
 {
  PROVIDE_HIDDEN (__init_array_start = .);
  KEEP (*(SORT(.init_array.*)))
  KEEP (*(.init_array*))
  PROVIDE_HIDDEN (__init_array_end = .);
 } > flash
    . = ORIGIN(itcm);
    .itcm.code ALIGN(8) :
    {
        *(.text.intc_hdl_entry)
        *(.text.intc_irq)
        *(.text.intc_fiq)
        *(.text.bk_timer_isr)
        *(.text.power_save_wakeup_isr)
        *(.text.bmsg_rx_sender)
        *(.text.bmsg_null_sender)
        *(.text.fclk_get_tick)
        *(.text.flash_read_sr)
        *(.text.flash_write_sr)
        *(.text.flash_clr_qwfr)
        *(.text.set_flash_protect)
        *(.text.flash_read)
        *(.text.flash_read_data)
        *(.text.flash_set_qe)
        *(.text.flash_set_qwfr)
        *(.text.flash_set_line_mode*)
        *(.text.flash_get_line_mode)
        *(.text.flash_write)
        *(.text.flash_ctrl)
        *(.text.power_save_dtim_wake)
        *(.text.sctrl_fix_dpll_div)
        *(.text.flash_get_id)
        *(.text.enter_sleep)
        *(.text.vTaskSuspendAll)
        *(.text.xTaskGetTickCount)
        *(.text.xTaskGetTickCountFromISR)
        *(.text.vTaskStepTick)
        *(.text.xTaskIncrementTick)
        *(.text.xTaskResumeAll)
        *(.text.vTaskSwitchContext)
        *(.text.vApplicationIdleHook)
        *(.text.platform_is_in_irq_context)
        *(.text.platform_is_in_fiq_context)
        *(.text.platform_is_in_interrupt_context)
        *(.text.portENABLE_IRQ)
        *(.text.portENABLE_FIQ)
        *(.text.portDISABLE_FIQ)
        *(.text.portDISABLE_IRQ)
        *(.text.vPortEnterCritical)
        *(.text.vPortExitCritical)
        *(.text.flash_bypass_wr_sr_cb)
        *(.text.flash_bypass_op_write)
        *(.text.flash_bypass_op_read)
    } > itcm AT>flash
    _itcmcode_flash_begin = LOADADDR(.itcm.code);
    _itcmcode_ram_begin = ADDR(.itcm.code);
    _itcmcode_ram_end = _itcmcode_ram_begin + SIZEOF(.itcm.code);
    . = ALIGN(0x8);
 .text :
 {
     *(.text)
     *(.text.*)
     *(.stub)
     *(.gnu.warning)
     *(.gnu.linkonce.t*)
     *(.glue_7t) *(.glue_7)
 } > flash
 .rodata ALIGN(8) :
 {
  *(.rodata)
  *(.rodata.*)
  *(.gnu.linkonce.r*)
 } > flash
__exidx_start = .;
 .ARM.exidx :
 {
     *(.ARM.exidx*)
     *(.gnu.linkonce.armexidx.*)
 } > flash
__exidx_end = .;
 . = ORIGIN(ram);
 .stack ALIGN(8):
 {
  *boot_handlers.O(.bss .bss.* .scommon .sbss .dynbss COMMON)
 } > ram
 _begin_data = .;
 .data ALIGN(8):
 {
  *(.data .data.*)
  *(.sdata)
  *(.gnu.linkonce.d*)
  SORT(CONSTRUCTORS)
 } >ram AT>flash
 _end_data = .;
 _data_flash_begin = LOADADDR(.data);
 _data_ram_begin = ADDR(.data);
 _data_ram_end = .;
 .bss ALIGN(8):
 {
  _bss_start = .;
  *(.bss .bss.*)
  *(.scommon)
  *(.sbss)
  *(.dynbss)
  *(COMMON)
  . = ALIGN(32 / 8);
  _bss_end = .;
 } > ram
 . = ALIGN (8);
 _empty_ram = .;
 PROVIDE(end = .);
}
 GROUP(
   libgcc.a
   libg.a
   libc.a
   libm.a
   libnosys.a
 )
