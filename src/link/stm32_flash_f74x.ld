/*
*****************************************************************************
**
**  File        : stm32_flash_f74x.ld
**
**  Abstract    : Linker script for STM32F74xVGTx Device with
**                1024KByte FLASH, 320KByte RAM
**
*****************************************************************************
*/

/*
0x00000000 to 0x00003FFF   16K TCM RAM,

0x08000000 to 0x080FFFFF 1024K full flash,
0x08000000 to 0x08007FFF   32K isr vector, startup code,
0x08008000 to 0x0800FFFF   32K config,                  // FLASH_Sector_1
0x08010000 to 0x080FFFFF  960K firmware,
*/

/* Specify the memory areas */
MEMORY
{
    ITCM_RAM (rx)			: ORIGIN = 0x00000000, LENGTH = 16K

    ITCM_FLASH (rx)        	: ORIGIN = 0x00200000, LENGTH = 32K
    /* config occupies the entire flash sector 1 for the ease of erasure, 32K on F74x */
    ITCM_FLASH_CONFIG (r)  	: ORIGIN = 0x00208000, LENGTH = 32K
    ITCM_FLASH1 (rx)       	: ORIGIN = 0x00210000, LENGTH = 960K

    AXIM_FLASH (rx)        	: ORIGIN = 0x08000000, LENGTH = 10K
    AXIM_FLASH_CUSTOM_DEFAULTS (r) : ORIGIN = 0x08002800, LENGTH = 22K
    AXIM_FLASH_CONFIG (r)  	: ORIGIN = 0x08008000, LENGTH = 32K
    AXIM_FLASH1 (rx)       	: ORIGIN = 0x08010000, LENGTH = DEFINED(USE_CUSTOM_DEFAULTS) ? 928K : 960K
    AXIM_FLASH_CUSTOM_DEFAULTS_EXTENDED (r)	: ORIGIN = DEFINED(USE_CUSTOM_DEFAULTS_EXTENDED) ? 0x080F8000 : 0x08100000, LENGTH = DEFINED(USE_CUSTOM_DEFAULTS_EXTENDED) ? 32K : 0K

    DTCM_RAM (rwx)         	: ORIGIN = 0x20000000, LENGTH = 64K
    SRAM1 (rwx)         	: ORIGIN = 0x20010000, LENGTH = 240K
    SRAM2 (rwx)         	: ORIGIN = 0x2004C000, LENGTH = 16K
    MEMORY_B1 (rx)    		: ORIGIN = 0x60000000, LENGTH = 0K
}

REGION_ALIAS("FLASH", ITCM_FLASH)
REGION_ALIAS("FLASH_CUSTOM_DEFAULTS", AXIM_FLASH_CUSTOM_DEFAULTS)
REGION_ALIAS("FLASH_CONFIG", AXIM_FLASH_CONFIG)
REGION_ALIAS("FLASH1", ITCM_FLASH1)
REGION_ALIAS("FLASH_CUSTOM_DEFAULTS_EXTENDED", AXIM_FLASH_CUSTOM_DEFAULTS_EXTENDED)

REGION_ALIAS("STACKRAM", DTCM_RAM)
REGION_ALIAS("FASTRAM", DTCM_RAM)
REGION_ALIAS("RAM", SRAM1)

INCLUDE "stm32_flash_f7_split.ld"
