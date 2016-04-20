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
static const char *ng0 = "/home/suman/My/SEM4/Sem4/CS226Lab/inficoders/Design/Dispenser_top.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_3488546069778340532_503743352(char *, unsigned char , unsigned char );


static void work_a_0189745530_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(256, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 992U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 8672);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(258, ng0);
    t1 = (t0 + 15184);
    t6 = (t0 + 8768);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 6U);
    xsi_driver_first_trans_fast_port(t6);
    xsi_set_current_line(259, ng0);
    t1 = (t0 + 15190);
    t5 = (t0 + 8832);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 6U);
    xsi_driver_first_trans_fast_port(t5);
    goto LAB3;

LAB5:    xsi_set_current_line(261, ng0);
    t2 = (t0 + 4712U);
    t5 = *((char **)t2);
    t2 = (t0 + 15196);
    t4 = 1;
    if (4U == 4U)
        goto LAB10;

LAB11:    t4 = 0;

LAB12:    if (t4 != 0)
        goto LAB7;

LAB9:    t1 = (t0 + 4712U);
    t2 = *((char **)t1);
    t1 = (t0 + 15200);
    t3 = 1;
    if (4U == 4U)
        goto LAB18;

LAB19:    t3 = 0;

LAB20:    if (t3 != 0)
        goto LAB16;

LAB17:    t1 = (t0 + 4712U);
    t2 = *((char **)t1);
    t1 = (t0 + 15204);
    t3 = 1;
    if (4U == 4U)
        goto LAB26;

LAB27:    t3 = 0;

LAB28:    if (t3 != 0)
        goto LAB24;

LAB25:    t1 = (t0 + 4712U);
    t2 = *((char **)t1);
    t1 = (t0 + 15208);
    t3 = 1;
    if (4U == 4U)
        goto LAB34;

LAB35:    t3 = 0;

LAB36:    if (t3 != 0)
        goto LAB32;

LAB33:
LAB8:    goto LAB3;

LAB7:    xsi_set_current_line(263, ng0);
    t9 = (t0 + 5672U);
    t10 = *((char **)t9);
    t9 = (t0 + 8768);
    t12 = (t9 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t10, 6U);
    xsi_driver_first_trans_fast_port(t9);
    xsi_set_current_line(264, ng0);
    t1 = (t0 + 5832U);
    t2 = *((char **)t1);
    t1 = (t0 + 8832);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 6U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB8;

LAB10:    t11 = 0;

LAB13:    if (t11 < 4U)
        goto LAB14;
    else
        goto LAB12;

LAB14:    t7 = (t5 + t11);
    t8 = (t2 + t11);
    if (*((unsigned char *)t7) != *((unsigned char *)t8))
        goto LAB11;

LAB15:    t11 = (t11 + 1);
    goto LAB13;

LAB16:    xsi_set_current_line(267, ng0);
    t8 = (t0 + 5992U);
    t9 = *((char **)t8);
    t8 = (t0 + 8768);
    t10 = (t8 + 56U);
    t12 = *((char **)t10);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t9, 6U);
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(268, ng0);
    t1 = (t0 + 6152U);
    t2 = *((char **)t1);
    t1 = (t0 + 8832);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 6U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB8;

LAB18:    t11 = 0;

LAB21:    if (t11 < 4U)
        goto LAB22;
    else
        goto LAB20;

LAB22:    t6 = (t2 + t11);
    t7 = (t1 + t11);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB19;

LAB23:    t11 = (t11 + 1);
    goto LAB21;

LAB24:    xsi_set_current_line(271, ng0);
    t8 = (t0 + 6312U);
    t9 = *((char **)t8);
    t8 = (t0 + 8768);
    t10 = (t8 + 56U);
    t12 = *((char **)t10);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t9, 6U);
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(272, ng0);
    t1 = (t0 + 6472U);
    t2 = *((char **)t1);
    t1 = (t0 + 8832);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 6U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB8;

LAB26:    t11 = 0;

LAB29:    if (t11 < 4U)
        goto LAB30;
    else
        goto LAB28;

LAB30:    t6 = (t2 + t11);
    t7 = (t1 + t11);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB27;

LAB31:    t11 = (t11 + 1);
    goto LAB29;

LAB32:    xsi_set_current_line(275, ng0);
    t8 = (t0 + 6632U);
    t9 = *((char **)t8);
    t8 = (t0 + 8768);
    t10 = (t8 + 56U);
    t12 = *((char **)t10);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t9, 6U);
    xsi_driver_first_trans_fast_port(t8);
    xsi_set_current_line(276, ng0);
    t1 = (t0 + 6792U);
    t2 = *((char **)t1);
    t1 = (t0 + 8832);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 6U);
    xsi_driver_first_trans_fast_port(t1);
    goto LAB8;

LAB34:    t11 = 0;

LAB37:    if (t11 < 4U)
        goto LAB38;
    else
        goto LAB36;

LAB38:    t6 = (t2 + t11);
    t7 = (t1 + t11);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB35;

LAB39:    t11 = (t11 + 1);
    goto LAB37;

}

static void work_a_0189745530_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(176, ng0);

LAB3:    t1 = (t0 + 4072U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 4232U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t3, t5);
    t1 = (t0 + 4392U);
    t7 = *((char **)t1);
    t8 = *((unsigned char *)t7);
    t9 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t6, t8);
    t1 = (t0 + 4552U);
    t10 = *((char **)t1);
    t11 = *((unsigned char *)t10);
    t12 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t9, t11);
    t1 = (t0 + 8896);
    t13 = (t1 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = t12;
    xsi_driver_first_trans_fast(t1);

LAB2:    t17 = (t0 + 8688);
    *((int *)t17) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0189745530_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0189745530_3212880686_p_0,(void *)work_a_0189745530_3212880686_p_1};
	xsi_register_didat("work_a_0189745530_3212880686", "isim/top_tb_isim_beh.exe.sim/work/a_0189745530_3212880686.didat");
	xsi_register_executes(pe);
}
