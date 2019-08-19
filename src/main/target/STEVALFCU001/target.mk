F411_TARGETS    += $(TARGET)

FLASH_SIZE = 256

FEATURES        += VCP 

TARGET_SRC = \
            drivers/accgyro/accgyro_spi_l3gd20.c \
            drivers/accgyro_legacy/accgyro_lsm303dlhc.c \
            drivers/compass/compass_hmc5883l.c 

