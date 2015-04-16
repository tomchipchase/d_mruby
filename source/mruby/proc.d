module mruby.proc;

import mruby.mrb_class;
import mruby.object;
import mruby.value;
import mruby.khash;
import mruby;

extern (C):

alias kh_mt kh_mt_t;

struct REnv
{
	enum mrb_vtype
	{
		MRB_TT_FALSE = 0,
		MRB_TT_FREE = 1,
		MRB_TT_TRUE = 2,
		MRB_TT_FIXNUM = 3,
		MRB_TT_SYMBOL = 4,
		MRB_TT_UNDEF = 5,
		MRB_TT_FLOAT = 6,
		MRB_TT_CPTR = 7,
		MRB_TT_OBJECT = 8,
		MRB_TT_CLASS = 9,
		MRB_TT_MODULE = 10,
		MRB_TT_ICLASS = 11,
		MRB_TT_SCLASS = 12,
		MRB_TT_PROC = 13,
		MRB_TT_ARRAY = 14,
		MRB_TT_HASH = 15,
		MRB_TT_STRING = 16,
		MRB_TT_RANGE = 17,
		MRB_TT_EXCEPTION = 18,
		MRB_TT_FILE = 19,
		MRB_TT_ENV = 20,
		MRB_TT_DATA = 21,
		MRB_TT_FIBER = 22,
		MRB_TT_MAXDEFINE = 23
	}
	mrb_vtype tt;
	uint color;
	uint flags;
	RClass* c;
	RBasic* gcnext;
	mrb_value* stack;
	mrb_sym mid;
	ptrdiff_t cioff;
}

struct RProc
{
	enum mrb_vtype
	{
		MRB_TT_FALSE = 0,
		MRB_TT_FREE = 1,
		MRB_TT_TRUE = 2,
		MRB_TT_FIXNUM = 3,
		MRB_TT_SYMBOL = 4,
		MRB_TT_UNDEF = 5,
		MRB_TT_FLOAT = 6,
		MRB_TT_CPTR = 7,
		MRB_TT_OBJECT = 8,
		MRB_TT_CLASS = 9,
		MRB_TT_MODULE = 10,
		MRB_TT_ICLASS = 11,
		MRB_TT_SCLASS = 12,
		MRB_TT_PROC = 13,
		MRB_TT_ARRAY = 14,
		MRB_TT_HASH = 15,
		MRB_TT_STRING = 16,
		MRB_TT_RANGE = 17,
		MRB_TT_EXCEPTION = 18,
		MRB_TT_FILE = 19,
		MRB_TT_ENV = 20,
		MRB_TT_DATA = 21,
		MRB_TT_FIBER = 22,
		MRB_TT_MAXDEFINE = 23
	}
	mrb_vtype tt;
	uint color;
	uint flags;
	RClass* c;
	RBasic* gcnext;
	union
	{
		mrb_irep* irep;
		mrb_func_t func;
	}
	RClass* target_class;
	REnv* env;
}

struct kh_mt
{
	khint_t n_buckets;
	khint_t size;
	khint_t n_occupied;
	ubyte* ed_flags;
	mrb_sym* keys;
	RProc** vals;
}

RProc* mrb_proc_new (mrb_state*, mrb_irep*);
RProc* mrb_closure_new (mrb_state*, mrb_irep*);
RProc* mrb_proc_new_cfunc (mrb_state*, mrb_func_t);
RProc* mrb_closure_new_cfunc (mrb_state* mrb, mrb_func_t func, int nlocals);
void mrb_proc_copy (RProc* a, RProc* b);
mrb_value mrb_f_send (mrb_state* mrb, mrb_value self);
RProc* mrb_proc_new_cfunc_with_env (mrb_state*, mrb_func_t, mrb_int, const(mrb_value)*);
mrb_value mrb_proc_cfunc_env_get (mrb_state*, mrb_int);
void kh_alloc_mt (mrb_state* mrb, kh_mt_t* h);
kh_mt_t* kh_init_mt_size (mrb_state* mrb, khint_t size);
kh_mt_t* kh_init_mt (mrb_state* mrb);
void kh_destroy_mt (mrb_state* mrb, kh_mt_t* h);
void kh_clear_mt (mrb_state* mrb, kh_mt_t* h);
khint_t kh_get_mt (mrb_state* mrb, kh_mt_t* h, mrb_sym key);
khint_t kh_put_mt (mrb_state* mrb, kh_mt_t* h, mrb_sym key, int* ret);
void kh_resize_mt (mrb_state* mrb, kh_mt_t* h, khint_t new_n_buckets);
void kh_del_mt (mrb_state* mrb, kh_mt_t* h, khint_t x);
kh_mt_t* kh_copy_mt (mrb_state* mrb, kh_mt_t* h);
