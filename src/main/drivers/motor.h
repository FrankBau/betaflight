/*
 * This file is part of Cleanflight and Betaflight.
 *
 * Cleanflight and Betaflight are free software. You can redistribute
 * this software and/or modify this software under the terms of the
 * GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option)
 * any later version.
 *
 * Cleanflight and Betaflight are distributed in the hope that they
 * will be useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software.
 *
 * If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: jflyper
 */

#pragma once

typedef enum {
    PWM_TYPE_STANDARD = 0,
    PWM_TYPE_ONESHOT125,
    PWM_TYPE_ONESHOT42,
    PWM_TYPE_MULTISHOT,
    PWM_TYPE_BRUSHED,
#ifdef USE_DSHOT
    PWM_TYPE_DSHOT150,
    PWM_TYPE_DSHOT300,
    PWM_TYPE_DSHOT600,
    PWM_TYPE_DSHOT1200,
    PWM_TYPE_PROSHOT1000,
#endif
    PWM_TYPE_MAX
} motorPwmProtocolTypes_e;


typedef struct motorVTable_s {
    // Common
    float (*convertExternalToMotor)(uint16_t externalValue);
    uint16_t (*convertMotorToExternal)(float motorValue);
    bool (*enable)(void);
    void (*disable)(void);
    bool (*isMotorEnabled)(uint8_t index);
    bool (*updateStart)(void);
    void (*write)(uint8_t index, float value);
    void (*writeInt)(uint8_t index, uint16_t value);
    void (*updateComplete)(void);
    void (*shutdown)(void);

    // Digital commands

} motorVTable_t;

typedef struct motorDevice_s {
    motorVTable_t vTable;
    uint8_t       count;
    bool          initialized;
    bool          enabled;
} motorDevice_t;

void motorWriteNull(uint8_t index, float value);
bool motorUpdateStartNull(void);
void motorUpdateCompleteNull(void);

void motorWriteAll(float *values);

void motorInitEndpoints(float outputLimit, float *outputLow, float *outputHigh, float *disarm, float *deadbandMotor3DHigh, float *deadbandMotor3DLow);

float motorConvertFromExternal(uint16_t externalValue);
uint16_t motorConvertToExternal(float motorValue);

struct motorDevConfig_s; // XXX Shouldn't be needed once pwm_output* is really cleaned up.
void motorDevInit(const struct motorDevConfig_s *motorConfig, uint16_t idlePulse, uint8_t motorCount);
bool isMotorProtocolDshot(void);

void motorDisable(void);
void motorEnable(void);
bool motorIsEnabled(void);
bool motorIsMotorEnabled(uint8_t index);
void motorShutdown(void); // Replaces stopPwmAllMotors
