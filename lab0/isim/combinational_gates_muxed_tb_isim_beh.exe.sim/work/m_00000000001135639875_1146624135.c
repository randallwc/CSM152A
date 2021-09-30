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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/152/Downloads/src/combinational_gates/combinational_gates_muxed_TB.v";
static const char *ng1 = "combinational_gates_muxed.vcd";
static int ng2[] = {2, 0};
static const char *ng3 = "combinational_gates_muxed_tb.UUT";
static unsigned int ng4[] = {0U, 0U};
static unsigned int ng5[] = {1U, 0U};



static void Initial_31_0(char *t0)
{
    char *t1;

LAB0:    xsi_set_current_line(32, ng0);

LAB2:    xsi_set_current_line(33, ng0);
    xsi_vcd_dumpfile(ng1);
    xsi_set_current_line(34, ng0);
    t1 = ((char*)((ng2)));
    xsi_vcd_dumpvars_args(*((unsigned int *)t1), t0, (char)115, ng3, (char)101);

LAB1:    return;
}

static void Initial_39_1(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(40, ng0);

LAB2:    xsi_set_current_line(41, ng0);
    t1 = ((char*)((ng4)));
    t2 = (t0 + 1448);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 5);

LAB1:    return;
}

static void Always_45_2(char *t0)
{
    char t7[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;

LAB0:    t1 = (t0 + 2864U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 2672);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(46, ng0);
    t3 = (t0 + 1448);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = ((char*)((ng5)));
    memset(t7, 0, 8);
    xsi_vlog_unsigned_add(t7, 5, t5, 5, t6, 5);
    t8 = (t0 + 1448);
    xsi_vlogvar_assign_value(t8, t7, 0, 0, 5);
    goto LAB2;

}

static void Initial_49_3(char *t0)
{
    char *t1;
    char *t2;

LAB0:    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2920);
    xsi_process_wait(t2, 160000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(50, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}


extern void work_m_00000000001135639875_1146624135_init()
{
	static char *pe[] = {(void *)Initial_31_0,(void *)Initial_39_1,(void *)Always_45_2,(void *)Initial_49_3};
	xsi_register_didat("work_m_00000000001135639875_1146624135", "isim/combinational_gates_muxed_tb_isim_beh.exe.sim/work/m_00000000001135639875_1146624135.didat");
	xsi_register_executes(pe);
}
