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
static const char *ng0 = "C:/Users/wrand/Desktop/CSM152A/lab1/src/tb/model_uart.v";
static unsigned int ng1[] = {0U, 0U};
static unsigned int ng2[] = {1U, 0U};
static int ng3[] = {0, 0};
static int ng4[] = {10, 0};
static int ng5[] = {1, 0};
static int ng6[] = {8, 0};
static unsigned int ng7[] = {10U, 0U};
static unsigned int ng8[] = {13U, 0U};
static const char *ng9 = "%d %s Received bytes %08x (%s)";
static int ng10[] = {1095914544, 0, 85, 0};



static int sp_tskRxData(char *t1, char *t2)
{
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1256);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(58, ng0);

LAB5:    xsi_set_current_line(59, ng0);
    t5 = (t2 + 88U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    xsi_wp_set_status(t7, 1);
    *((char **)t3) = &&LAB6;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(60, ng0);
    t4 = (t1 + 2880);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3200);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 8);
    goto LAB4;

}

static int sp_tskTxData(char *t1, char *t2)
{
    char t5[8];
    char t7[8];
    int t0;
    char *t3;
    char *t4;
    char *t6;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1688);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(68, ng0);

LAB5:    xsi_set_current_line(69, ng0);
    t6 = ((char*)((ng1)));
    t8 = (t1 + 3360);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memset(t7, 0, 8);
    t11 = (t7 + 4);
    t12 = (t10 + 4);
    t13 = *((unsigned int *)t10);
    t14 = (t13 >> 0);
    *((unsigned int *)t7) = t14;
    t15 = *((unsigned int *)t12);
    t16 = (t15 >> 0);
    *((unsigned int *)t11) = t16;
    t17 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t17 & 255U);
    t18 = *((unsigned int *)t11);
    *((unsigned int *)t11) = (t18 & 255U);
    t19 = ((char*)((ng2)));
    xsi_vlogtype_concat(t5, 10, 10, 3U, t19, 1, t7, 8, t6, 1);
    t20 = (t1 + 3520);
    xsi_vlogvar_assign_value(t20, t5, 0, 0, 10);
    xsi_set_current_line(70, ng0);
    xsi_set_current_line(70, ng0);
    t4 = ((char*)((ng3)));
    t6 = (t1 + 3680);
    xsi_vlogvar_assign_value(t6, t4, 0, 0, 32);

LAB6:    t4 = (t1 + 3680);
    t6 = (t4 + 56U);
    t8 = *((char **)t6);
    t9 = ((char*)((ng4)));
    memset(t5, 0, 8);
    xsi_vlog_signed_less(t5, 32, t8, 32, t9, 32);
    t10 = (t5 + 4);
    t13 = *((unsigned int *)t10);
    t14 = (~(t13));
    t15 = *((unsigned int *)t5);
    t16 = (t15 & t14);
    t17 = (t16 != 0);
    if (t17 > 0)
        goto LAB7;

LAB8:    xsi_set_current_line(76, ng0);
    t4 = (t1 + 6872);
    xsi_trigger(t4, -1, -1);

LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;

LAB1:    return t0;
LAB7:    xsi_set_current_line(71, ng0);

LAB9:    xsi_set_current_line(72, ng0);
    t11 = (t1 + 3520);
    t12 = (t11 + 56U);
    t19 = *((char **)t12);
    t20 = (t1 + 3520);
    t21 = (t20 + 72U);
    t22 = *((char **)t21);
    t23 = (t1 + 3680);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    xsi_vlog_generic_get_index_select_value(t7, 1, t19, t22, 2, t25, 32, 1);
    t26 = (t1 + 2720);
    xsi_vlogvar_assign_value(t26, t7, 0, 0, 1);
    xsi_set_current_line(73, ng0);
    t4 = (t2 + 56U);
    t6 = *((char **)t4);
    xsi_process_wait(t6, 1000000LL);
    *((char **)t3) = &&LAB10;
    t0 = 1;
    goto LAB1;

LAB10:    xsi_set_current_line(74, ng0);
    t4 = (t1 + 6704);
    xsi_trigger(t4, -1, -1);
    xsi_set_current_line(70, ng0);
    t4 = (t1 + 3680);
    t6 = (t4 + 56U);
    t8 = *((char **)t6);
    t9 = ((char*)((ng5)));
    memset(t5, 0, 8);
    xsi_vlog_signed_add(t5, 32, t8, 32, t9, 32);
    t10 = (t1 + 3680);
    xsi_vlogvar_assign_value(t10, t5, 0, 0, 32);
    goto LAB6;

}

static void Initial_25_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(26, ng0);

LAB2:    xsi_set_current_line(27, ng0);
    t1 = ((char*)((ng2)));
    t2 = (t0 + 2720);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 1);

LAB1:    return;
}

static void Always_30_1(char *t0)
{
    char t12[8];
    char t13[8];
    char t32[8];
    char t44[8];
    char t57[8];
    char t73[8];
    char t81[8];
    char t118[16];
    char t119[8];
    char t131[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    int t9;
    char *t10;
    char *t11;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
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
    unsigned int t30;
    char *t31;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    char *t39;
    char *t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    char *t45;
    char *t46;
    char *t47;
    char *t48;
    char *t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    char *t56;
    char *t58;
    char *t59;
    unsigned int t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    char *t72;
    char *t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    unsigned int t79;
    char *t80;
    unsigned int t82;
    unsigned int t83;
    unsigned int t84;
    char *t85;
    char *t86;
    char *t87;
    unsigned int t88;
    unsigned int t89;
    unsigned int t90;
    unsigned int t91;
    unsigned int t92;
    unsigned int t93;
    unsigned int t94;
    char *t95;
    char *t96;
    unsigned int t97;
    unsigned int t98;
    unsigned int t99;
    unsigned int t100;
    unsigned int t101;
    unsigned int t102;
    unsigned int t103;
    unsigned int t104;
    int t105;
    unsigned int t106;
    unsigned int t107;
    unsigned int t108;
    unsigned int t109;
    unsigned int t110;
    unsigned int t111;
    char *t112;
    unsigned int t113;
    unsigned int t114;
    unsigned int t115;
    unsigned int t116;
    unsigned int t117;
    char *t120;
    char *t121;
    char *t122;
    char *t123;
    char *t124;
    unsigned int t125;
    unsigned int t126;
    unsigned int t127;
    unsigned int t128;
    unsigned int t129;
    unsigned int t130;
    char *t132;
    char *t133;
    char *t134;
    char *t135;
    char *t136;
    unsigned int t137;
    unsigned int t138;
    unsigned int t139;
    unsigned int t140;
    unsigned int t141;
    unsigned int t142;
    char *t143;

LAB0:    t1 = (t0 + 4848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(30, ng0);
    t2 = (t0 + 5168);
    *((int *)t2) = 1;
    t3 = (t0 + 4880);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(31, ng0);

LAB5:    xsi_set_current_line(32, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 2880);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 8);
    xsi_set_current_line(33, ng0);
    t2 = (t0 + 4656);
    xsi_process_wait(t2, 500000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(35, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t2 + 4);
    t6 = *((unsigned int *)t3);
    t7 = (~(t6));
    t8 = *((unsigned int *)t2);
    t9 = (t8 & t7);
    t4 = (t0 + 7616);
    *((int *)t4) = t9;

LAB7:    t5 = (t0 + 7616);
    if (*((int *)t5) > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 2880);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t12, 0, 8);
    t5 = (t12 + 4);
    t10 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 0);
    *((unsigned int *)t12) = t7;
    t8 = *((unsigned int *)t10);
    t14 = (t8 >> 0);
    *((unsigned int *)t5) = t14;
    t15 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t15 & 255U);
    t16 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t16 & 255U);
    t11 = ((char*)((ng7)));
    memset(t13, 0, 8);
    t17 = (t12 + 4);
    t18 = (t11 + 4);
    t19 = *((unsigned int *)t12);
    t20 = *((unsigned int *)t11);
    t21 = (t19 ^ t20);
    t22 = *((unsigned int *)t17);
    t23 = *((unsigned int *)t18);
    t24 = (t22 ^ t23);
    t25 = (t21 | t24);
    t26 = *((unsigned int *)t17);
    t27 = *((unsigned int *)t18);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t25 & t29);
    if (t30 != 0)
        goto LAB13;

LAB12:    if (t28 != 0)
        goto LAB14;

LAB15:    memset(t32, 0, 8);
    t33 = (t13 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (~(t34));
    t36 = *((unsigned int *)t13);
    t37 = (t36 & t35);
    t38 = (t37 & 1U);
    if (t38 != 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t33) != 0)
        goto LAB18;

LAB19:    t40 = (t32 + 4);
    t41 = *((unsigned int *)t32);
    t42 = *((unsigned int *)t40);
    t43 = (t41 || t42);
    if (t43 > 0)
        goto LAB20;

LAB21:    memcpy(t81, t32, 8);

LAB22:    t112 = (t81 + 4);
    t113 = *((unsigned int *)t112);
    t114 = (~(t113));
    t115 = *((unsigned int *)t81);
    t116 = (t115 & t114);
    t117 = (t116 != 0);
    if (t117 > 0)
        goto LAB34;

LAB35:    xsi_set_current_line(46, ng0);

LAB38:    xsi_set_current_line(47, ng0);
    t2 = (t0 + 2880);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t12, 0, 8);
    t5 = (t12 + 4);
    t10 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 0);
    *((unsigned int *)t12) = t7;
    t8 = *((unsigned int *)t10);
    t14 = (t8 >> 0);
    *((unsigned int *)t5) = t14;
    t15 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t15 & 255U);
    t16 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t16 & 255U);
    t11 = ((char*)((ng8)));
    memset(t13, 0, 8);
    t17 = (t12 + 4);
    t18 = (t11 + 4);
    t19 = *((unsigned int *)t12);
    t20 = *((unsigned int *)t11);
    t21 = (t19 ^ t20);
    t22 = *((unsigned int *)t17);
    t23 = *((unsigned int *)t18);
    t24 = (t22 ^ t23);
    t25 = (t21 | t24);
    t26 = *((unsigned int *)t17);
    t27 = *((unsigned int *)t18);
    t28 = (t26 | t27);
    t29 = (~(t28));
    t30 = (t25 & t29);
    if (t30 != 0)
        goto LAB42;

LAB39:    if (t28 != 0)
        goto LAB41;

LAB40:    *((unsigned int *)t13) = 1;

LAB42:    t33 = (t13 + 4);
    t34 = *((unsigned int *)t33);
    t35 = (~(t34));
    t36 = *((unsigned int *)t13);
    t37 = (t36 & t35);
    t38 = (t37 != 0);
    if (t38 > 0)
        goto LAB43;

LAB44:
LAB45:
LAB36:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 6536);
    xsi_trigger(t2, -1, -1);
    goto LAB2;

LAB8:    xsi_set_current_line(36, ng0);

LAB10:    xsi_set_current_line(37, ng0);
    t10 = (t0 + 4656);
    xsi_process_wait(t10, 1000000LL);
    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB11:    xsi_set_current_line(37, ng0);
    t11 = (t0 + 6368);
    xsi_trigger(t11, -1, -1);
    xsi_set_current_line(39, ng0);
    t2 = (t0 + 2880);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    memset(t13, 0, 8);
    t5 = (t13 + 4);
    t10 = (t4 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (t6 >> 1);
    *((unsigned int *)t13) = t7;
    t8 = *((unsigned int *)t10);
    t14 = (t8 >> 1);
    *((unsigned int *)t5) = t14;
    t15 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t15 & 127U);
    t16 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t16 & 127U);
    t11 = (t0 + 2320U);
    t17 = *((char **)t11);
    xsi_vlogtype_concat(t12, 8, 8, 2U, t17, 1, t13, 7);
    t11 = (t0 + 2880);
    xsi_vlogvar_assign_value(t11, t12, 0, 0, 8);
    t2 = (t0 + 7616);
    t9 = *((int *)t2);
    *((int *)t2) = (t9 - 1);
    goto LAB7;

LAB13:    *((unsigned int *)t13) = 1;
    goto LAB15;

LAB14:    t31 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t31) = 1;
    goto LAB15;

LAB16:    *((unsigned int *)t32) = 1;
    goto LAB19;

LAB18:    t39 = (t32 + 4);
    *((unsigned int *)t32) = 1;
    *((unsigned int *)t39) = 1;
    goto LAB19;

LAB20:    t45 = (t0 + 2880);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    memset(t44, 0, 8);
    t48 = (t44 + 4);
    t49 = (t47 + 4);
    t50 = *((unsigned int *)t47);
    t51 = (t50 >> 0);
    *((unsigned int *)t44) = t51;
    t52 = *((unsigned int *)t49);
    t53 = (t52 >> 0);
    *((unsigned int *)t48) = t53;
    t54 = *((unsigned int *)t44);
    *((unsigned int *)t44) = (t54 & 255U);
    t55 = *((unsigned int *)t48);
    *((unsigned int *)t48) = (t55 & 255U);
    t56 = ((char*)((ng8)));
    memset(t57, 0, 8);
    t58 = (t44 + 4);
    t59 = (t56 + 4);
    t60 = *((unsigned int *)t44);
    t61 = *((unsigned int *)t56);
    t62 = (t60 ^ t61);
    t63 = *((unsigned int *)t58);
    t64 = *((unsigned int *)t59);
    t65 = (t63 ^ t64);
    t66 = (t62 | t65);
    t67 = *((unsigned int *)t58);
    t68 = *((unsigned int *)t59);
    t69 = (t67 | t68);
    t70 = (~(t69));
    t71 = (t66 & t70);
    if (t71 != 0)
        goto LAB24;

LAB23:    if (t69 != 0)
        goto LAB25;

LAB26:    memset(t73, 0, 8);
    t74 = (t57 + 4);
    t75 = *((unsigned int *)t74);
    t76 = (~(t75));
    t77 = *((unsigned int *)t57);
    t78 = (t77 & t76);
    t79 = (t78 & 1U);
    if (t79 != 0)
        goto LAB27;

LAB28:    if (*((unsigned int *)t74) != 0)
        goto LAB29;

LAB30:    t82 = *((unsigned int *)t32);
    t83 = *((unsigned int *)t73);
    t84 = (t82 & t83);
    *((unsigned int *)t81) = t84;
    t85 = (t32 + 4);
    t86 = (t73 + 4);
    t87 = (t81 + 4);
    t88 = *((unsigned int *)t85);
    t89 = *((unsigned int *)t86);
    t90 = (t88 | t89);
    *((unsigned int *)t87) = t90;
    t91 = *((unsigned int *)t87);
    t92 = (t91 != 0);
    if (t92 == 1)
        goto LAB31;

LAB32:
LAB33:    goto LAB22;

LAB24:    *((unsigned int *)t57) = 1;
    goto LAB26;

LAB25:    t72 = (t57 + 4);
    *((unsigned int *)t57) = 1;
    *((unsigned int *)t72) = 1;
    goto LAB26;

LAB27:    *((unsigned int *)t73) = 1;
    goto LAB30;

LAB29:    t80 = (t73 + 4);
    *((unsigned int *)t73) = 1;
    *((unsigned int *)t80) = 1;
    goto LAB30;

LAB31:    t93 = *((unsigned int *)t81);
    t94 = *((unsigned int *)t87);
    *((unsigned int *)t81) = (t93 | t94);
    t95 = (t32 + 4);
    t96 = (t73 + 4);
    t97 = *((unsigned int *)t32);
    t98 = (~(t97));
    t99 = *((unsigned int *)t95);
    t100 = (~(t99));
    t101 = *((unsigned int *)t73);
    t102 = (~(t101));
    t103 = *((unsigned int *)t96);
    t104 = (~(t103));
    t9 = (t98 & t100);
    t105 = (t102 & t104);
    t106 = (~(t9));
    t107 = (~(t105));
    t108 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t108 & t106);
    t109 = *((unsigned int *)t87);
    *((unsigned int *)t87) = (t109 & t107);
    t110 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t110 & t106);
    t111 = *((unsigned int *)t81);
    *((unsigned int *)t81) = (t111 & t107);
    goto LAB33;

LAB34:    xsi_set_current_line(42, ng0);

LAB37:    xsi_set_current_line(43, ng0);
    t120 = (t0 + 2880);
    t121 = (t120 + 56U);
    t122 = *((char **)t121);
    memset(t119, 0, 8);
    t123 = (t119 + 4);
    t124 = (t122 + 4);
    t125 = *((unsigned int *)t122);
    t126 = (t125 >> 0);
    *((unsigned int *)t119) = t126;
    t127 = *((unsigned int *)t124);
    t128 = (t127 >> 0);
    *((unsigned int *)t123) = t128;
    t129 = *((unsigned int *)t119);
    *((unsigned int *)t119) = (t129 & 255U);
    t130 = *((unsigned int *)t123);
    *((unsigned int *)t123) = (t130 & 255U);
    t132 = (t0 + 3040);
    t133 = (t132 + 56U);
    t134 = *((char **)t133);
    memset(t131, 0, 8);
    t135 = (t131 + 4);
    t136 = (t134 + 4);
    t137 = *((unsigned int *)t134);
    t138 = (t137 >> 0);
    *((unsigned int *)t131) = t138;
    t139 = *((unsigned int *)t136);
    t140 = (t139 >> 0);
    *((unsigned int *)t135) = t140;
    t141 = *((unsigned int *)t131);
    *((unsigned int *)t131) = (t141 & 33554431U);
    t142 = *((unsigned int *)t135);
    *((unsigned int *)t135) = (t142 & 33554431U);
    xsi_vlogtype_concat(t118, 33, 33, 2U, t131, 25, t119, 8);
    t143 = (t0 + 3040);
    xsi_vlogvar_assign_value(t143, t118, 0, 0, 32);
    goto LAB36;

LAB41:    t31 = (t13 + 4);
    *((unsigned int *)t13) = 1;
    *((unsigned int *)t31) = 1;
    goto LAB42;

LAB43:    xsi_set_current_line(48, ng0);

LAB46:    xsi_set_current_line(49, ng0);
    *((int *)t32) = xsi_vlog_stime(1000.0000000000000, 1000.0000000000000);
    t39 = (t32 + 4);
    *((int *)t39) = 0;
    t40 = ((char*)((ng10)));
    t45 = (t0 + 3040);
    t46 = (t45 + 56U);
    t47 = *((char **)t46);
    t48 = (t0 + 3040);
    t49 = (t48 + 56U);
    t56 = *((char **)t49);
    xsi_vlogfile_write(1, 0, 0, ng9, 5, t0, (char)118, t32, 32, (char)118, t40, 40, (char)118, t47, 32, (char)118, t56, 32);
    goto LAB45;

}


extern void work_m_00000000003251465842_1746683258_init()
{
	static char *pe[] = {(void *)Initial_25_0,(void *)Always_30_1};
	static char *se[] = {(void *)sp_tskRxData,(void *)sp_tskTxData};
	xsi_register_didat("work_m_00000000003251465842_1746683258", "isim/tb_isim_beh.exe.sim/work/m_00000000003251465842_1746683258.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
