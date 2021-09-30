/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/CSM152A/Lab_1/FPCVT.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {4096U, 0U};
static unsigned int ng3[] = {1U, 0U};
static unsigned int ng4[] = {4095U, 0U};



static void Always_38_0(char *t0)
{
    char t6[8];
    char t15[8];
    char t39[8];
    char t48[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t16;
    char *t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    char *t38;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    char *t49;

LAB0:    t1 = (t0 + 2520U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 2840);
    *((int *)t2) = 1;
    t3 = (t0 + 2552);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(38, ng0);

LAB5:    xsi_set_current_line(40, ng0);
    t4 = (t0 + 1048U);
    t5 = *((char **)t4);
    memset(t6, 0, 8);
    t4 = (t6 + 4);
    t7 = (t5 + 4);
    t8 = *((unsigned int *)t5);
    t9 = (t8 >> 12);
    t10 = (t9 & 1);
    *((unsigned int *)t6) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 12);
    t13 = (t12 & 1);
    *((unsigned int *)t4) = t13;
    t14 = ((char*)((ng1)));
    memset(t15, 0, 8);
    t16 = (t6 + 4);
    t17 = (t14 + 4);
    t18 = *((unsigned int *)t6);
    t19 = *((unsigned int *)t14);
    t20 = (t18 ^ t19);
    t21 = *((unsigned int *)t16);
    t22 = *((unsigned int *)t17);
    t23 = (t21 ^ t22);
    t24 = (t20 | t23);
    t25 = *((unsigned int *)t16);
    t26 = *((unsigned int *)t17);
    t27 = (t25 | t26);
    t28 = (~(t27));
    t29 = (t24 & t28);
    if (t29 != 0)
        goto LAB9;

LAB6:    if (t27 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t15) = 1;

LAB9:    t31 = (t15 + 4);
    t32 = *((unsigned int *)t31);
    t33 = (~(t32));
    t34 = *((unsigned int *)t15);
    t35 = (t34 & t33);
    t36 = (t35 != 0);
    if (t36 > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(46, ng0);

LAB14:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t6 + 4);
    t4 = (t3 + 4);
    t8 = *((unsigned int *)t3);
    t9 = (t8 >> 0);
    *((unsigned int *)t6) = t9;
    t10 = *((unsigned int *)t4);
    t11 = (t10 >> 0);
    *((unsigned int *)t2) = t11;
    t12 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t12 & 8191U);
    t13 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t13 & 8191U);
    t5 = ((char*)((ng2)));
    memset(t15, 0, 8);
    t7 = (t6 + 4);
    t14 = (t5 + 4);
    t18 = *((unsigned int *)t6);
    t19 = *((unsigned int *)t5);
    t20 = (t18 ^ t19);
    t21 = *((unsigned int *)t7);
    t22 = *((unsigned int *)t14);
    t23 = (t21 ^ t22);
    t24 = (t20 | t23);
    t25 = *((unsigned int *)t7);
    t26 = *((unsigned int *)t14);
    t27 = (t25 | t26);
    t28 = (~(t27));
    t29 = (t24 & t28);
    if (t29 != 0)
        goto LAB16;

LAB15:    if (t27 != 0)
        goto LAB17;

LAB18:    t17 = (t15 + 4);
    t32 = *((unsigned int *)t17);
    t33 = (~(t32));
    t34 = *((unsigned int *)t15);
    t35 = (t34 & t33);
    t36 = (t35 != 0);
    if (t36 > 0)
        goto LAB19;

LAB20:    xsi_set_current_line(54, ng0);

LAB25:    xsi_set_current_line(56, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 1448);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 13);

LAB21:
LAB12:    xsi_set_current_line(60, ng0);
    t2 = (t0 + 1048U);
    t3 = *((char **)t2);
    memset(t6, 0, 8);
    t2 = (t6 + 4);
    t4 = (t3 + 4);
    t8 = *((unsigned int *)t3);
    t9 = (t8 >> 12);
    t10 = (t9 & 1);
    *((unsigned int *)t6) = t10;
    t11 = *((unsigned int *)t4);
    t12 = (t11 >> 12);
    t13 = (t12 & 1);
    *((unsigned int *)t2) = t13;
    t5 = (t0 + 1608);
    xsi_vlogvar_assign_value(t5, t6, 0, 0, 1);
    goto LAB2;

LAB8:    t30 = (t15 + 4);
    *((unsigned int *)t15) = 1;
    *((unsigned int *)t30) = 1;
    goto LAB9;

LAB10:    xsi_set_current_line(41, ng0);

LAB13:    xsi_set_current_line(42, ng0);
    t37 = (t0 + 1048U);
    t38 = *((char **)t37);
    t37 = (t0 + 1448);
    xsi_vlogvar_assign_value(t37, t38, 0, 0, 13);
    goto LAB12;

LAB16:    *((unsigned int *)t15) = 1;
    goto LAB18;

LAB17:    t16 = (t15 + 4);
    *((unsigned int *)t15) = 1;
    *((unsigned int *)t16) = 1;
    goto LAB18;

LAB19:    xsi_set_current_line(49, ng0);

LAB22:    xsi_set_current_line(51, ng0);
    t30 = (t0 + 1048U);
    t31 = *((char **)t30);
    memset(t39, 0, 8);
    t30 = (t39 + 4);
    t37 = (t31 + 4);
    t40 = *((unsigned int *)t31);
    t41 = (~(t40));
    *((unsigned int *)t39) = t41;
    *((unsigned int *)t30) = 0;
    if (*((unsigned int *)t37) != 0)
        goto LAB24;

LAB23:    t46 = *((unsigned int *)t39);
    *((unsigned int *)t39) = (t46 & 8191U);
    t47 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t47 & 8191U);
    t38 = ((char*)((ng3)));
    memset(t48, 0, 8);
    xsi_vlog_unsigned_add(t48, 13, t39, 13, t38, 13);
    t49 = (t0 + 1448);
    xsi_vlogvar_assign_value(t49, t48, 0, 0, 13);
    goto LAB21;

LAB24:    t42 = *((unsigned int *)t39);
    t43 = *((unsigned int *)t37);
    *((unsigned int *)t39) = (t42 | t43);
    t44 = *((unsigned int *)t30);
    t45 = *((unsigned int *)t37);
    *((unsigned int *)t30) = (t44 | t45);
    goto LAB23;

}


extern void work_m_11555584136852741723_3775486895_init()
{
	static char *pe[] = {(void *)Always_38_0};
	xsi_register_didat("work_m_11555584136852741723_3775486895", "isim/myTestBench_isim_beh.exe.sim/work/m_11555584136852741723_3775486895.didat");
	xsi_register_executes(pe);
}
