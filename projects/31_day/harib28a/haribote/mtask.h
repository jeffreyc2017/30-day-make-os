#ifndef _MTASK_H
#define _MTASK_H

#define MAX_TASKS		1000	/* 最大タスク数 */
#define TASK_GDT0		3		/* TSSをGDTの何番から割り当てるのか */
#define MAX_TASKS_LV	100
#define MAX_TASKLEVELS	10
struct TSS32 {
	int backlink, esp0, ss0, esp1, ss1, esp2, ss2, cr3;
	int eip, eflags, eax, ecx, edx, ebx, esp, ebp, esi, edi;
	int es, cs, ss, ds, fs, gs;
	int ldtr, iomap;
};
struct TASK {
	int sel, flags; /* selはGDTの番号のこと */
	int level, priority;
	struct FIFO32 fifo;
	struct TSS32 tss;
	struct SEGMENT_DESCRIPTOR ldt[2];
	struct CONSOLE *cons;
	int ds_base, cons_stack;
	struct FILEHANDLE *fhandle;
	int *fat;
	char *cmdline;
	unsigned char langmode, langbyte1;
};
struct TASKLEVEL {
	int running; /* 動作しているタスクの数 */
	int now; /* 現在動作しているタスクがどれだか分かるようにするための変数 */
	struct TASK *tasks[MAX_TASKS_LV];
};
struct TASKCTL {
	int now_lv; /* 現在動作中のレベル */
	char lv_change; /* 次回タスクスイッチのときに、レベルも変えたほうがいいかどうか */
	struct TASKLEVEL level[MAX_TASKLEVELS];
	struct TASK tasks0[MAX_TASKS];
};
extern struct TASKCTL *taskctl;
extern struct TIMER *task_timer;
struct TASK *task_now(void);
struct TASK *task_init(struct MEMMAN *memman);
struct TASK *task_alloc(void);
void task_run(struct TASK *task, int level, int priority);
void task_switch(void);
void task_sleep(struct TASK *task);

#endif
