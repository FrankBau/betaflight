F405_TARGETS    += $(TARGET)

FEATURES       += VCP ONBOARDFLASH

FLASH_SIZE  = 256

# FEATURE_CUT_LEVEL = 9

# XXX Remove fake drivers for final production
TARGET_SRC = \
            drivers/accgyro/accgyro_fake.c \
            drivers/barometer/barometer_lps.c \
            drivers/compass/compass_lis3mdl.c \
