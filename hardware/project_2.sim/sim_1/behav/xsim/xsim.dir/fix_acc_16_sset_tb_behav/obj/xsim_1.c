/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_325(char*, char *);
extern void execute_326(char*, char *);
extern void execute_327(char*, char *);
extern void execute_332(char*, char *);
extern void execute_57(char*, char *);
extern void execute_58(char*, char *);
extern void execute_323(char*, char *);
extern void execute_92(char*, char *);
extern void execute_93(char*, char *);
extern void execute_316(char*, char *);
extern void execute_69(char*, char *);
extern void execute_73(char*, char *);
extern void execute_84(char*, char *);
extern void execute_86(char*, char *);
extern void execute_90(char*, char *);
extern void execute_97(char*, char *);
extern void execute_100(char*, char *);
extern void execute_106(char*, char *);
extern void execute_108(char*, char *);
extern void execute_110(char*, char *);
extern void execute_112(char*, char *);
extern void execute_116(char*, char *);
extern void execute_119(char*, char *);
extern void execute_124(char*, char *);
extern void execute_126(char*, char *);
extern void execute_128(char*, char *);
extern void execute_130(char*, char *);
extern void execute_313(char*, char *);
extern void execute_314(char*, char *);
extern void execute_145(char*, char *);
extern void execute_149(char*, char *);
extern void execute_148(char*, char *);
extern void execute_151(char*, char *);
extern void execute_156(char*, char *);
extern void execute_158(char*, char *);
extern void execute_161(char*, char *);
extern void execute_164(char*, char *);
extern void execute_168(char*, char *);
extern void execute_170(char*, char *);
extern void execute_171(char*, char *);
extern void execute_172(char*, char *);
extern void execute_177(char*, char *);
extern void execute_180(char*, char *);
extern void execute_182(char*, char *);
extern void execute_186(char*, char *);
extern void execute_188(char*, char *);
extern void execute_194(char*, char *);
extern void execute_227(char*, char *);
extern void execute_228(char*, char *);
extern void execute_231(char*, char *);
extern void execute_222(char*, char *);
extern void execute_200(char*, char *);
extern void execute_204(char*, char *);
extern void execute_206(char*, char *);
extern void execute_211(char*, char *);
extern void execute_215(char*, char *);
extern void execute_221(char*, char *);
extern void execute_217(char*, char *);
extern void execute_218(char*, char *);
extern void execute_219(char*, char *);
extern void execute_233(char*, char *);
extern void execute_235(char*, char *);
extern void execute_329(char*, char *);
extern void execute_330(char*, char *);
extern void execute_331(char*, char *);
extern void execute_333(char*, char *);
extern void execute_334(char*, char *);
extern void execute_335(char*, char *);
extern void execute_336(char*, char *);
extern void execute_337(char*, char *);
extern void transaction_5(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_7(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_1(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_2(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_3(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_4(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[79] = {(funcp)execute_325, (funcp)execute_326, (funcp)execute_327, (funcp)execute_332, (funcp)execute_57, (funcp)execute_58, (funcp)execute_323, (funcp)execute_92, (funcp)execute_93, (funcp)execute_316, (funcp)execute_69, (funcp)execute_73, (funcp)execute_84, (funcp)execute_86, (funcp)execute_90, (funcp)execute_97, (funcp)execute_100, (funcp)execute_106, (funcp)execute_108, (funcp)execute_110, (funcp)execute_112, (funcp)execute_116, (funcp)execute_119, (funcp)execute_124, (funcp)execute_126, (funcp)execute_128, (funcp)execute_130, (funcp)execute_313, (funcp)execute_314, (funcp)execute_145, (funcp)execute_149, (funcp)execute_148, (funcp)execute_151, (funcp)execute_156, (funcp)execute_158, (funcp)execute_161, (funcp)execute_164, (funcp)execute_168, (funcp)execute_170, (funcp)execute_171, (funcp)execute_172, (funcp)execute_177, (funcp)execute_180, (funcp)execute_182, (funcp)execute_186, (funcp)execute_188, (funcp)execute_194, (funcp)execute_227, (funcp)execute_228, (funcp)execute_231, (funcp)execute_222, (funcp)execute_200, (funcp)execute_204, (funcp)execute_206, (funcp)execute_211, (funcp)execute_215, (funcp)execute_221, (funcp)execute_217, (funcp)execute_218, (funcp)execute_219, (funcp)execute_233, (funcp)execute_235, (funcp)execute_329, (funcp)execute_330, (funcp)execute_331, (funcp)execute_333, (funcp)execute_334, (funcp)execute_335, (funcp)execute_336, (funcp)execute_337, (funcp)transaction_5, (funcp)transaction_7, (funcp)vhdl_transfunc_eventcallback, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_0, (funcp)transaction_1, (funcp)transaction_2, (funcp)transaction_3, (funcp)transaction_4};
const int NumRelocateId= 79;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/fix_acc_16_sset_tb_behav/xsim.reloc",  (void **)funcTab, 79);
	iki_vhdl_file_variable_register(dp + 41072);
	iki_vhdl_file_variable_register(dp + 41128);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/fix_acc_16_sset_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/fix_acc_16_sset_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

	iki_vlog_schedule_transaction_signal_fast_vhdl_value_time_0(dp + 47344, dp + 45920, 0, 15, 0, 15, 16, 1);
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/fix_acc_16_sset_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/fix_acc_16_sset_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/fix_acc_16_sset_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
