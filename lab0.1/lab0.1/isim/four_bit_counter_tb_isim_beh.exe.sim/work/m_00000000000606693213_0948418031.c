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
static const char *ng0 = "C:/Users/152/Desktop/team3/CSM152A/lab0.1/src/4_bit_counter.v";
static unsigned int ng1[] = {0U, 0U};



static void Always_4_0(char *t0)
{
    char t13[8];
    char t43[8];
    char t78[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    int t32;
    int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;
    char *t42;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    char *t47;
    char *t48;
    char *t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    char *t57;
    char *t58;
    unsigned int t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    int t67;
    int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    char *t75;
    char *t76;
    char *t77;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    char *t82;
    char *t83;
    char *t84;
    unsigned int t85;
    unsigned int t86;
    unsigned int t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    char *t92;

LAB0:    t1 = (t0 + 3008U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(4, ng0);
    t2 = (t0 + 3328);
    *((int *)t2) = 1;
    t3 = (t0 + 3040);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(4, ng0);

LAB5:    xsi_set_current_line(5, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(10, ng0);

LAB10:    xsi_set_current_line(11, ng0);
    t2 = (t0 + 1608);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t13, 0, 8);
    t5 = (t4 + 4);
    t6 = *((unsigned int *)t5);
    t7 = (~(t6));
    t8 = *((unsigned int *)t4);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB14;

LAB12:    if (*((unsigned int *)t5) == 0)
        goto LAB11;

LAB13:    t11 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t11) = 1;

LAB14:    t12 = (t13 + 4);
    t14 = (t4 + 4);
    t15 = *((unsigned int *)t4);
    t16 = (~(t15));
    *((unsigned int *)t13) = t16;
    *((unsigned int *)t12) = 0;
    if (*((unsigned int *)t14) != 0)
        goto LAB16;

LAB15:    t21 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t21 & 1U);
    t22 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t22 & 1U);
    t23 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t23, t13, 0, 0, 1, 0LL);
    xsi_set_current_line(12, ng0);
    t2 = (t0 + 1608);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1768);
    t11 = (t5 + 56U);
    t12 = *((char **)t11);
    t6 = *((unsigned int *)t4);
    t7 = *((unsigned int *)t12);
    t8 = (t6 ^ t7);
    *((unsigned int *)t13) = t8;
    t14 = (t4 + 4);
    t23 = (t12 + 4);
    t24 = (t13 + 4);
    t9 = *((unsigned int *)t14);
    t10 = *((unsigned int *)t23);
    t15 = (t9 | t10);
    *((unsigned int *)t24) = t15;
    t16 = *((unsigned int *)t24);
    t17 = (t16 != 0);
    if (t17 == 1)
        goto LAB17;

LAB18:
LAB19:    t25 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t25, t13, 0, 0, 1, 0LL);
    xsi_set_current_line(13, ng0);
    t2 = (t0 + 1608);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1768);
    t11 = (t5 + 56U);
    t12 = *((char **)t11);
    t6 = *((unsigned int *)t4);
    t7 = *((unsigned int *)t12);
    t8 = (t6 & t7);
    *((unsigned int *)t13) = t8;
    t14 = (t4 + 4);
    t23 = (t12 + 4);
    t24 = (t13 + 4);
    t9 = *((unsigned int *)t14);
    t10 = *((unsigned int *)t23);
    t15 = (t9 | t10);
    *((unsigned int *)t24) = t15;
    t16 = *((unsigned int *)t24);
    t17 = (t16 != 0);
    if (t17 == 1)
        goto LAB20;

LAB21:
LAB22:    t40 = (t0 + 1928);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t44 = *((unsigned int *)t13);
    t45 = *((unsigned int *)t42);
    t46 = (t44 ^ t45);
    *((unsigned int *)t43) = t46;
    t47 = (t13 + 4);
    t48 = (t42 + 4);
    t49 = (t43 + 4);
    t50 = *((unsigned int *)t47);
    t51 = *((unsigned int *)t48);
    t52 = (t50 | t51);
    *((unsigned int *)t49) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 != 0);
    if (t54 == 1)
        goto LAB23;

LAB24:
LAB25:    t57 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t57, t43, 0, 0, 1, 0LL);
    xsi_set_current_line(14, ng0);
    t2 = (t0 + 1608);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 1768);
    t11 = (t5 + 56U);
    t12 = *((char **)t11);
    t6 = *((unsigned int *)t4);
    t7 = *((unsigned int *)t12);
    t8 = (t6 & t7);
    *((unsigned int *)t13) = t8;
    t14 = (t4 + 4);
    t23 = (t12 + 4);
    t24 = (t13 + 4);
    t9 = *((unsigned int *)t14);
    t10 = *((unsigned int *)t23);
    t15 = (t9 | t10);
    *((unsigned int *)t24) = t15;
    t16 = *((unsigned int *)t24);
    t17 = (t16 != 0);
    if (t17 == 1)
        goto LAB26;

LAB27:
LAB28:    t40 = (t0 + 1928);
    t41 = (t40 + 56U);
    t42 = *((char **)t41);
    t44 = *((unsigned int *)t13);
    t45 = *((unsigned int *)t42);
    t46 = (t44 & t45);
    *((unsigned int *)t43) = t46;
    t47 = (t13 + 4);
    t48 = (t42 + 4);
    t49 = (t43 + 4);
    t50 = *((unsigned int *)t47);
    t51 = *((unsigned int *)t48);
    t52 = (t50 | t51);
    *((unsigned int *)t49) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 != 0);
    if (t54 == 1)
        goto LAB29;

LAB30:
LAB31:    t75 = (t0 + 2088);
    t76 = (t75 + 56U);
    t77 = *((char **)t76);
    t79 = *((unsigned int *)t43);
    t80 = *((unsigned int *)t77);
    t81 = (t79 ^ t80);
    *((unsigned int *)t78) = t81;
    t82 = (t43 + 4);
    t83 = (t77 + 4);
    t84 = (t78 + 4);
    t85 = *((unsigned int *)t82);
    t86 = *((unsigned int *)t83);
    t87 = (t85 | t86);
    *((unsigned int *)t84) = t87;
    t88 = *((unsigned int *)t84);
    t89 = (t88 != 0);
    if (t89 == 1)
        goto LAB32;

LAB33:
LAB34:    t92 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t92, t78, 0, 0, 1, 0LL);

LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(5, ng0);

LAB9:    xsi_set_current_line(6, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 1608);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 1, 0LL);
    xsi_set_current_line(7, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1768);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(8, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    xsi_set_current_line(9, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 2088);
    xsi_vlogvar_wait_assign_value(t3, t2, 0, 0, 1, 0LL);
    goto LAB8;

LAB11:    *((unsigned int *)t13) = 1;
    goto LAB14;

LAB16:    t17 = *((unsigned int *)t13);
    t18 = *((unsigned int *)t14);
    *((unsigned int *)t13) = (t17 | t18);
    t19 = *((unsigned int *)t12);
    t20 = *((unsigned int *)t14);
    *((unsigned int *)t12) = (t19 | t20);
    goto LAB15;

LAB17:    t18 = *((unsigned int *)t13);
    t19 = *((unsigned int *)t24);
    *((unsigned int *)t13) = (t18 | t19);
    goto LAB19;

LAB20:    t18 = *((unsigned int *)t13);
    t19 = *((unsigned int *)t24);
    *((unsigned int *)t13) = (t18 | t19);
    t25 = (t4 + 4);
    t26 = (t12 + 4);
    t20 = *((unsigned int *)t4);
    t21 = (~(t20));
    t22 = *((unsigned int *)t25);
    t27 = (~(t22));
    t28 = *((unsigned int *)t12);
    t29 = (~(t28));
    t30 = *((unsigned int *)t26);
    t31 = (~(t30));
    t32 = (t21 & t27);
    t33 = (t29 & t31);
    t34 = (~(t32));
    t35 = (~(t33));
    t36 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t36 & t34);
    t37 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t37 & t35);
    t38 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t38 & t34);
    t39 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t39 & t35);
    goto LAB22;

LAB23:    t55 = *((unsigned int *)t43);
    t56 = *((unsigned int *)t49);
    *((unsigned int *)t43) = (t55 | t56);
    goto LAB25;

LAB26:    t18 = *((unsigned int *)t13);
    t19 = *((unsigned int *)t24);
    *((unsigned int *)t13) = (t18 | t19);
    t25 = (t4 + 4);
    t26 = (t12 + 4);
    t20 = *((unsigned int *)t4);
    t21 = (~(t20));
    t22 = *((unsigned int *)t25);
    t27 = (~(t22));
    t28 = *((unsigned int *)t12);
    t29 = (~(t28));
    t30 = *((unsigned int *)t26);
    t31 = (~(t30));
    t32 = (t21 & t27);
    t33 = (t29 & t31);
    t34 = (~(t32));
    t35 = (~(t33));
    t36 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t36 & t34);
    t37 = *((unsigned int *)t24);
    *((unsigned int *)t24) = (t37 & t35);
    t38 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t38 & t34);
    t39 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t39 & t35);
    goto LAB28;

LAB29:    t55 = *((unsigned int *)t43);
    t56 = *((unsigned int *)t49);
    *((unsigned int *)t43) = (t55 | t56);
    t57 = (t13 + 4);
    t58 = (t42 + 4);
    t59 = *((unsigned int *)t13);
    t60 = (~(t59));
    t61 = *((unsigned int *)t57);
    t62 = (~(t61));
    t63 = *((unsigned int *)t42);
    t64 = (~(t63));
    t65 = *((unsigned int *)t58);
    t66 = (~(t65));
    t67 = (t60 & t62);
    t68 = (t64 & t66);
    t69 = (~(t67));
    t70 = (~(t68));
    t71 = *((unsigned int *)t49);
    *((unsigned int *)t49) = (t71 & t69);
    t72 = *((unsigned int *)t49);
    *((unsigned int *)t49) = (t72 & t70);
    t73 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t73 & t69);
    t74 = *((unsigned int *)t43);
    *((unsigned int *)t43) = (t74 & t70);
    goto LAB31;

LAB32:    t90 = *((unsigned int *)t78);
    t91 = *((unsigned int *)t84);
    *((unsigned int *)t78) = (t90 | t91);
    goto LAB34;

}


extern void work_m_00000000000606693213_0948418031_init()
{
	static char *pe[] = {(void *)Always_4_0};
	xsi_register_didat("work_m_00000000000606693213_0948418031", "isim/four_bit_counter_tb_isim_beh.exe.sim/work/m_00000000000606693213_0948418031.didat");
	xsi_register_executes(pe);
}
